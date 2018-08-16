//
//  Constant.h
//  framework
//
//  Created by 黄成实 on 2018/4/24.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

#define APP_NAME @"智慧家"
#define MSG_SUCCESS @"请求成功"
#define MSG_ERROR @"网络错误码:%d"
#define MSG_CANCEL @"取消"
#define MSG_CONFIRM @"确定"
#define MSG_DELETE @"删除"
#define MSG_WARN @"警告"
#define MSG_PROMPT @"提示"
#define MSG_COMMIT @"提交"
#define MSG_SEARCH @"搜索"
#define MSG_MORE @"更多"
#define MSG_EXIT @"退出"
#define MSG_SEE @"查看"
#define MSG_ONCE @"再试一次"
#define MSG_ADD @"添加"
#define MSG_DATE_FORMAT_ZH @"YYYY年MM月dd日"
#define MSG_DATE_FORMAT_POINT @"YYYY.MM.dd"
#define MSG_DATE_FORMAT_ALL @"YYYY-MM-dd HH:mm:ss"
#define MSG_NET_ERROR @"网络错误,请检查您的网络"

#define MSG_CHOOSE @"请选择"
#define MSG_KOWN @"知道了"
#define MSG_ADD_SUCCESS @"添加成功"
#define MSG_DELETE_SUCCESS @"删除成功"
#define MSG_UPDATE_SUCCESS @"修改成功"
#define MSG_OTHER @"其他"


//登录
#define MSG_PHONENUM_ERROR @"手机号码错误"
#define MSG_VERIFYCODE_ERROR @"验证码错误"
#define MSG_NOT_INSTALL_WECHAT @"请先安装微信客户端"
#define MSG_VERIFYCODE_SUCCESS @"验证码短信已发送"
#define MSG_LOGIN_SUCCESS @"登录成功"
#define MSG_OPEN_WECHAT @"“智慧家”想要打开“微信”"
#define MSG_WECHAT_TITLE @"首次微信登录，请完善您的手机号"
#define MSG_GET_VERIFYCODE @"发送验证码"
#define MSG_FACE_LOGIN @"人脸登录"
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
#define MSG_OTHER_LOGIN @"其他登录方式"
#define MSG_WECHAT_LOGIN @"微信登录"
#define MSG_PHONE_LOGIN @"手机验证登录"


//首页
#define MSG_MAIN_PROPERTY @"物业消息"
#define MSG_MAIN_TITLE_ARRAY @"手机开门|访客车辆缴费|访客登记|最近来访|室内报修|设备共享|呼叫物管|消息通知|我的"
#define MSG_MAIN_PROPERTY @"物业消息"
#define MSG_MAIN_CHECKIN @"请先认证身份信息"
#define MSG_MAIN_MEMBER_TITLE @"以下家人正在使用人脸门禁"
#define MSG_MAIN_MESSAGE_TITLE @"待处理消息"
#define MSG_MAIN_PROPERTY_TITLE @"物业服务"
#define MSG_MAIN_NO_AUTH @"您还未认证信息"
#define MSG_MAIN_AUTH_BTN @"去认证"

#define MSG_MAIN_TITLE_ARRAY2 @"手机开门|访客登记|最近来访|设备共享|室内报修|呼叫物管"


//个人主页
#define MSG_MINE_TITLE @"我的"
#define MSG_MINE_AUTH_TIPS @"未审核或审核中不可修改人脸信息，建议审核通过后再修改q"

//个人信息页
#define MSG_PROFILE_TITLE @"个人主页"
#define MSG_PROFILE_AVATAR @"人脸信息"
#define MSG_PROFILE_NAME @"姓名"
#define MSG_PROFILE_GENDER @"性别"
#define MSG_PROFILE_BIRTHDAY @"生日"
#define MSG_PROFILE_IDNUM @"身份证号"
#define MSG_PROFILE_IDENTIFY @"居住身份"
#define MSG_PROFILE_PHONENUM @"手机号"
#define MSG_PROFILE_ADDRESS @"居住地址"
#define MSG_PROFILE_VERIFY @"您的认证信息正在审核中>>"
#define MSG_PROFILE_PHOTO @"拍照上传"
#define MSG_PROFILE_ALBUM @"相册选择"
#define MSG_PROFILE_TIPS_TITLE @"*您的照片信息将被用于门禁出入身份识别"


//人脸录制页面
#define MSG_FACEENTER_TITLE @"您正在使用人脸认证"
#define MSG_FACEENTER_SUBTITLE @"请摆正位置，使您的头像被准确捕捉"
#define MSG_FACEDETECT_FAIL @"未检测到人脸，请重新上传"
#define MSG_FACEDETECT_SUCCESS @"人脸识别成功"
#define MSG_FACEDETECT_MUTIPLE @"检测到多个人脸，请重新上传"
#define MSG_FACEDETECT_PROBILITY @"人脸不够清晰或者未在中心，请重新上传"

