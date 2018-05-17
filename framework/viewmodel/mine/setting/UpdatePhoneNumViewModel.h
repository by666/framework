//
//  UpdatePhoneNumViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/16.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol UpdatePhoneNumViewDelegate

-(void)onSendUpdateVerifyCode:(Boolean)success;
-(void)onCheckVerifyCode:(Boolean)success;

@end

@interface UpdatePhoneNumViewModel : NSObject

@property(weak,nonatomic)id <UpdatePhoneNumViewDelegate> delegate;

//发送验证码
-(void)sendVerifyCode;

//验证验证码
-(void)checkVerifyCode:(NSString *)verifyCode;

@end
