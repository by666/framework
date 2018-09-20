//
//  APIMacro.h
//  framework
//
//  Created by 黄成实 on 2018/4/17.
//  Copyright © 2018年 黄成实. All rights reserved.
//



#import <Foundation/Foundation.h>

#pragma mark 定义API相关

//#define TestUrl @"https://cellos.santaihulian.com/cellos-appserver/userApp"
#define TestUrl @"http://192.168.0.5:8081/cellos-appserver/userApp"


#pragma mark 登录

//获取验证码
#define URL_GETVERIFYCODE       [TestUrl stringByAppendingString:@"/user/login/smsCode"]
//测试验证码
#define URL_TESTCODE            [TestUrl stringByAppendingString:@"/user/login/testCode"]
//登录
#define URL_LOGIN               [TestUrl stringByAppendingString:@"/user/login/smsLogin"]
//登出
#define URL_LOGOUT              [TestUrl stringByAppendingString:@"/user/logout"]
//人脸登录
#define URL_FACE_LOGIN          [TestUrl stringByAppendingString:@"/user/login/faceLogin"]
//微信登录
#define URL_WX_LOGIN            [TestUrl stringByAppendingString:@"/user/login/wxLogin"]

#pragma mark 获取用户资料

//获取账户信息
#define URL_GETUSERINFO         [TestUrl stringByAppendingString:@"/user/getUserInfo"]
//获取居住信息
#define URL_GETLIVEINFO         [TestUrl stringByAppendingString:@"/user/getLiveInfo"]
//获取主页信息
#define URL_GETMAININFO         [TestUrl stringByAppendingString:@"/userMainPage/getDistrictDetailInfo"]
//更新自己的人脸
#define URL_UPDATEFACE          [TestUrl stringByAppendingString:@"/user/updateFaceUrl"]

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


#pragma mark 访客/车辆登记

//手机开门
#define URL_OPENDOOR           [TestUrl stringByAppendingString:@"/userMainPage/viewPwd"]
//预登记访客/车辆
#define URL_PRECHECKIN         [TestUrl stringByAppendingString:@"/usercheckIn/preCheckIn"]
//查询预登记访客/车辆
#define URL_PRECHECKIN_HISTORY [TestUrl stringByAppendingString:@"/usercheckIn/getCheckIn"]
//删除预登记访客/车辆
#define URL_DELETE_PRECHECKIN  [TestUrl stringByAppendingString:@"/usercheckIn/delCheckIn"]
//访客通行记录
#define URL_CHECKIN_HISTORY    [TestUrl stringByAppendingString:@"/usercheckIn/getCheckInHistory"]

#pragma mark 上传图片
#define URL_UPLOAD_IMAGE @"http://192.168.0.4:9090/upload"



#pragma mark 修改手机号
//旧手机发短信
#define URL_SENDMSG_TO_OLD [TestUrl stringByAppendingString:@"/user/sendSmsCodeToNewMobile"]
//新绑定手机发短信
#define URL_SENDMSG_TO_NEW [TestUrl stringByAppendingString:@"/user/sendSmsCodeToOldMobile"]
//验证旧手机短信
#define URL_VERIFYMSG_TO_OLD  [TestUrl stringByAppendingString:@"/user/validateOldMobile"]
//验证新手机短信
#define URL_VERIFYMSG_TO_NEW  [TestUrl stringByAppendingString:@"/user/validateNewMobile"]


#pragma mark 功能消息
//获取功能消息列表
#define URL_GET_MESSAGELIST  [TestUrl stringByAppendingString:@"/message/getUserFunctionMessageList"]
//获取长住用户申请详情
#define URL_GET_MESSAGE_APPLY  [TestUrl stringByAppendingString:@"/message/getUserAuthenticationApplyDetailInfo"]
//获取临时访客申请详情
#define URL_GET_MESSAGE_VISITOR [TestUrl stringByAppendingString:@"/message/getVisitorRequestDetailInfo"]
//审批长住用户申请
#define URL_POST_MESSAGE_APPLY   [TestUrl stringByAppendingString:@"/message/handleUserAuthenticationApply"]
//审批临时访客申请
#define URL_POST_MESSAGE_VISITOR [TestUrl stringByAppendingString:@"/message/handleVisitorRequest"]

#pragma mark 验证身份测试
#define URL_VERIFY_USER [TestUrl stringByAppendingString:@"/user/testPassManageApply"]


