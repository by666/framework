//
//  BindPhoneViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/9.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BindPhoneModel.h"

@protocol PhoneDelegate

-(void)onSendVerifyCode:(Boolean)success;
-(void)onBindPhone:(Boolean)success;
-(void)onTimeCount:(Boolean)complete;

@end
@interface BindPhoneViewModel : NSObject

@property(weak, nonatomic)id <PhoneDelegate>delegate;


@property(strong, nonatomic)BindPhoneModel *bindPhoneModel;

-(void)sendVerifyCode:(NSString *)phoneNum;
-(void)doBindPhone:(NSString *)phoneNum verifyCode:(NSString *)verifyCode;
-(void)startCountTime;

@end
