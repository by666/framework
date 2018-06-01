//
//  MessageModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/30.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel

+(NSMutableArray *)getTestDatas{
    NSMutableArray *datas = [[NSMutableArray alloc]init];
    [datas addObject:[self buildModel:@"访客进入申请" subTitle:@"杨过正在等待您的门禁授权" timestamp:@"05-30 13:56" messageType:VisitorEnter messageStatu:DefaultStatu content:@"杨过"]];
    [datas addObject:[self buildModel:@"访客进入申请" subTitle:@"黄蓉正在等待您的门禁授权" timestamp:@"05-28 09:26" messageType:VisitorEnter messageStatu:Expired content:@"黄蓉"]];
    [datas addObject:[self buildModel:@"访客进入申请" subTitle:@"郭襄正在等待您的门禁授权" timestamp:@"05-26 23:11" messageType:VisitorEnter messageStatu:Granted content:@"郭襄"]];
    [datas addObject:[self buildModel:@"访客进入申请" subTitle:@"郭靖正在等待您的门禁授权" timestamp:@"05-28 12:56" messageType:VisitorEnter messageStatu:Reject content:@"郭靖"]];
    
    [datas addObject:[self buildModel:@"车辆进入申请" subTitle:@"黄药师正在等待您的车闸授权" timestamp:@"05-30 13:56" messageType:CarEnter messageStatu:DefaultStatu content:@"黄药师|粤B23423"]];
    [datas addObject:[self buildModel:@"车辆进入申请" subTitle:@"欧阳锋正在等待您的车闸授权" timestamp:@"05-28 09:26" messageType:CarEnter messageStatu:Expired content:@"欧阳锋|粤BC3423"]];
    [datas addObject:[self buildModel:@"车辆进入申请" subTitle:@"洪七公正在等待您的车闸授权" timestamp:@"05-26 23:11" messageType:CarEnter messageStatu:Granted content:@"洪七公|粤BF34SS"]];
    [datas addObject:[self buildModel:@"车辆进入申请" subTitle:@"周伯通正在等待您的车闸授权" timestamp:@"05-28 12:56" messageType:CarEnter messageStatu:Reject content:@"周伯通|粤B87SF2"]];

    [datas addObject:[self buildModel:@"用户认证请求" subTitle:@"pony申请认证为您房屋的租客，请及时处理" timestamp:@"05-28 12:56" messageType:UserAuth messageStatu:DefaultStatu content:@"pony"]];
    [datas addObject:[self buildModel:@"用户认证请求" subTitle:@"狗蛋申请认证为您房屋的租客，请及时处理" timestamp:@"05-28 12:56" messageType:UserAuth messageStatu:Expired content:@"狗蛋"]];
    [datas addObject:[self buildModel:@"用户认证请求" subTitle:@"肥龙申请认证为您房屋的租客，请及时处理" timestamp:@"05-28 12:56" messageType:UserAuth messageStatu:Granted content:@"肥龙"]];
    [datas addObject:[self buildModel:@"用户认证请求" subTitle:@"扑街申请认证为您房屋的租客，请及时处理" timestamp:@"05-28 12:56" messageType:UserAuth messageStatu:Reject content:@"扑街"]];

    return datas;
}


+(MessageModel *)buildModel:(NSString *)title subTitle:(NSString *)subTitle timestamp:(NSString *)timestamp messageType:(MessageType)type messageStatu:(MessageStatu)statu content:(NSString *)content{
    MessageModel *model = [[MessageModel alloc]init];
    model.title = title;
    model.subTitle = subTitle;
    model.timestamp = timestamp;
    model.messageType = type;
    model.messageStatu = statu;
    model.content = content;
    return model;
}

+(NSString *)translateType:(MessageType)type{
    return @"";
}

+(NSString *)translateStatu:(MessageStatu)statu{
    NSString *result = @"";
    switch (statu) {
        case Granted:
            result = @"已授权";
            break;
        case Reject:
            result = @"已拒绝";
            break;
        case Expired:
            result = @"已过期";
            break;
        default:
            break;
    }
    return result;
}

@end
