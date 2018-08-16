//
//  PhoneNumPage.h
//  framework
//
//  Created by 黄成实 on 2018/5/9.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "BaseViewController.h"
#import "LoginViewModel.h"

@interface BindPhonePage : BaseViewController

+(void)show:(BaseViewController *)controller wxToken:(NSString *)wxToken viewModel:(LoginViewModel *)viewModel;

@end
