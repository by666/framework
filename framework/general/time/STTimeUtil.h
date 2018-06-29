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

#pragma mark 格式化日期（YYYY年MM月dd日）
+(NSString *)generateDate : (NSString *)timestamp;

#pragma mark 格式化时间（YYYY.MM.dd)
+(NSString *)generateDate2 : (NSString *)timestamp;

#pragma mark 格式化时间（HH:mm）
+(NSString *)generateTime : (NSString *)timestamp;

#pragma mark 格式化时间（x秒前，x分前...）
+(NSString *)formateTime : (NSString *)timestamp;

#pragma mark 获取当前时间戳
+(NSString *)getCurrentTimeStamp;

#pragma mark 获取几天后的时间戳
+(NSString *)getTimeStampWithDays:(int)days;

#pragma mark 获取明天的日期
+(NSString *)getTomorrowDate;

#pragma mark 获取今天星期几
+(NSString *)getCurrentWeek:(NSDate *)date;

#pragma mark 获取从今天开始一周
+(NSMutableArray *)getOneWeeks;

#pragma mark 讲日期转为时间戳
+(long)getTimeStamp:(NSString *)dateStr format:(NSString *)format;

@end
