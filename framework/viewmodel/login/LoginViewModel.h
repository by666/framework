//
//  LoginViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/9.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginModel.h"

@protocol LoginDelegate<BaseRequestDelegate>

-(void)onGetTestCode:(NSString *)code;
-(void)onWechatLogin:(Boolean)success msg:(NSString *)msg;
-(void)onTimeCount:(Boolean)complete;
-(void)onFaceLogin;
-(void)onGoback;

@end

@interface LoginViewModel:NSObject

@property(weak, nonatomic)id <LoginDelegate>delegate;
@property(strong, nonatomic)LoginModel *loginModel;

-(void)sendVerifyCode:(NSString *)phoneNum;
-(void)getTestCode:(NSString *)phoneNum;
-(void)doLogin:(NSString *)phoneNum verifyCode:(NSString *)verifyCode;
-(void)doLogin:(NSString *)phoneNum verifyCode:(NSString *)verifyCode wxToken:(NSString *)wxToken;
-(void)startCountTime;

-(void)doWechatLogin;
-(void)requestWechatLogin:(NSString *)code;
-(void)doFaceLogin;
-(void)goback;

@end
