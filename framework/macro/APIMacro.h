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
#define TestUrl @"http://192.168.0.5:8081/cellos-appserver"


#pragma mark 登录

//获取验证码
#define URL_GETVERIFYCODE       [TestUrl stringByAppendingString:@"/user/login/smsCode"]
//测试验证码
#define URL_TESTCODE            [TestUrl stringByAppendingString:@"/user/login/testCode"]
//登录
#define URL_LOGIN               [TestUrl stringByAppendingString:@"/user/login/smsLogin"]
//登出
#define URL_LOGOUT              [TestUrl stringByAppendingString:@"/user/logout"]

#pragma mark 获取用户资料

//获取账户信息
#define URL_GETUSERINFO         [TestUrl stringByAppendingString:@"/user/getUserInfo"]
//获取居住信息
#define URL_GETLIVEINFO         [TestUrl stringByAppendingString:@"/user/getLiveInfo"]
//获取主页信息
#define URL_GETMAININFO         [TestUrl stringByAppendingString:@"/userMainPage/getDistrictDetailInfo"]

#pragma mark 完善用户信息

//小区定位
#define URL_GETCOMMUNITYPOSITION [TestUrl stringByAppendingString:@"/user/getDistrictByPosition"]
//小区楼栋查询
#define URL_GETCOMMUNITYLAYER    [TestUrl stringByAppendingString:@"/user/getDistrictLayer"]
//小区门牌查询
#define URL_GETCOMMUNITYDOOR     [TestUrl stringByAppendingString:@"/user/getDistrictLayerByQueryString"]
//小区名称模糊查询
#define URL_GETCOMMUNITYQUERY    [TestUrl stringByAppendingString:@"/user/getDistrictByQueryString"]
//录入用户信息
#define URL_UPLOADUSERINFO       [TestUrl stringByAppendingString:@"/user/checkInUserInfo"]
//催办
#define URL_REMIND               [TestUrl stringByAppendingString:@"/user/remind"]

#pragma mark 家庭成员管理

//获取家庭成员
#define URL_GETFAMILY_MEMBER    [TestUrl stringByAppendingString:@"/familyManagement/getFamilyMember"]
//添加家庭成员
#define URL_ADDFAMILY_MEMBER    [TestUrl stringByAppendingString:@"/familyManagement/addFamilyMember"]
//删除家庭成员
#define URL_DELFAMILY_MEMBER    [TestUrl stringByAppendingString:@"/familyManagement/delFamilyMember"]
//更新家庭成员
#define URL_UPDATEFAMILY_MEMBER [TestUrl stringByAppendingString:@"/familyManagement/updateFamilyMember"]


#pragma mark 住户管理

//获取住户信息
#define URL_GET_HABITANT         [TestUrl stringByAppendingString:@"/liveuserManagement/getLiveuser"]
//删除住户
#define URL_DELETE_HABITANT      [TestUrl stringByAppendingString:@"/liveuserManagement/delLiveuserWithOverdue"]
//修改住户有效期
#define URL_UPDATE_HABITANT      [TestUrl stringByAppendingString:@"/liveuserManagement/updateLiveuserWithOverdue"]



#pragma mark 上传图片
#define URL_UPLOAD_IMAGE @"http://192.168.0.4:9090/upload"


#pragma mark 通用码
//请求成功
#define STATU_SUCCESS @"0"
//用户鉴权失败
#define STATU_USERAUTH_FAIL  401
//用户未认证
#define STATU_LIVEINFO_NULL @"101010301"
//正在审核中
#define STATU_LIVEINFO_AUTHING @"101010302"
//房屋门牌号没有完全匹配
#define STATU_DOOR_NULL @"10001010003"


