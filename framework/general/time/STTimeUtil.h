//
//  STTimeUtil.h
//  gogo
//
//  Created by by.huang on 2017/11/5.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STTimeUtil : NSObject

#pragma mark 格式化时间（YYYY年MM月dd日 HH:mm）
+(NSString *)generateAll : (NSString *)timestamp;

#pragma mark 格式化日期（MM月dd日）
+(NSString *)generateData : (NSString *)timestamp;

#pragma mark 格式化时间（HH:mm）
+(NSString *)generateTime : (NSString *)timestamp;

#pragma mark 格式化时间（x秒前，x分前...）
+(NSString *)formateTime : (NSString *)timestamp;

@end