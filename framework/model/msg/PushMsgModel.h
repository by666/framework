//
//  PushMsgModel.h
//  framework
//
//  Created by 黄成实 on 2018/8/3.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PushMsgModel : NSObject

//0：收到用户认证请求，1：临时访客申请，2：收取用户认证结果，3：token失效
@property(assign, nonatomic)int serviceType;
//0 :业主  1：物业
@property(assign, nonatomic)int appType;
@property(copy, nonatomic)NSString *alert;
@property(copy, nonatomic)NSString *title;
@property(copy, nonatomic)NSString *content;
@property(copy, nonatomic)NSString *messageId;


@end
