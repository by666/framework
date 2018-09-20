//
//  ThirdPartyMacro.h
//  framework
//
//  Created by 黄成实 on 2018/4/17.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#pragma mark app渠道号，sql表，下载地址

#define CHANNELID @"st"
#define ST_TABLENAME @"sthl"
#define APPSTORE_DOWNLOAD_URL @"https://itunes.apple.com/us/app/%E6%99%BA%E6%85%A7%E5%AE%B6iot/id1428381007?l=zh&ls=1&mt=8"


#pragma mark 定义三方库appid,appkey....

#define IFLY_FACE_APPID @"5add784a"
#define JPUSH_APPID @"171976fa8adb6fd285d"
#define JPUSH_APPKEY @"49828a3f5529d51df648f0ad"
#define WECHAT_APPID @"wxbc2d656f23e6c0f1"
#define BUGLY_APPID @"7793f1d5e4"
#define WANGYI_APPKEY @"1e66758b4d721a95c410a835f425f11a"


#ifdef __OBJC__

#define LBXScan_Define_Native  //下载了native模块
#define LBXScan_Define_ZXing   //下载了ZXing模块
#define LBXScan_Define_ZBar   //下载了ZBar模块
#define LBXScan_Define_UI     //下载了界面模块
#endif


//百度人脸识别

// 如果在后台选择自动配置授权信息，下面的三个LICENSE相关的参数已经配置好了
// 只需配置FACE_API_KEY和FACE_SECRET_KEY两个参数即可

// 人脸license文件名
#define FACE_LICENSE_NAME    @"idl-license"

// 人脸license后缀
#define FACE_LICENSE_SUFFIX  @"face-ios"

// （您申请的应用名称(appname)+「-face-ios」后缀，如申请的应用名称(appname)为test123，则此处填写test123-face-ios）
// 在后台 -> 产品服务 -> 人脸识别 -> 客户端SDK管理查看，如果没有的话就新建一个
#define FACE_LICENSE_ID        @"santaihulian-face-ios"
