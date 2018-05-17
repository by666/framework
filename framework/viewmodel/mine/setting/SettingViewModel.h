//
//  SettingViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/16.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SettingViewDelegate

-(void)onLogout:(Boolean)success;
-(void)onGoUpdatePhoneNumPage;
-(void)onGoAboutPage;

@end

@interface SettingViewModel : NSObject

@property(weak, nonatomic)id<SettingViewDelegate> delegate;
@property(strong, nonatomic)NSMutableArray *datas;

//推送开关
-(Boolean)OpenPushFunction:(Boolean)openPush;

//人脸登录开关
-(Boolean)OpenFaceLoginFunction:(Boolean)openFaceLogin;

//登出
-(void)logout;

//修改手机号页面
-(void)goUpdatePhoneNumPage;

//关于页面
-(void)goAboutPage;


@end
