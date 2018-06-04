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
#define MSG_CANCEL @"取消"
#define MSG_CONFIRM @"确定"
#define MSG_DELETE @"删除"
#define MSG_WARN @"警告"
#define MSG_PROMPT @"提示"
#define MSG_COMMIT @"提交"
#define MSG_SEARCH @"搜索"
#define MSG_DATE_FORMAT @"YYYY年MM月dd日"
#define MSG_DATE_FORMAT2 @"YYYY.MM.dd"


//登录
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
#define MSG_LOGIN_PHONENUM_HINT @"请输入手机号"
#define MSG_LOGIN_VERIFYCODE_HINT @"验证码"
#define MSG_LOGIN_BTN_LOGIN @"登录"
#define MSG_LOGIN_THIRD_LOGIN @"第三方登录"

//个人主页
#define MSG_MINE_TITLE @"我的"

//个人信息页
#define MSG_PROFILE_TITLE @"个人主页"
#define MSG_PROFILE_AVATAR @"头像"
#define MSG_PROFILE_NAME @"姓名"
#define MSG_PROFILE_GENDER @"性别"
#define MSG_PROFILE_BIRTHDAY @"生日"
#define MSG_PROFILE_IDNUM @"身份证号"
#define MSG_PROFILE_IDENTIFY @"居住身份"
#define MSG_PROFILE_PHONENUM @"手机号"
#define MSG_PROFILE_VERIFY @"您的认证信息正在审核中>>"
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
#define MSG_MEMBER_DELETE_TIPS @"此操作将会删除和该成员绑定的一切信息，是否确定删除？"

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
#define MSG_ADDMEMBER_NAME_TIPS @"请填写您的姓名"
#define MSG_ADDMEMBER_IDNUM_TIPS @"请填写您的身份证号"

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
#define MSG_CAR_FAMILY_PAY @"为TA续费"
#define MSG_CAR_RECORD @"缴费记录"
#define MSG_CAR_ADD @"+ 添加车辆"
#define MSG_CAR_DELETE_TIPS @"此操作将会删除和车辆绑定的一切信息，是否确定删除？"


//添加车辆
#define MSG_ADDCAR_TITLE @"添加车辆"
#define MSG_ADDCAR_CARNUM @"车牌号"
#define MSG_ADDCAR_DEFAULT_HEAD @"粤B"
#define MSG_ADDCAR_CARNUM_ERROR @"车牌号码位数有误，请重新填写"
#define MSG_ADDCAR_HINT @"如:88888"

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
#define MSG_CARHISTORY_NODATA @"暂无车辆来访记录"

//车辆缴费
#define MSG_ONEPAYMENT_TITLE @"车辆缴费"
#define MSG_ONEPAYMENT_RIGHTBTN @"缴费记录"
#define MSG_ONEPAYMENT_SUCCEE_TIPS1 @"支付完成"
#define MSG_ONEPAYMENT_SUCCEE_TIPS2 @"访客车辆可直接通行"

//访客登记主页
#define MSG_VISITORHOME_TITLE @"来访登记"
#define MSG_VISITORHOME_PEOPLE_BUTTON @"访客登记"
#define MSG_VISITORHOME_CAR_BUTTON @"来访车辆登记"
#define MSG_VISITORHOME_ENTER_TIME @"进入时间：%@"
#define MSG_VISITORHOME_EXIT_TIME @"离开时间：%@"

//来访人员和车辆登记
#define MSG_VISITOR_PEOPLE_TITLE @"来访人员登记"
#define MSG_VISITOR_CAR_TITLE @"来访车辆登记"

#define MSG_VISITOR_NAME @"访客姓名"
#define MSG_VISITOR_NAME_TIPS @"请输入访客姓名"
#define MSG_VISITOR_DATE @"预计来访日期"
#define MSG_VISITOR_CARNUM @"车牌号码"
#define MSG_VISITOR_CARNUM_TIPS @"如:88888"
#define MSG_VISITOR_FACEDECTED @"人脸自动开门"
#define MSG_VISITOR_GENERATE_BTN @"生成临时通行证"
#define MSG_VISITOR_ERROR_NONAME @"请输入访客姓名"
#define MSG_VISITOR_ERROR_NODATE @"请选择访问日期"
#define MSG_VISITOR_ERROR_NOCARNUM @"请输入车牌号"
#define MSG_VISITOR_ERROR_NOFACEDETECT @"请上传人脸照片"
#define MSG_VISITOR_TIPS @"开启后，访客可”刷脸“直接进入门禁"

//临时通行证
#define MSG_PASSVIEW_TITLE @"详细来访信息"
#define MSG_PASSVIEW_NAME @"拜访人：%@"
#define MSG_PASSVIEW_DATE @"预计来访时间：%@"
#define MSG_PASSVIEW_LOCKCODE @"开锁码"
#define MSG_PASSVIEW_TIPS @"访客（%@）可以人脸识别，或使用二维码（或开锁码）通过门禁"
#define MSG_PASSVIEW_SHAREBTN @"微信分享给朋友"


//访客通行记录
#define MSG_VISITORHISTORY_TITLE @"来访通行记录"
#define MSG_VISITORHISTORY_RIGHTBTN @"访客登记"
#define MSG_VISITORHISTORY_AUTH @"再次授权"

