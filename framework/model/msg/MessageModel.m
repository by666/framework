//
//  MessageModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/30.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MessageModel.h"
#import "STTimeUtil.h"

@implementation MessageModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"mid": @"id"};
}



+(MessageType)translateType:(int)applyType{
    if(applyType == 0 || applyType == 1 || applyType == 2 ){
        return UserAuth;
    }
    if(applyType == 3){
        return VisitorEnter;
    }
    return DefaultMessage;
}


+(NSString *)translateStatu:(int)applyState overdueDate:(NSString *)overdueDate{
    NSString *result = @"";
    long nowTimeStamp = [[STTimeUtil getCurrentTimeStamp] longLongValue] / 1000;
    long visitTimeStamp = [STTimeUtil getTimeStamp:overdueDate format:@"yyyy-MM-dd HH:mm:ss"];
    if(visitTimeStamp - nowTimeStamp < 0){
        result = @"已过期";
        return result;
    }
    switch (applyState) {
        case Granted:
            result = @"已授权";
            break;
        case Reject:
            result = @"已拒绝";
            break;
//        case Expired:
//            result = @"已过期";
//            break;
        default:
            break;
    }
    return result;
}

@end
