//
//  LoginView.h
//  framework
//
//  Created by 黄成实 on 2018/5/9.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewModel.h"

@interface LoginView : UIView

-(instancetype)initWithViewModel:(LoginViewModel *)viewModel;
-(void)updateView;
-(void)updateVerifyBtn:(Boolean)complete;
@end