//信息审核
#define MSG_AUTHSTATU_TITLE @"信息审核"
#define MSG_AUTHSTATU_SUBMIT_SUCCESS @"信息提交成功"
#define MSG_AUTHSTATU_SUBMIT_TIPS @"您的信息正在审核，可能需要1-2个工作日，请耐心等待"
#define MSG_AUTHSTATU_STATU_SUBMIT @"提交成功"
#define MSG_AUTHSTATU_STATU_AUTHING @"审核中"
#define MSG_AUTHSTATU_STATU_SUCCESS @"审核成功"
#define MSG_AUTHSTATU_STATU_TIPS @"正在审核中，请耐心等待..."
#define MSG_AUTHSTATU_STATU_TIPS2 @"您的信息提交成功，已催物业加急协助审核，请稍后"
#define MSG_AUTHSTATU_HURRYBTN @"我要催办"
#define MSG_AUTHSTATU_HURRYBTN_CLICKED @"已催办物管"
#define MSG_AUTHSTATU_HURRY_TIPS @"*您可以联系业主为您加快审核，也可以联系物业催办"

//用户认证
#define MSG_AUTHUSER_TITLE @"用户认证"

#define MSG_AUTHUSER_PART1_TITLE @"请填写您的住所信息"
#define MSG_AUTHUSER_PART1_COMMUNITY @"您的社区："
#define MSG_AUTHUSER_PART1_COMMUNITY_HINT @"请选择您的社区"
#define MSG_AUTHUSER_PART1_BUILDING @"楼栋："
#define MSG_AUTHUSER_PART1_BUILDING_HINT @"请选择"
#define MSG_AUTHUSER_PART1_DOORNUM @"门牌："
#define MSG_AUTHUSER_PART1_DOORNUM_HINT @"如1008"

#define MSG_AUTHUSER_PART2_TITLE @"请填写您的身份信息"
#define MSG_AUTHUSER_PART2_NAME @"您的姓名："
#define MSG_AUTHUSER_PART2_NAME_HINT @"请输入您的名字"
#define MSG_AUTHUSER_PART2_IDENTIFY @"居住身份："
#define MSG_AUTHUSER_PART2_IDENTIFY_DEFAULT @"业主"
#define MSG_AUTHUSER_PART2_IDENTIFY_MEMBER @"家属"
#define MSG_AUTHUSER_PART2_IDENTIFY_RENTER @"租客"
#define MSG_AUTHUSER_PART2_IDNUM @"身份证号码："
#define MSG_AUTHUSER_PART2_IDNUM_HINT @"请输入您的身份证号码"

#define MSG_AUTHUSER_RECOGNIZE_TITLE @"输入房号不存在，是否为"


#define MSG_AUTHUSER_BTN @"下一步"

#define MSG_AUTHUSER_ERROR_NOCOMMUNITY @"请选择您的社区"
#define MSG_AUTHUSER_ERROR_NOBUILDING @"请选择您的楼栋"
#define MSG_AUTHUSER_ERROR_NODOORNUM @"请输入您的门牌号"
#define MSG_AUTHUSER_ERROR_NONAME @"请输入您的姓名"
#define MSG_AUTHUSER_ERROR_NOIDNUM @"请输入您的身份证号"


//社区选择
#define MSG_COMMUNITY_TITLE @"社区信息"
#define MSG_COMMUNITY_KEYISEMPTY @"请输入搜索关键字"
#define MSG_COMMUNITY_CURRENTPOSITION @"当前自动定位"
#define MSG_COMMUNITY_LISTTITLE @"附近小区"


//人脸认证
#define MSG_AUTHFACE_TITLE @"人脸认证"
#define MSG_AUTHFACE_MAIN_CONTENT @"人脸信息"
#define MSG_AUTHFACE_SUB_CONTENT @"您的照片将被用于门禁出入身份识别，为保证门禁安全，请勿使用他人图片，请勿上传使用PS等手段处理后的图片。"
#define MSG_AUTHFACE_TAKEPHOTO @"立即拍照上传"
#define MSG_AUTHFACE_ALBUM @"相册选择"
#define MSG_AUTHFACE_UPLOAD @"立即上传"


//消息主页
#define MSG_MESSAGE_TITLE @"消息主页"
#define MSG_MESSAGE_PROPERTY_BTN @"物业消息"
#define MSG_MESSAGE_SYSTEM_BTN @"系统消息"
#define MSG_MESSAGE_NO_DATAS @"暂无任何消息"


//进禁/车闸
#define MSG_ENTERAUTH_VISITOR_TITLE @"访客授权"
#define MSG_ENTERAUTH_CAR_TITLE @"来访车辆授权"
#define MSG_ENTERAUTH_VISITOR @"拜访人："
#define MSG_ENTERAUTH_CARNUM @"车牌号："
#define MSG_ENTERAUTH_TIME @"拜访时间："
#define MSG_ENTERAUTH_POSITION @"当前位置："
#define MSG_ENTERAUTH_AGREE_BTN @"同意"
#define MSG_ENTERAUTH_REJECT_BTN @"忽略"


//用户认证
#define MSG_VERIFICATE_USER_TITLE @"用户认证"
#define MSG_VERIFICATE_HEAD @"头像"
#define MSG_VERIFICATE_NAME @"姓名"
#define MSG_VERIFICATE_IDENTIFY @"居住身份"
#define MSG_VERIFICATE_IDNUM @"身份证号码"
#define MSG_VERIFICATE_PHONENUM @"联系电话"
#define MSG_VERIFICATE_VALIDDATE @"认证有效期"

#define MSG_VERIFICATE_DATE_YEAR @"一年"
#define MSG_VERIFICATE_DATE_QUATERYEAD @"三个月"
#define MSG_VERIFICATE_DATE_HALF @"半年"
#define MSG_VERIFICATE_DATE_FOREVER @"永久"

#define MSG_VERIFICATE_AGREE @"认证通过"
#define MSG_VERIFICATE_REJECT @"退回申请"


//系统消息页
#define MSG_SYSTEMMSG_TITLE @"系统消息"

//物业消息
#define MSG_PROPERTYMSG_TITLE @"物业消息"
#define MSG_PROPERTYMSG_DETAIL @"查看详情"





