//
//  STUploadImageUtil.m
//  framework
//
//  Created by 黄成实 on 2018/6/28.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "STUploadImageUtil.h"
#import "STTimeUtil.h"
#import "STUploadImageModel.h"
#import "STDataBaseUtil.h"

#define BucketName @"santaihulian"
#define EndPoint @"https://oss-cn-shenzhen.aliyuncs.com"
#define AccessKeyId @"LTAIgAxC5iDCnS6R"
#define AccessKeySecret @"yTZscLQVNZUB6WaWFXiUgajSRe7NaZ"


#define Path_User_Face @"user-face/"
#define FaceImageTable @"faceimg"

@interface STUploadImageUtil()

@property(strong, nonatomic)OSSClient *client;
@property(strong, nonatomic)NSMutableArray *imageCaches;

@end

@implementation STUploadImageUtil
SINGLETON_IMPLEMENTION(STUploadImageUtil)


#pragma mark 初始化OSS
-(void)initOSS{
    _imageCaches = [[NSMutableArray alloc]init];
    // 移动端建议使用STS方式初始化OSSClient。可以通过sample中STS使用说明了解更多(https://github.com/aliyun/aliyun-oss-ios-sdk/tree/master/DemoByOC)
    id<OSSCredentialProvider> credential = [[OSSPlainTextAKSKPairCredentialProvider alloc]initWithPlainTextAccessKey:AccessKeyId secretKey:AccessKeySecret];
    _client = [[OSSClient alloc] initWithEndpoint:EndPoint credentialProvider:credential];
    [[STDataBaseUtil sharedSTDataBaseUtil]createTable:FaceImageTable model:[STUploadImageModel class]];
}


#pragma mark 获取图片Url
-(NSString *)getRealUrl2:(NSString *)objectKey{
    if(IS_NS_STRING_EMPTY(objectKey)){
        [STLog print:@"获取图片资源失败,objectKey为nil"];
        return nil;
    }
    NSString *saveUrl = [self isImageExpires:objectKey];
    if(!IS_NS_STRING_EMPTY(saveUrl)){
        return saveUrl;
    }
    NSString * constrainURL = nil;
    OSSTask * task = [_client presignConstrainURLWithBucketName:BucketName
                                                  withObjectKey:objectKey
                                         withExpirationInterval: 60 * 60 * 60];
    if (!task.error) {
        constrainURL = task.result;
        [STLog print:@"当前图片地址" content:constrainURL];
        [self saveImage:objectKey readUrl:constrainURL];
    } else {
        NSLog(@"error: %@", task.error);
    }
    return constrainURL;
}


#pragma mark 获取图片Url
-(NSURL *)getRealUrl:(NSString *)objectKey{
    if(IS_NS_STRING_EMPTY(objectKey)){
        [STLog print:@"获取图片资源失败,objectKey为nil"];
        return nil;
    }
    //从缓存中获取图片地址
    NSString *saveUrl = [self isImageExpires:objectKey];
    if(!IS_NS_STRING_EMPTY(saveUrl)){
        [STLog print:@"从内存中取到image url"];
        return [NSURL URLWithString:saveUrl];
    }
    //从数据库中获取图片地址
    saveUrl = [self getImageUrlFromDB:objectKey];
    if(!IS_NS_STRING_EMPTY(saveUrl)){
        [STLog print:@"从数据库中取到image url"];
        return [NSURL URLWithString:saveUrl];
    }
    NSString * constrainURL = nil;
    OSSTask * task = [_client presignConstrainURLWithBucketName:BucketName
                                                  withObjectKey:objectKey
                                        withExpirationInterval: 60 * 60 * 60];
    if (!task.error) {
        constrainURL = task.result;
        [STLog print:@"当前图片地址" content:constrainURL];
        [self saveImage:objectKey readUrl:constrainURL];
    } else {
        NSLog(@"error: %@", task.error);
    }
    return [NSURL URLWithString:constrainURL];
}

-(void)uploadImageForOSS:(NSString *)filePath success:(void (^)(NSString *))success failure:(void (^)(NSString *))failure{
    [self uploadImageForOSS:(NSString *)filePath success:success failure:failure progress:nil];
}


