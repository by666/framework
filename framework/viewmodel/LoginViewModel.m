//
//  LoginViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/9.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "LoginViewModel.h"
#import "STObserverManager.h"
#import <WXApi.h>

#define TIMECOUNT 60

@implementation LoginViewModel

-(instancetype)init{
    if(self == [super init]){
        _loginModel = [[LoginModel alloc]init];
        _loginModel.username = @"by666";
        _loginModel.verifyStr = @"获取验证码";

    }
    return self;
}


#pragma mark 手机号是否有效
-(Boolean)isPhoneNumValid:(NSString *)phoneNum{
    if (IS_NS_STRING_EMPTY(phoneNum) ||  phoneNum.length != 11){
        return NO;
    }
    NSString *regex = @"^1(3[0-9]|4[0-9]|5[0-9]|8[0-9]|7[0-9])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [regextestmobile evaluateWithObject:phoneNum];
}

#pragma mark 验证码是否有效
-(Boolean)isVerifyCodeValid:(NSString *)verifyCode{
    if(!IS_NS_STRING_EMPTY(verifyCode) && verifyCode.length == 4){
        return YES;
    }
    return NO;
}


#pragma mark 请求验证码
-(void)sendVerifyCode:(NSString *)phoneNum{
    if(_delegate){
        if(![self isPhoneNumValid:phoneNum]){
            [_delegate OnSendVerifyCode:NO msg:MSG_PHONENUM_ERROR];
            return;
        }
        //todo:网络请求
        _loginModel.username = @"验证码成功";
        [_delegate OnSendVerifyCode:YES msg:MSG_SUCCESS];
        [self startCountTime];
    }
}


#pragma mark 请求登录
-(void)doLogin:(NSString *)phoneNum verifyCode:(NSString *)verifyCode{
    if(_delegate){
        if(![self isPhoneNumValid:phoneNum]){
            [_delegate OnLogin:NO msg:MSG_PHONENUM_ERROR];
            return;
        }
        if(![self isVerifyCodeValid:verifyCode]){
            [_delegate OnLogin:NO msg:MSG_VERIFYCODE_ERROR];
            return;
        }
        //todo:网络请求
        _loginModel.username = @"登录成功";
        [_delegate OnLogin:YES msg:MSG_SUCCESS];
    }
}

#pragma mark 请求微信登录
-(void)doWechatLogin{
    if(_delegate){
        if([WXApi isWXAppInstalled]){
            SendAuthReq *req = [[SendAuthReq alloc] init];
            req.scope = @"snsapi_userinfo";
            req.state = @"App";
            [WXApi sendReq:req];
        }else{
            [_delegate OnWechatLogin:NO msg:MSG_NOT_INSTALL_WECHAT];
        }
    }
}

#pragma mark 开始倒计时
-(void)startCountTime{
    __block NSInteger second = TIMECOUNT;
    __weak LoginViewModel *weakSelf = self;
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, quene);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (second == 0) {
                second = TIMECOUNT;
                dispatch_cancel(timer);
                weakSelf.loginModel.verifyStr = @"获取验证码";
                if(weakSelf.delegate){
                    [weakSelf.delegate OnTimeCount:YES];
                }
            } else {
                weakSelf.loginModel.verifyStr = [NSString stringWithFormat:@"%ld秒后重新获取",second];
                [weakSelf.delegate OnTimeCount:NO];
                second--;
            }
        });
    });
    dispatch_resume(timer);
}

@end