/*------------------------------------------------------------------------*/


#pragma mark 网络错误码

//用户鉴权失败
#define STATU_USERAUTH_FAIL  200
#define STATU_SERVER_FAIL  500

#pragma mark 通用码

//接口有误
#define STATU_ERRORURL -99
//无网络
#define STATU_NONET -1
//请求成功
#define STATU_SUCCESS @"0"
//未知错误
#define STATU_UNKONOW @"1"
//参数错误
#define STATU_PARAMEROOR @"2"
//header错误（相当于token无效）
#define STATU_INVAILDTOKEN @"3"





#pragma mark 用户注册登录
/**手机验证码**/

//频率被限制
#define STATU_VRIFY_SEND_LIMIT @"10001001003"
//手机号格式有误
#define STATU_VRIFY_PHONE_FORMAT_EROOR @"10001001002"
//发送过快
#define STATU_VRIFY_SEND_TOOFAST @"10001001003"


/**登录**/

//验证码错误
#define STATU_LOGIN_VERIFYCODE_ERROR @"10001002001"
//手机格式错误
#define STATU_LOGIN_PHONE_FORMAT_EROOR @"10001002002"


/**微信登录**/
#define STATU_WXLOGN_NOT_BINDPHONE  @"30001001001"
#define STATU_WXLOGN_HAS_BINDPHONE  @"30001001001"
#define STATU_WXLOGN_CODE_USED @"20001001001"

/**人脸登录**/

//用户没有录入图片
#define STATU_FACELOGIN_NO_HEAD @"10001015001"


#pragma mark 用户信息
/**长住信息**/

//无长住和审核信息
#define STATU_LIVEINFO_NO_INFO @"10001003001"
//仅有审核信息
#define STATU_LIVEINFO_HAS_REVIEW_INFO @"10001003002"

/**小区信息**/

//小区信息不存在
#define STATU_DISTRICT_NO_INFO @"10006001001"


/**催办**/

//已经审核过
#define STATU_APPLY_HAS_REVIEW @"10001004001"
//已经催办过
#define STATU_APPLY_HAS_APPLY @"10001004002"
//没有审核记录
#define STATU_APPLY_NO_RECORD @"10001004003"



#pragma mark 录入信息

/**录入个人信息**/

//定位房子错误
#define STATU_CHECKIN_POSITION_ERROR @"10001007001"
//已经在房屋有记录错误(不通过)
#define STATU_CHECKIN_HAS_RECORD @"10001007002"
//业主与预留信息不符(审核)
#define STATU_CHECKIN_DIFF_OWNNER_INFO @"10001007003"
//此房已经有业主(不通过)
#define STATU_CHECKIN_HAS_OWNNER @"10001007004"
//已经申请过该房子(不通过)
#define STATU_CHECKIN_HAS_APPLY @"10001007005"
//身份证重复(不通过)
#define STATU_CHECKIN_COMMON_IDNUM @"10001007006"


//房屋门牌号没有完全匹配
#define STATU_CHECKIN_DOOR_NULL @"10001010003"


/**小区楼栋房屋模糊查询**/

//小区不存在错误
#define STATU_BUILDING_NOT_EXIT @"10001010001"
//参数格式错误
#define STATU_BUILDING_PARAM_ERROR @"10001012002"
//没有完全匹配错误
#define STATU_BUILDING_NO_MATCH @"10001012003"


/**小区房屋层级查询**/

//小区不存在错误
#define STATU_LAYER_NOT_EXIT @"10001010001"


#pragma mark 修改手机号


/**修改手机号**/

//验证码错误
#define STATU_UPDATEPHONE_VERIFYCODE_ERROR     @"10001013001"
//旧手机没验证通过
#define STATU_UPDATEPHONE_OLDPHONE_ERROR       @"10001013002"
//验证码过期或没发
#define STATU_UPDATEPHONE_NOVERIY_OR_INVALID   @"10001013003"





#pragma mark 家庭成员管理

/**家庭成员**/

//已添加此家庭成员
#define STATU_MEMBER_HAS_ADDED @"10002001001"
//在该房屋无记录
#define STATU_MEMBER_NO_RECORD @"10002001002"

/**预登记访客/车辆**/

//用户没有权限
#define STATU_VISITOR_USER_NO_POWER @"10005001001"


