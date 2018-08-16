//
//  UserInfoView.h
//  framework
//
//  Created by 黄成实 on 2018/8/14.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoViewModel.h"

@interface UserInfoView : UIView

-(instancetype)initWithViewModel:(UserInfoViewModel *)viewModel;
-(void)updateView;

@end
