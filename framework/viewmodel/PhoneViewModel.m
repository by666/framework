//
//  PhoneViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/9.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "PhoneViewModel.h"

@implementation PhoneViewModel


#pragma mark 手机号是否有效
-(Boolean)isPhoneNumValid:(NSString *)phoneNum{
    if (IS_NS_STRING_EMPTY(phoneNum) ||  phoneNum.length != 11){
        return NO;
    }
    NSString *regex = @"^1(3[0-9]|4[0-9]|5[0-9]|8[0-9]|7[0-9])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [regextestmobile evaluateWithObject:phoneNum];
}

#pragma makr 绑定手机号
-(void)doBindPhoneNum:(NSString *)phoneNum{
    if(_delegate){
        if(![self isPhoneNumValid:phoneNum]){
            [_delegate OnBindPhoneNum:NO msg:MSG_PHONENUM_ERROR];
            return;
        }
        //todo:网络请求
        [_delegate OnBindPhoneNum:YES msg:MSG_SUCCESS];
    }
}

@end
