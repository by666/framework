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
#import "LocalFaceDetectModel.h"
#import "STFileUtil.h"
#import "STTimeUtil.h"
static int count;
static int count1;
static int count2;
static int count3;
static int count4;
static int failcount;

@implementation LocalFaceDetect


+(void)detectLocalImage:(UIImage *)image success:(void (^)(id))success failure:(void (^)(id))failure{
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    
    NSString *base64Str = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"image"] = base64Str;
    dic[@"image_type"] = @"BASE64";
    dic[@"max_face_num"] = @"10";
    dic[@"face_type"] = @"LIVE";
    dic[@"face_field"] = @"age,beauty,expression,face_shape,gender,glasses,landmark,race,quality,face_type";

    NSString *accessToken = [STUserDefaults getKeyValue:UD_BAIDUAK];
    NSString *url = [NSString stringWithFormat:@"https://aip.baidubce.com/rest/2.0/face/v3/detect?access_token=%@",accessToken];
    [STNetUtil postImage:url content:[dic mj_JSONString] success:^(id responseObject) {
        
        NSArray *faceList =  [responseObject objectForKey:@"face_list"];
        if(!IS_NS_COLLECTION_EMPTY(faceList)){
            count++;
            [STLog print:@"识别图片" content:[NSString stringWithFormat:@"%d张",count]];
            if([faceList count] > 1){
                [STFileUtil saveImageFile:[NSString stringWithFormat:@"/mutiple/%@.jpg",[STTimeUtil getCurrentTimeStamp]] image:image];
                failure(MSG_FACEDETECT_MUTIPLE);
                count1++;
                [STLog print:@"多人脸图片" content:[NSString stringWithFormat:@"%d张",count1]];
                return;
            }else{
                id dic  = [faceList objectAtIndex:0];
                LocalFaceDetectModel *model = [LocalFaceDetectModel mj_objectWithKeyValues:dic];
                model.location = [LocalFacePositionModel mj_objectWithKeyValues:model.location];
                model.angle = [LocalFaceAngleModel mj_objectWithKeyValues:model.angle];
                
                LocalFaceItemModel *expression = [LocalFaceItemModel mj_objectWithKeyValues:model.expression];
                LocalFaceItemModel *gender = [LocalFaceItemModel mj_objectWithKeyValues:model.gender];
                LocalFaceItemModel *glasses = [LocalFaceItemModel mj_objectWithKeyValues:model.glasses];
                LocalFaceItemModel *race = [LocalFaceItemModel mj_objectWithKeyValues:model.race];
                LocalFaceItemModel *face_shape = [LocalFaceItemModel mj_objectWithKeyValues:model.face_shape];
                
                double pitch = fabs(model.angle.pitch);
                double yaw = fabs(model.angle.yaw);
                double roll = fabs(model.angle.roll);
                
                [STLog print:@"人脸角度" content:[NSString stringWithFormat:@"pitch=%.2f,yaw=%.2f,roll=%.2f",pitch,yaw,roll]];
                [STLog print:@"人脸可信度" content:[NSString stringWithFormat:@"face_probability=%.2f",model.face_probability]];
                [STLog print:@"年龄" content:[NSString stringWithFormat:@"age=%d",model.age]];
                [STLog print:@"美颜" content:[NSString stringWithFormat:@"beaty=%.2f",model.beauty]];
                [STLog print:@"表情" content:[NSString stringWithFormat:@"%@(%.2f)",expression.type,expression.probability]];
                [STLog print:@"性别" content:[NSString stringWithFormat:@"%@(%.f)",gender.type,gender.probability]];
                [STLog print:@"眼镜" content:[NSString stringWithFormat:@"%@(%.2f)",glasses.type,glasses.probability]];
                [STLog print:@"人种" content:[NSString stringWithFormat:@"%@(%.2f)",race.type,race.probability]];
                [STLog print:@"脸型" content:[NSString stringWithFormat:@"%@(%.2f)",face_shape.type,face_shape.probability]];

                if(model.face_probability < 0.95f){
                    [STFileUtil saveImageFile:[NSString stringWithFormat:@"/probility/%@.jpg",[STTimeUtil getCurrentTimeStamp]] image:image];
                    failure(MSG_FACEDETECT_PROBILITY);
                    count3++;
                    [STLog print:@"图片质量不合格" content:[NSString stringWithFormat:@"%d张",count3]];
                    return;
                }
                if( pitch >= 6  || yaw >=  2 || roll >= 6 ){
                    [STFileUtil saveImageFile:[NSString stringWithFormat:@"/degree/%@.jpg",[STTimeUtil getCurrentTimeStamp]] image:image];
                    failure(MSG_FACEDETECT_ANGLE);
                    count2++;
                    [STLog print:@"角度过大图片" content:[NSString stringWithFormat:@"%d张",count2]];
                    return;
                }
                success(responseObject);
            }
        }else{
            [STFileUtil saveImageFile:[NSString stringWithFormat:@"/fail/%@.jpg",[STTimeUtil getCurrentTimeStamp]] image:image];
            count4++;
            [STLog print:@"未识别到人脸" content:[NSString stringWithFormat:@"%d张",count4]];
            failure(MSG_FACEDETECT_FAIL);
        }
    } failure:^(id error) {
        [STFileUtil saveImageFile:[NSString stringWithFormat:@"/error/%@.jpg",[STTimeUtil getCurrentTimeStamp]] image:image];
        failcount++;
        [STLog print:@"失败图片" content:[NSString stringWithFormat:@"%d张",failcount]];
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