#pragma mark OSS上传图片
-(void)uploadImageForOSS:(NSString *)filePath success:(void (^)(NSString *))success failure:(void (^)(NSString *))failure progress:(void(^)(double))progress{
    if(_client == nil){
        [STLog print:@"Oss未初始化"];
        return;
    }
    NSString *objectKey = [NSString stringWithFormat:@"%@.jpg",[STTimeUtil getCurrentTimeStamp]];
    objectKey = [NSString stringWithFormat:@"%@%@",Path_User_Face,objectKey];;
    OSSPutObjectRequest * request = [OSSPutObjectRequest new];
    request.bucketName = BucketName;
    request.objectKey = objectKey;
    request.uploadingFileURL = [NSURL fileURLWithPath:filePath];
    if(progress){
        request.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
            dispatch_main_sync_safe(^{
                progress((double)totalByteSent * 100 / (double)totalBytesExpectedToSend);
            });
        };
    }
    OSSTask * task = [_client putObject:request];
    [task continueWithBlock:^id(OSSTask *task) {
        if (task.error) {
            OSSLogError(@"%@", task.error);
            dispatch_main_async_safe(^{
                failure(@"上传失败!");
            });
        } else {
            OSSPutObjectResult * result = task.result;
            [STLog print:[NSString stringWithFormat:@"Result - requestId: %@, headerFields: %@",
                          result.requestId,
                          result.httpResponseHeaderFields]];
            [STLog print:@"图片真实地址"  content:[self getRealUrl2:objectKey]];
            dispatch_main_async_safe(^{
                success(objectKey);
            });
        }
        return nil;
    }];
}

#pragma mark 从数据库中取出图片url
-(NSString *)getImageUrlFromDB:(NSString *)objectKey{
    NSMutableArray *datas =  [[STDataBaseUtil sharedSTDataBaseUtil] queryAll:FaceImageTable model:[STUploadImageModel class]];
    if(!IS_NS_COLLECTION_EMPTY(datas)){
        for(NSDictionary *dic in datas){
            STUploadImageModel *model = [STUploadImageModel mj_objectWithKeyValues:dic];
            if([model.objectKey isEqualToString:objectKey]){
                if([model.Expires longLongValue] > [model.imageTimeStamp longLongValue]){
                    [_imageCaches addObject:model];
                    return model.realUrl;
                }
            }
        }
    }
    return @"";
}

#pragma mark 从内存中取出图片url
-(NSString *)isImageExpires:(NSString *)objectKey{
    if(!IS_NS_COLLECTION_EMPTY(_imageCaches)){
        for(STUploadImageModel *model in _imageCaches){
            if([model.objectKey isEqualToString:objectKey]){
                if([model.Expires longLongValue] > [model.imageTimeStamp longLongValue]){
                    return model.realUrl;
                }
            }
        }
    }
    return @"";
}

#pragma mark 缓存图片
-(void)saveImage:(NSString *)objectKey readUrl:(NSString *)realUrl{
    STUploadImageModel *model = [[STUploadImageModel alloc]init];
    model.objectKey = objectKey;
    model.realUrl = realUrl;
    if(![objectKey containsString:Path_User_Face]){
        [STLog print:@"缓存图片失败"];
        return;
    }
    NSString *imageTsStr = [objectKey substringWithRange:NSMakeRange(Path_User_Face.length, objectKey.length - Path_User_Face.length - 4)];
    model.imageTimeStamp = [NSString stringWithFormat:@"%lld",[imageTsStr longLongValue] / 1000];
    
    NSInteger start = [self getEndPositionInString:realUrl key:@"&Expires="];
    model.Expires = [NSString stringWithFormat:@"%lld",[[realUrl substringWithRange:NSMakeRange(start, 11)] longLongValue]];
    
    if(start == -1){
        return;
    }
    [_imageCaches addObject:model];
    [[STDataBaseUtil sharedSTDataBaseUtil] insertRow:FaceImageTable model:model];
}


-(NSInteger)getEndPositionInString:(NSString *)str key:(NSString *)key{
    NSRange range = [str rangeOfString:key];
    if (range.location != NSNotFound) {
        return range.location + key.length;
    }
    return -1;

}

@end
