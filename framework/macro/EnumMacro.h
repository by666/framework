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
    UserAuth,        //业主接收到的用户认证消息(用户接收到的认证结果消息)
};

//消息状态
typedef NS_ENUM(NSInteger,MessageStatu){
    DefaultStatu = 0,//默认
    Granted,         //已授权
    Reject,          //已拒绝
    Expired,         //已过期
};

//推送消息
typedef NS_ENUM(NSInteger, PushMsgType){
    Push_Auth = 0,//0：收到用户认证请求
    Push_Visitor, //1：临时访客申请
    Push_AuthResult,//2：收取用户认证结果
    Push_Other_Login,//3：其他地方登陆
    Push_FACE_ADD,//4：face++进底片库结果

};


//申请类型:0,业主申请; 1:家属申请; 2:租客申请; 3:访客门禁申请

typedef NS_ENUM(NSInteger,LIVEATRR){
    Live_Owner = 0, //业主
    Live_Member = 1,//家属
    Live_Renter = 2, //租客
    Live_Door = 3
};


//人脸识别提醒状态
typedef NS_ENUM(NSUInteger,WarningStatus){
    CommonStatus,
    PoseStatus,
    occlusionStatus
};


//催办状态
typedef NS_ENUM(NSInteger, AttendStatu){
    //用户未催办
    PropertyAttend = 0,
    //用户已催办
    UserAttend = 1
};


//审批状态
typedef NS_ENUM(NSInteger,ApplyStatu){
    //未处理
    APPLY_DEFAULT = 0,
    //审批通过
    APPLY_PASS,
    //审批未通过
    APPLY_REJECT,
    //审批中
    APPLYING,
};

