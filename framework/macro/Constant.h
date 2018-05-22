//
//  Constant.h
//  framework
//
//  Created by 黄成实 on 2018/4/24.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

#define APP_NAME @"三泰互联"
#define MSG_SUCCESS @"请求成功"
#define MSG_ERROR @"网络出错了，请稍后重试"
#define MSG_PHONENUM_ERROR @"手机号码错误"
#define MSG_VERIFYCODE_ERROR @"验证码错误"
#define MSG_NOT_INSTALL_WECHAT @"请先安装微信客户端"
#define MSG_VERIFYCODE_SUCCESS @"验证码短信已发送"
#define MSG_LOGIN_SUCCESS @"登录成功"
#define MSG_OPEN_WECHAT @"“三泰互联”想要打开“微信”"
#define MSG_WECHAT_TITLE @"首次微信登录，请完善您的手机号"
#define MSG_GET_VERIFYCODE @"获取验证码"
#define MSG_FACE_LOGIN @"刷脸登录"
#define MSG_VERIFYCODE_LOGIN @"验证码登录"
#define MSG_FACE_TITLE @"请拿起手机，将脸移入框内"
#define MSG_DETECT_OUTOFTIME @"验证超时"
#define MSG_OUTOFTIME_CONTENT @"正对手机，刷脸更容易成功"
#define MSG_VERIFYCODE_RESEND @"重发验证码"
#define MSG_VERIFYCODE_OUROFTIME @"验证码超时，请点击重发验证码"
#define MSG_VERIFYCODE_MUTIPLE @"验证码发送次数过多，请明天再试或采用人脸识别登陆"
#define MSG_CANCEL @"取消"
#define MSG_CONFIRM @"确定"
#define MSG_DELETE @"删除"
#define MSG_WARN @"警告"
#define MSG_COMMIT @"提交"
#define MSG_DATE_FORMAT @"YYYY年MM月dd日"


#define MSG_MINE_TITLE @"我的"

//个人主页
#define MSG_PROFILE_TITLE @"个人主页"
#define MSG_PROFILE_AVATAR @"头像"
#define MSG_PROFILE_NAME @"姓名"
#define MSG_PROFILE_GENDER @"性别"
#define MSG_PROFILE_BIRTHDAY @"生日"
#define MSG_PROFILE_IDNUM @"身份证号"
#define MSG_PROFILE_IDENTIFY @"居住身份"
#define MSG_PROFILE_PHONENUM @"手机号"
#define MSG_PROFILE_VERIFY @"您的认证信息正在审核中"
#define MSG_PROFILE_PHOTO @"拍照上传"
#define MSG_PROFILE_ALBUM @"相册选择"

//人脸录制页面
#define MSG_FACEENTER_TITLE @"该照片用于门禁出入的人脸识别"
#define MSG_FACEENTER_SUBTITLE @"请摆正位置，使您的头像被准确捕捉"


//设置页面
#define MSG_SETTING_TITLE @"设置"
#define MSG_SETTING_PUSH @"消息推送"
#define MSG_SETTING_FACELOGIN @"刷脸登录"
#define MSG_SETTING_UPDATE_PHONENUM @"修改手机号"
#define MSG_SETTING_ABOUT @"关于我们"
#define MSG_SETTING_LOGOUT @"退出登录"

//修改手机号页面
#define MSG_UPDATEPHONENUM_TITLE @"安全验证"
#define MSG_UPDATEPHONENUM_TIPS @"为了保障您的账号安全，请验证身份成功后进行下一步操作。"
#define MSG_UPDATEPHONENUM_TIPS2 @"验证码短信已发送"
#define MSG_UPDATEPHONENUM_TIPS3 @"您的账号目前绑定的手机是186****6420,请输入您希望绑定的新手机号码"


//关于页面
#define MSG_ABOUT_TITLE @"关于"


//消息设置
#define MSG_MESSAGESETTING_TITLE @"消息通知设置"

#define MSG_MESSAGESETTING_PUSH_TITLE @"访客呼叫通知设置"
#define MSG_MESSAGESETTING_PUSH_APP @"App通知"
#define MSG_MESSAGESETTING_PUSH_BELL @"门铃通知"
#define MSG_MESSAGESETTING_PUSH_TV @"电视通知"
#define MSG_MESSAGESETTING_PUSH_TIPS @"*说明：您可以设置接收访客请求的终端是否开启"