//刷脸登录页面
#define MSG_FACELOGIN_ALERT_TITLE @"操作超时"
#define MSG_FACELOGIN_ALERT_CONTENT @"提示：正对手机，更容易成功"


//设置页面
#define MSG_SETTING_TITLE @"设置"
#define MSG_SETTING_PUSH @"消息推送"
#define MSG_SETTING_FACELOGIN @"刷脸登录"
#define MSG_SETTING_UPDATE_PHONENUM @"修改手机号"
#define MSG_SETTING_ABOUT @"关于我们"
#define MSG_SETTING_LOGOUT @"退出登录"
#define MSG_SETTING_AUTH_TIPS @"未审核或审核中不可修改手机号，建议审核通过后再修改"

//修改手机号页面
#define MSG_UPDATEPHONENUM_TITLE @"安全验证"
#define MSG_UPDATEPHONENUM_TIPS @"为了保障您的账号安全，请验证身份成功后进行下一步操作。"
#define MSG_UPDATEPHONENUM_TIPS2 @"验证码短信已发送"
#define MSG_UPDATEPHONENUM_TIPS3 @"您的账号目前绑定的手机是%@,请输入您希望绑定的新手机号码"


//关于页面
#define MSG_ABOUT_TITLE @"关于我们"
#define MSG_ABOUT_VERSION @"版本 v1.0"
#define MSG_ABOUT_CONTENT @"三泰互联是由三泰控股（SZ002312)投资成立的全资子公司，全力打造Cellos智慧社区硬件操作系统，建立开发商、物业、第三方商户以及用户之间的闭环生态。\n\n三泰互联自营智慧门禁、智慧停车场、社区安防、能源管控等核心应用；打造设备云、空间云、人力云、存储云、仓储云等云共享服务，重塑未来社区。"


//消息设置
#define MSG_MESSAGESETTING_TITLE @"消息通知"

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
#define MSG_MEMBER_TIPS @"管理家庭成员人脸图像信息"
#define MSG_MEMBER_ADDBTN @"添加家庭成员"
#define MSG_MEMBER_DELETE_TIPS @"此操作将会删除和该成员绑定的一切信息，是否确定删除？"
#define MSG_MEMBER_ROOT @"管理员"

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
#define MSG_ADDMEMBER_UPDATE_TIPS @"用户信息发生变动，确认修改吗？"
#define MSG_ADDMEMBER_FACE_TIPS @"点击更换人脸照片"


//住户管理
#define MSG_HABITANT_TITLE @"住户管理"
#define MSG_HABITANT_FOREVER @"永久"
#define MSG_HABITANT_TIPS @"请选择%@的有效期时间"
#define MSG_HABITANT_VALID @"有效期至"

//用户信息
#define MSG_USERINFO_TITLE @"住户信息"

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
#define MSG_CARHISTORY_TITLE @"车辆通行记录"
#define MSG_CARHISTORY_NODATA @"暂无车辆来访记录"

//车辆缴费
#define MSG_ONEPAYMENT_TITLE @"车辆缴费"
#define MSG_ONEPAYMENT_RIGHTBTN @"缴费记录"
#define MSG_ONEPAYMENT_SUCCEE_TIPS1 @"支付完成"
#define MSG_ONEPAYMENT_SUCCEE_TIPS2 @"访客车辆可直接通行"

//访客登记主页
#define MSG_VISITORHOME_TITLE @"访客登记"
#define MSG_VISITORHOME_RIGHTBTN @"登记记录"
#define MSG_VISITORHOME_PEOPLE_BUTTON @"访客登记"
#define MSG_VISITORHOME_CAR_BUTTON @"来访车辆登记"
#define MSG_VISITORHOME_ENTER_TIME @"进入时间：%@"
#define MSG_VISITORHOME_EXIT_TIME @"离开时间：%@"

//来访人员和车辆登记
#define MSG_VISITOR_PEOPLE_TITLE @"访客登记"
#define MSG_VISITOR_CAR_TITLE @"车辆登记"

#define MSG_VISITOR_NAME @"访客姓名"
#define MSG_VISITOR_NAME_TIPS @"请输入访客姓名"
#define MSG_VISITOR_DATE @"预计来访日期"
#define MSG_VISITOR_CARNUM @"车牌号码"
#define MSG_VISITOR_CARNUM_TIPS @"如:88888"
#define MSG_VISITOR_FACEDECTED @"人脸自动开门"
#define MSG_VISITOR_GENERATE_BTN @"快速生成开锁码"
#define MSG_VISITOR_ERROR_NONAME @"请输入访客姓名"
#define MSG_VISITOR_ERROR_NODATE @"请选择访问日期"
#define MSG_VISITOR_ERROR_NOCARNUM @"请输入车牌号"
#define MSG_VISITOR_ERROR_NOFACEDETECT @"请上传人脸照片"
#define MSG_VISITOR_TIPS @"开启后，访客可”刷脸“直接进入门禁"

