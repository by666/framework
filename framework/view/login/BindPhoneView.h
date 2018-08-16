//
//  PhoneNumView.h
//  framework
//
//  Created by 黄成实 on 2018/5/9.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewModel.h"

@interface BindPhoneView : UIView

-(instancetype)initWithViewModel:(LoginViewModel *)viewModel title:(NSString *)title;
-(instancetype)initWithViewModel:(LoginViewModel *)viewModel title:(NSString *)title wxToken:(NSString *)wxToken;

-(void)updateVerifyBtn:(Boolean)complete;
-(void)updateView;
//测试验证码
-(void)blankCode:(NSString *)code;

@end
