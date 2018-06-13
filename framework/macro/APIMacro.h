//
//  APIMacro.h
//  framework
//
//  Created by 黄成实 on 2018/4/17.
//  Copyright © 2018年 黄成实. All rights reserved.
//



#import <Foundation/Foundation.h>

#pragma mark 定义API相关

#define RootUrl @"https://www.baidu.com"
#define TestUrl @"http://192.168.0.4:8081/cellos-appserver"


#pragma mark 登录

//获取验证码
#define URL_GETVERIFYCODE       [TestUrl stringByAppendingString:@"/user/login/smsCode"]
//测试验证码
#define URL_TESTCODE            [TestUrl stringByAppendingString:@"/user/login/testCode"]
//登录
#define URL_LOGIN               [TestUrl stringByAppendingString:@"/user/login/smsLogin"]


#pragma mark 获取用户资料

//获取账户信息
#define URL_GETUSERINFO         [TestUrl stringByAppendingString:@"/user/getUserInfo"]
//获取居住信息
#define URL_GETLIVEINFO         [TestUrl stringByAppendingString:@"/user/getLiveInfo"]


#pragma mark 完善用户信息

//小区定位
#define URL_GETCOMMUNITYPOSITION [TestUrl stringByAppendingString:@"/user/getDistrictByPosition"]
//小区楼栋查询
#define URL_GETCOMMUNITYLAYER    [TestUrl stringByAppendingString:@"/user/getDistrictLayer"]



#pragma mark 家庭成员管理

//获取家庭成员
#define URL_GETFAMILY_MEMBER    [TestUrl stringByAppendingString:@"/familyManagement/getFamilyMember"]
//添加家庭成员
#define URL_ADDFAMILY_MEMBER    [TestUrl stringByAppendingString:@"/familyManagement/addFamilyMember"]
//删除家庭成员
#define URL_DELFAMILY_MEMBER    [TestUrl stringByAppendingString:@"/familyManagement/delFamilyMember"]
//更新家庭成员
#define URL_UPDATEFAMILY_MEMBER [TestUrl stringByAppendingString:@"/familyManagement/updateFamilyMember"]



#pragma mark 通用码
#define STATU_SUCCESS @"0"
#define STATU_LIVEINFO_NULL @"101010301"
