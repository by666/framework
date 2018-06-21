//
//  LoginView.h
//  framework
//
//  Created by 黄成实 on 2018/5/9.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewModel.h"
#import "LoginPage.h"

@interface LoginView : UIView

-(instancetype)initWithViewModel:(LoginViewModel *)viewModel controller:(LoginPage *)page needBack:(Boolean)needBack;

//验证码按钮UI变化
-(void)updateVerifyBtn:(Boolean)complete;
//登录验证
-(void)updateView;


//测试验证码
-(void)blankCode:(NSString *)code;

@end
