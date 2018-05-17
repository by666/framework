//
//  UpdatePhoneNumViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/16.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "UpdatePhoneNumViewModel.h"

@implementation UpdatePhoneNumViewModel


-(void)sendVerifyCode{
    if(_delegate){
        [_delegate onSendUpdateVerifyCode:YES];
    }
}

-(void)checkVerifyCode:(NSString *)verifyCode{
    //todo 网络请求
    if(_delegate){
        [_delegate onCheckVerifyCode:YES];
    }
}
@end