#define MSG_MESSAGESETTING_EXPRESS_TITLE @"快递通知设置"
#define MSG_MESSAGESETTING_EXPRESS_APP @"App通知"
#define MSG_MESSAGESETTING_EXPRESS_SCREEN @"门禁屏幕通知"

//家庭成员页面
#define MSG_MEMBER_TITLE @"家庭成员"
#define MSG_MEMBER_TIPS @"管理家庭成员人脸图像信息，用于门禁出入"
#define MSG_MEMBER_ADDBTN @"+ 添加家庭成员"

//添加家庭成员页面
#define MSG_ADDMEMBER_TITLE @"添加家庭成员"
#define MSG_ADDMEMBER_TAKEPHOTO @"+\n点击拍照"
#define MSG_ADDMEMBER_TIPS @"人脸照片信息"
#define MSG_ADDMEMBER_TIPS2 @"您的家庭成员信息"
#define MSG_ADDMEMBER_NAME @"姓名或昵称"
#define MSG_ADDMEMBER_IDNUM @"身份证号码（必填）"
#define MSG_ADDMEMBER_SAVE @"保存"
#define MSG_ADDMEMBER_DELETE @"删除"
#define MSG_ADDMEMBER_NAME_ERROR @"请填写您的姓名或昵称"
#define MSG_ADDMEMBER_IDNUM_ERROR @"请填写正确的身份证号码"
#define MSG_ADDMEMBER_AVATAR_ERROR @"请上传人脸照片"

//住户管理
#define MSG_HABITANT_TITLE @"住户管理"
#define MSG_HABITANT_FOREVER @"永久"
#define MSG_HABITANT_TIPS @"请选择%@的有效期时间"

//我的车辆
#define MSG_CAR_TITLE @"我的车辆"
#define MSG_CAR_NOCAR @"暂无车辆信息"
#define MSG_CAR_ADDCAR @"+ 添加车辆"
#define MSG_CAR_RIGHTBTN @"添加车辆"
#define MSG_CAR_BIND @"%@已绑定"
#define MSG_CAR_MYCAR @"我的车辆"
#define MSG_CAR_FAMILYCAR @"家属的车辆"
#define MSG_CAR_PAY @"续费"
#define MSG_CAR_FAMILY_PAY @"为他/她续费"
#define MSG_CAR_RECORD @"缴费记录"


//添加车辆
#define MSG_ADDCAR_TITLE @"添加车辆"
#define MSG_ADDCAR_CARNUM @"车牌号："
#define MSG_ADDCAR_DEFAULT_HEAD @"粤B"
#define MSG_ADDCAR_CARNUM_ERROR @"车牌号码位数有误，请重新填写"

//车辆详情
#define MSG_CARDETAIL_TITLE @"车辆详情"
#define MSG_CARDETAIL_PAYMENT @"月卡缴费"
#define MSG_CARDETAIL_TIPS @"*车辆月卡办理与延长月卡有效期，可直接联系管理处0755-235273"

//月卡缴费
#define MSG_PAYMENT_TITLE @"月卡缴费"
#define MSG_PAYMENT_PAY @"去支付"
#define MSG_PAYMENT_SUCCEE_TIPS1 @"支付完成"
#define MSG_PAYMENT_SUCCEE_TIPS2 @"月卡车辆可以无障碍通过"

//缴费记录
#define MSG_PAYMENTRECORD_TITLE @"缴费记录"
#define MSG_PAYMENTRECORD_VISITOR_TAB @"代访客缴费记录"
#define MSG_PAYMENTRECORD_MONTH_TAB @"月卡缴费记录"

//车辆缴费记录
#define MSG_CARHISTORY_TITLE @"来访车辆通行记录"

//车辆缴费
#define MSG_ONEPAYMENT_TITLE @"车辆缴费"
#define MSG_ONEPAYMENT_RIGHTBTN @"缴费记录"
#define MSG_ONEPAYMENT_SUCCEE_TIPS1 @"支付完成"
#define MSG_ONEPAYMENT_SUCCEE_TIPS2 @"访客车辆可直接通行"

//访客登记
#define MSG_VISITOR_TITLE @"来访登记"
#define MSG_VISITOR_PEOPLE_BUTTON @"访客登记"
#define MSG_VISITOR_CAR_BUTTON @"来访车辆登记"


//访客通行记录
#define MSG_VISITORHISTORY_TITLE @"来访通行记录"

