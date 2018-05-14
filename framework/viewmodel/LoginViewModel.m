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
        _loginModel.msgStr = @"";
        _loginModel.verifyStr = MSG_GET_VERIFYCODE;

    }
    return self;
}



#pragma mark 请求验证码
-(void)sendVerifyCode:(NSString *)phoneNum{
    if(_delegate){
        if(![STPUtil isPhoneNumValid:phoneNum]){
            _loginModel.msgStr = MSG_PHONENUM_ERROR;
            _loginModel.msgColor = c07;
            [_delegate onSendVerifyCode:NO];
            return;
        }
        //todo:网络请求
        _loginModel.msgStr = MSG_VERIFYCODE_SUCCESS;
        _loginModel.msgColor = c06;
        [_delegate onSendVerifyCode:YES];
        [self startCountTime];
    }
}


#pragma mark 请求登录
-(void)doLogin:(NSString *)phoneNum verifyCode:(NSString *)verifyCode{
    if(_delegate){
        if(![STPUtil isPhoneNumValid:phoneNum]){
            _loginModel.msgStr = MSG_PHONENUM_ERROR;
            _loginModel.msgColor = c07;
            [_delegate onLogin:NO];
            return;
        }
        if(![STPUtil isVerifyCodeValid:verifyCode]){
            _loginModel.msgStr = MSG_VERIFYCODE_ERROR;
            _loginModel.msgColor = c07;
            [_delegate onLogin:NO];
            return;
        }
        //todo:网络请求
        _loginModel.msgStr = MSG_LOGIN_SUCCESS;
        _loginModel.msgColor = c06;
        [_delegate onLogin:YES];
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
            [_delegate onWechatLogin:NO msg:MSG_NOT_INSTALL_WECHAT];
        }
    }
}

#pragma mark 人脸登录
-(void)doFaceLogin{
    if(_delegate){
        [_delegate onFaceLogin];
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
                weakSelf.loginModel.verifyStr = MSG_GET_VERIFYCODE;
                if(weakSelf.delegate){
                    [weakSelf.delegate onTimeCount:YES];
                }
            } else {
                weakSelf.loginModel.verifyStr = [NSString stringWithFormat:@"%lds",second];
                [weakSelf.delegate onTimeCount:NO];
                second--;
            }
        });
    });
    dispatch_resume(timer);
}

@end