//临时开锁码
#define MSG_PASSVIEW_TITLE @"详细来访信息"
#define MSG_PASSVIEW_NAME @"访客%@"
#define MSG_PASSVIEW_DATE @"拜访时间 %@"
#define MSG_PASSVIEW_CARNUM @"车牌号码：%@"
#define MSG_PASSVIEW_LOCKCODE @"开锁码"
#define MSG_PASSVIEW_TIPS @"*可以输入开锁码（*号开头，#号结束）开门\n仅当日有效"
#define MSG_PASSVIEW_TIPS2  @"*可以输入开锁码（*号开头，#号结束）开门\n点击二维码图标，切换扫码开门\n仅当日有效"
#define MSG_PASSVIEW_SHAREBTN @"分享给朋友"
#define MSG_PASSPAGE_TITLE @"临时开锁码"
#define MSG_PASSVIEW_REGENERATEBTN @"再次生成开锁码"
#define MSG_PASSVIEW_INVAILD @"超过预约来访时间，开锁码已失效"
#define MSG_PASSPAGE_DELETE_TIPS @"删除后，开锁二维码码和门禁人脸识别将失效"
#define MSG_PASSVIEW_MYQRCODE @"您的二维码"
#define MSG_PASSVIEW_MYFACE @"您可以在门禁处刷脸出入"
#define MSG_PASSVIEW_OTHER @"其他开锁方式"
#define MSG_PASSVIEW_QRCODE @"二维码"

//开锁码历史
#define MSG_PASSHISTORY_TITLE @"登记记录"
#define MSG_PASSHISTORY_NAME @"访客姓名：%@"
#define MSG_PASSHISTORY_CARNUM @"车牌号码：%@"
#define MSG_PASSHISTORY_VISITTIME @"来访时间：%@"
#define MSG_PASSHISTORY_CHECKTIME @"登记时间：%@"
#define MSG_PASSHISTORY_PASSBTN @"查看开锁码"
#define MSG_PASSHISTORY_NODATA @"暂未登记任何访客"
#define MSG_PASSHISTORY_BTN @"访客登记"



//访客通行记录
#define MSG_VISITORHISTORY_TITLE @"访客通行记录"
#define MSG_VISITORHISTORY_RIGHTBTN @"访客登记"
#define MSG_VISITORHISTORY_AUTH @"再次授权"
#define MSG_VISITORHISTORY_UNKNOW @"暂无记录"
#define MSG_VISITORHISTORY_ENTER @"进"
#define MSG_VISITORHISTORY_EXIT @"出"



//信息审核
#define MSG_AUTHSTATU_TITLE @"信息审核"
#define MSG_AUTHSTATU_SUBMIT_SUCCESS @"信息提交成功"
#define MSG_AUTHSTATU_SUBMIT_TIPS @"您的信息正在审核中，请耐心等待"
#define MSG_AUTHSTATU_STATU_SUBMIT @"提交成功"
#define MSG_AUTHSTATU_STATU_AUTHING @"审核中"
#define MSG_AUTHSTATU_STATU_SUCCESS @"审核成功"
#define MSG_AUTHSTATU_STATU_TIPS @"您的信息正在审核中，请耐心等候"
#define MSG_AUTHSTATU_STATU_TIPS2 @"已催物业加急协助审核，预计三个工作日内完成"
#define MSG_AUTHSTATU_HURRYBTN @"物业催办"
#define MSG_AUTHSTATU_HURRYBTN_CLICKED @"已催办物管"
#define MSG_AUTHSTATU_HURRY_TIPS @"*您可以联系业主审核，也可以联系物管催办"

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
#define MSG_AUTHUSER_POSITION_ERROR @"定位失败"
#define MSG_AUTHUSER_ERROR_ERRORIDNUM @"请填写正确的身份证号码"


//社区选择
#define MSG_COMMUNITY_TITLE @"社区信息"
#define MSG_COMMUNITY_KEYISEMPTY @"请输入搜索关键字"
#define MSG_COMMUNITY_CURRENTPOSITION @"当前自动定位"
#define MSG_COMMUNITY_LISTTITLE @"附近小区"


