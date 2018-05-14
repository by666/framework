//
//  LoginViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/9.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginModel.h"

@protocol LoginDelegate

-(void)onSendVerifyCode:(Boolean)success;
-(void)onLogin:(Boolean)success;
-(void)onWechatLogin:(Boolean)success msg:(NSString *)msg;
-(void)onTimeCount:(Boolean)complete;
-(void)onFaceLogin;

@end

@interface LoginViewModel:NSObject

@property(weak, nonatomic)id <LoginDelegate>delegate;
@property(strong, nonatomic)LoginModel *loginModel;

-(void)sendVerifyCode:(NSString *)phoneNum;
-(void)doLogin:(NSString *)phoneNum verifyCode:(NSString *)verifyCode;
-(void)startCountTime;

-(void)doWechatLogin;
-(void)doFaceLogin;

@end
