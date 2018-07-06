//
//  LocalFaceDetect.m
//  framework
//
//  Created by 黄成实 on 2018/7/5.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "LocalFaceDetect.h"
#import "STNetUtil.h"
#import "STConvertUtil.h"
#import <AFNetworking/AFNetworking.h>
#import "STUserDefaults.h"
@implementation LocalFaceDetect


+(void)detectLocalImage:(UIImage *)image success:(void (^)(id))success failure:(void (^)(id))failure{
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    
    NSString *base64Str = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"image"] = base64Str;
    dic[@"image_type"] = @"BASE64";

    NSString *accessToken = [STUserDefaults getKeyValue:UD_BAIDUAK];
    NSString *url = [NSString stringWithFormat:@"https://aip.baidubce.com/rest/2.0/face/v3/detect?access_token=%@",accessToken];
    [STNetUtil postImage:url content:[dic mj_JSONString] success:^(id responseObject) {
        NSArray *faceList =  [responseObject objectForKey:@"face_list"];
        if(!IS_NS_COLLECTION_EMPTY(faceList)){
            id dic  = [faceList objectAtIndex:0];
            double faceProbability =  [[dic objectForKey:@"face_probability"] doubleValue];
            if(faceProbability > 0.95f){
                success(responseObject);
                return;
            }else{
                failure(MSG_FACEDETECT_PROBILITY);
                return;
            }
        }
        failure(MSG_FACEDETECT_FAIL);
    } failure:^(id error) {
        failure(error);
    }];
}

+(void)requestBaiduToken{
    NSString *requestUrl = @"https://aip.baidubce.com/oauth/2.0/token?grant_type=client_credentials&client_id=pEox3ol4wx0X3kmCos8IB5GY&client_secret=jh0hG0vX32sUNFORh2yLjSyvUAKPhtoj";
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    //content-type
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/xml",@"text/html", nil ];
    
    //get
    [manager GET:requestUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingMutableLeaves) error:nil];
        NSString *access_token = [dic objectForKey:@"access_token"];
        [STUserDefaults saveKeyValue:UD_BAIDUAK value:access_token];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
