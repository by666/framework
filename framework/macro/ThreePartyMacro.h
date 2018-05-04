//
//  ThreePartyMacro.h
//  framework
//
//  Created by 黄成实 on 2018/4/17.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark 定义三方库appid,appkey....

#define IFLY_FACE_APPID @"5add784a"
#define JPUSH_APPKEY @"49828a3f5529d51df648f0ad"
#define WECHAT_APPID @"wx3349545f4d083130"



#ifdef __OBJC__

#define LBXScan_Define_Native  //下载了native模块
#define LBXScan_Define_ZXing   //下载了ZXing模块
#define LBXScan_Define_ZBar   //下载了ZBar模块
#define LBXScan_Define_UI     //下载了界面模块
#endif
