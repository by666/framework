//
//  EnumMacro.h
//  framework
//
//  Created by by.huang on 2018/5/23.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,VisitorType){
    People = 0,
    Car
};


//用户认证30天过期，门禁1天过期
typedef NS_ENUM(NSInteger,MessageType){
    DefaultMessage = 0, //默认消息
    Property,        //物业消息
    System,          //系统消息
    VisitorEnter,    //访客门禁申请消息
    CarEnter,        //车辆申请消息
    UserAuth,        //用户认证消息
};

typedef NS_ENUM(NSInteger,MessageStatu){
    DefaultStatu = 0,//默认
    Granted,         //已授权
    Expired,         //已过期
    Reject           //已拒绝
    
};

typedef NS_ENUM(NSInteger,LIVEATRR){
    Live_Owner = 1, //业主
    Live_Member = 2,//家属
    Live_Renter = 3 //租客
};


typedef NS_ENUM(NSUInteger,WarningStatus){
    CommonStatus,
    PoseStatus,
    occlusionStatus
};


