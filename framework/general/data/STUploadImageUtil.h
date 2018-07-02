//
//  STUploadImageUtil.h
//  framework
//
//  Created by 黄成实 on 2018/6/28.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AliyunOSSiOS/OSSService.h>

@interface STUploadImageUtil : NSObject
SINGLETON_DECLARATION(STUploadImageUtil)

//初始化OSS
-(void)initOSS;

//通过objectKey拿到真实的图片url
-(NSURL *)getRealUrl:(NSString *)objectKey;

-(void)uploadImageForOSS:(NSString *)filePath success:(void (^)(NSString *))success failure:(void (^)(NSString *))failure;

//上传图片
-(void)uploadImageForOSS:(NSString *)filePath success:(void (^)(NSString *))success failure:(void (^)(NSString *))failure progress:(void(^)(double))progress;



@end