//人脸认证
#define MSG_AUTHFACE_TITLE @"人脸认证"
#define MSG_AUTHFACE_MAIN_CONTENT @"录入人脸信息"
#define MSG_AUTHFACE_SUB_CONTENT @"您的照片将被用于门禁出入身份识别"
#define MSG_AUTHFACE_TAKEPHOTO @"立即拍照上传"
#define MSG_AUTHFACE_ALBUM @"相册选择"
#define MSG_AUTHFACE_UPLOAD @"提交认证"
#define MSG_AUTHFACE_BACKHOME @"返回首页"
#define MSG_AUTHFACE_RETAKEPHOTO_TIPS @"点击头像重拍"


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
#define MSG_ENTERAUTH_AGREE_BTN @"开启门禁"
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


//扫码开门
#define MSG_OPENDOOR_TITLE @"扫码开门"
#define MSG_OPENDOOR_TIPS @"*生成开锁二维码，仅当日有效"
#define MSG_OPENDOOR_BTN @"临时开锁"

#define MSG_OPENDOOR_LOCKCODE @"开锁码"
#define MSG_OPENDOOR_SHAREBTN @"微信分享给朋友"
#define MSG_OPENDOOR_LOCKCODE_TIPS @"*使用二维码扫码开门，也可输入开锁码开门\n仅当日有效"


//室内报修
#define MSG_REPORTFIX_TITLE @"室内报修"
#define MSG_REPORTFIX_RIGHT_BTN @"报修记录"
#define MSG_REPORTFIX_CATEGORY @"服务分类"
#define MSG_REPORTFIX_SERVETIME @"预约上门时间"
#define MSG_REPORTFIX_DETAIL @"障碍说明"
#define MSG_REPORTFIX_DETAIL_TIPS @"请简单描述遇到的障碍问题哦~"
#define MSG_REPORTFIX_CATEGORY_ARRAY @"门窗类|电器类|家具类|电路类|水管类|灯具类|其他"
#define MSG_REPORTFIX_RESULT_TIPS @"信息提交成功"
#define MSG_REPORTFIX_RESULT_TIPS2 @"已为您通知物管人员，将会在预约时间内为您服务。"

//报修历史记录
#define MSG_FIXHISTORY_TITLE @"报修记录"
#define MSG_FIXHISTORY_TITLE_ARRAY @"报修时间|服务分类|预约上门时间|障碍说明"

//设备共享
#define MSG_DEVICESHARE_TITLE @"设备共享"
#define MSG_DEVICESHARE_RIGHT_BTN @"租用订单"
#define MSG_DEVICESHARE_RENT @"租用"

//设备共享支付页
#define MSG_DEVICESHAREORDER_TITLE @"共享设备"
#define MSG_DEVICESHAREORDER_NAME @"设备名称"
#define MSG_DEVICESHAREORDER_DAYS @"预计租用天数"
#define MSG_DEVICESHAREORDER_PRICE @"租赁价格"
#define MSG_DEVICESHAREORDER_MORTAGAGE @"押金类型"
#define MSG_DEVICESHAREORDER_PAYSUCCESS @"支付成功"
#define MSG_DEVICESHAREORDER_CODE @"物品提取码：%@"


//设备共享订单页
#define MSG_DEVICESHAREHISTORY_TITLE @"设备租用订单"
#define MSG_DEVICESHAREHISTORY_ORDERTITLE @"订单编号"


//消息通知
#define MSG_NEW_MSG_TITLE @"您有一条新消息"

#define MSG_MESSAGE_USERAUTH_TITLE @"用户认证请求"
#define MSG_MESSAGE_USERAUTH_CONTENT @"%@申请认证为您房屋的%@，请及时处理"
#define MSG_MESSAGE_VISITOR_TITLE @"访客门禁申请"
#define MSG_MESSAGE_VISITOR_CONTENT @"%@正在等待您的门禁授权"
#define MSG_MESSAGE_AUTH_RESULT_SUCCESS @"认证成功"
#define MSG_MESSAGE_AUTH_RESULT_SUCCESS_CONTENT @"您的身份信息已认证成功"

#define MSG_MESSAGE_AUTH_RESULT_FAIL @"认证失败"
#define MSG_MESSAGE_AUTH_RESULT_FAIL_CONTENT @"您的身份信息已认证失败，原因为：业主审核不通过。重新认证>>>"

#define MSG_MESSAGE_HAS_AUTH_SUCCESS @"您已经认证成功，无需重复认证"


#define MSG_MESSAGE_AUTH_FAIL_CONTENT @"您的认证信息未被通过"
#define MSG_REAUTH @"重新认证"


//无数据消息
#define MSG_NO_MESSAGE @"暂无任何消息"
#define MSG_BACK_HOME @"返回主页"
#define MSG_NO_VISITOR @"暂无访客通行记录"
#define MSG_NO_FIXHISTORY @"暂无报修记录"
#define MSG_NO_DEVICESHAREHISTORY @"暂无订单记录"
#define MSG_NO_HABITANT @"暂无其他住户账号"

#define MSG_NO_NET @"加载失败，点击重试"
#define MSG_RELOAD @"重新加载"


