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

-(void)OnSendVerifyCode:(Boolean)success msg:(NSString *)msg;
-(void)OnLogin:(Boolean)success msg:(NSString *)msg;
-(void)OnWechatLogin:(Boolean)success msg:(NSString *)msg;
-(void)OnTimeCount:(Boolean)complete;

@end

@interface LoginViewModel:NSObject

@property(weak, nonatomic)id <LoginDelegate>delegate;
@property(strong, nonatomic)LoginModel *loginModel;

-(Boolean)isPhoneNumValid:(NSString *)phoneNum;
-(Boolean)isVerifyCodeValid:(NSString *)verifyCode;
-(void)sendVerifyCode:(NSString *)phoneNum;
-(void)doLogin:(NSString *)phoneNum verifyCode:(NSString *)verifyCode;
-(void)doWechatLogin;
-(void)startCountTime;

@end