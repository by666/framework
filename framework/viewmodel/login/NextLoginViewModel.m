//
//  NextLoginViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/14.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "NextLoginViewModel.h"
#import "STObserverManager.h"
#import <WXApi.h>
#import "UserModel.h"
#import "STNetUtil.h"
#import "AccountManager.h"
#import "STUserDefaults.h"

@implementation NextLoginViewModel


-(void)goLoginPage{
    if(_delegate){
        [_delegate onGoLoginPage];
    }
}

-(void)goFaceLoginPage{
    if(_delegate){
        [_delegate onGoFaceLoginPage];
    }
}


#pragma mark 请求微信登录
-(void)doWechatLogin{
    if(_delegate){
        if([WXApi isWXAppInstalled]){
            SendAuthReq *req = [[SendAuthReq alloc] init];
            req.scope = @"snsapi_userinfo";
            req.state = @"wxLogin";
            [WXApi sendReq:req];
        }else{
            [_delegate onWechatLogin:NO msg:MSG_NOT_INSTALL_WECHAT];
        }
    }
}

#pragma mark 微信登录票据换token
-(void)requestWechatLogin:(NSString *)code{
    if(_delegate){
        [_delegate onRequestBegin];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        dic[@"code"] = code;
        dic[@"registrationId"] = [STUserDefaults getKeyValue:UD_PUSHID];
        WS(weakSelf)
        [STNetUtil post:URL_WX_LOGIN content:dic.mj_JSONString success:^(RespondModel *respondModel) {
            if([respondModel.status isEqualToString:STATU_SUCCESS]){
                UserModel *model = [[AccountManager sharedAccountManager]getUserModel];
                model.token = [respondModel.data objectForKey:@"token"];
                model.userUid = [respondModel.data objectForKey:@"userUid"];
                [[AccountManager sharedAccountManager]saveUserModel:model];
                [weakSelf.delegate onRequestSuccess:respondModel data:MSG_SUCCESS];
            }
            else if([respondModel.status isEqualToString:STATU_WXLOGN_NOT_BINDPHONE]){
                NSString *wxToken = [respondModel.data objectForKey:@"wxToken"];
                [weakSelf.delegate onRequestSuccess:respondModel data:wxToken];
            }else{
                [weakSelf.delegate onRequestFail:respondModel.msg];
            }
        } failure:^(int errorCode) {
            [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
            
        }];
    }
}


@end
