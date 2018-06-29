//
//  STTimeUtil.m
//  gogo
//
//  Created by by.huang on 2017/11/5.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "STTimeUtil.h"

@implementation STTimeUtil

+(NSString *)generateAll : (NSString *)timestamp{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY年MM月dd日 HH:mm"];
    
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timestamp doubleValue]/ 1000.0];
    NSString* dateStr = [formatter stringFromDate:date];
    return dateStr;
}

+(NSString *)generateDate : (NSString *)timestamp{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY年MM月dd日"];
    
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timestamp doubleValue]/ 1000.0];
    NSString* dateStr = [formatter stringFromDate:date];
    return dateStr;
}

+(NSString *)generateDate2 : (NSString *)timestamp{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY.MM.dd"];
    
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timestamp doubleValue]/ 1000.0];
    NSString* dateStr = [formatter stringFromDate:date];
    return dateStr;
}

+(NSString *)generateTime : (NSString *)timestamp{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"HH:mm"];
    
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timestamp doubleValue]/ 1000.0];
    NSString* timeString = [formatter stringFromDate:date];
    return timeString;
}

+(NSString *)getTomorrowDate{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval timeInterval=[dat timeIntervalSince1970]*1000;
    timeInterval += 3600 * 24 * 1000;
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY.MM.dd"];
    
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:timeInterval / 1000.0];
    NSString* dateStr = [formatter stringFromDate:date];
    return dateStr;
}

+(NSString *)formateTime : (NSString *)timestamp{
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval createTime = [timestamp longLongValue]/1000;
    NSTimeInterval time = currentTime - createTime;
    long sec = time/60;
    if(sec == 0){
        return @"刚刚";
    }
    
    if (sec<60) {
        return [NSString stringWithFormat:@"%ld分钟前",sec];
    }
    
    // 秒转小时
    NSInteger hours = time/3600;
    if (hours<24) {
        return [NSString stringWithFormat:@"%ld小时前",hours];
    }
    //秒转天数
    NSInteger days = time/3600/24;
    if (days < 30) {
        return [NSString stringWithFormat:@"%ld天前",days];
    }
    //秒转月
    NSInteger months = time/3600/24/30;
    if (months < 12) {
        return [NSString stringWithFormat:@"%ld月前",months];
    }
    //秒转年
    NSInteger years = time/3600/24/30/12;
    return [NSString stringWithFormat:@"%ld年前",years];
}

+(NSString *)getCurrentTimeStamp{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    return [NSString stringWithFormat:@"%f", a];
}

+(NSString *)getTimeStampWithDays:(int)days{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    a += 3600 * 24 * 1000 * days;
    return [NSString stringWithFormat:@"%f", a];
}


+(NSString *)getCurrentWeek:(NSDate *)date{
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
    [dataFormatter setDateFormat:@"YYYY年MM月dd日"];
    NSDateComponents *componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSCalendarUnitWeekday fromDate:date];
    NSInteger weekday = [componets weekday];
    NSArray *weekArray = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    return weekArray[weekday-1];
}


+(NSMutableArray *)getOneWeeks{
    NSMutableArray *datas =[[NSMutableArray alloc]init];
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval timeInterval=[dat timeIntervalSince1970]*1000;
    for(int i = 0 ; i < 7 ; i ++){
        timeInterval += 3600 * 24 * 1000;
        NSDate* date = [NSDate dateWithTimeIntervalSince1970:timeInterval / 1000.0];
        NSString *dateStr = [self generateDate:[NSString stringWithFormat:@"%.f",timeInterval]];
        NSString *weakStr = [self getCurrentWeek:date];
        dateStr = [dateStr substringWithRange:NSMakeRange(5, dateStr.length - 5)];
        NSString *result = [NSString stringWithFormat:@"%@ %@",dateStr,weakStr];
        [datas addObject:result];
        [STLog print:result];
    }
    return datas;
}


+(long)getTimeStamp:(NSString *)dateStr format:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    NSDate* date = [formatter dateFromString:dateStr];
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    return (long)timeSp;
}

@end
