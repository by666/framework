//
//  PhoneNumView.h
//  framework
//
//  Created by 黄成实 on 2018/5/9.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BindPhoneViewModel.h"

@interface BindPhoneView : UIView

-(instancetype)initWithViewModel:(BindPhoneViewModel *)viewModel title:(NSString *)title;
-(void)updateVerifyBtn:(Boolean)complete;
-(void)updateView;

@end
