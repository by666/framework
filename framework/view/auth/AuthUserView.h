//
//  AuthUserView.h
//  framework
//
//  Created by 黄成实 on 2018/5/24.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AuthUserViewModel.h"

@interface AuthUserView : UIView

-(instancetype)initWithViewModel:(AuthUserViewModel *)viewModel;
-(void)removeView;
-(void)onSubmitResult:(Boolean)success errorMsg:(NSString *)errorMsg;
-(void)updateAddress:(NSString *)addressStr;
@end
