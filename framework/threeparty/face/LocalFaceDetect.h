//
//  LocalFaceDetect.h
//  framework
//
//  Created by 黄成实 on 2018/7/5.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalFaceDetect : NSObject

+(void)detectLocalImage:(UIImage *)image success:(void (^)(id))success failure:(void (^)(id))failure;
+(void)requestBaiduToken;

@end
