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
////消息状态
//@property(assign, nonatomic)MessageStatu messageStatu;


@property(copy, nonatomic)NSString *userUid;
@property(copy, nonatomic)NSString *userName;
@property(copy, nonatomic)NSString *receiverUid;
@property(copy, nonatomic)NSString *homeLocator;
@property(assign, nonatomic)int applyType;
@property(copy, nonatomic)NSString *licenseNum;
@property(assign, nonatomic)int applyState;
@property(copy, nonatomic)NSString *overdueDate;
@property(copy, nonatomic)NSString *handleUid;
@property(assign, nonatomic)int visualFlag;
@property(copy, nonatomic)NSString *createTime;
@property(copy, nonatomic)NSString *modifyTime;
@property(copy, nonatomic)NSString *handleDesc;


+(MessageType)translateType:(int)applyType;
+(NSString *)translateStatu:(int)applyState overdueDate:(NSString *)overdueDate;

@end
