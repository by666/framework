//
//  MessageModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/30.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject


//消息id
@property(assign, nonatomic)long mid;
//消息类型
@property(assign, nonatomic)MessageType messageType;
//消息标题
@property(copy, nonatomic)NSString *title;
//消息副标题
@property(copy, nonatomic)NSString *subTitle;
//消息内容
@property(copy, nonatomic)NSString *content;
//消息发送时间
@property(copy, nonatomic)NSString *timestamp;
//消息状态
@property(assign, nonatomic)MessageStatu messageStatu;

+(NSMutableArray *)getTestDatas;

+(NSString *)translateType:(MessageType)type;
+(NSString *)translateStatu:(MessageStatu)statu;

@end
