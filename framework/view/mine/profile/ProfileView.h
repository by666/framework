//
//  ProfileView.h
//  framework
//
//  Created by 黄成实 on 2018/5/16.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileViewModel.h"

@interface ProfileView : UIView


-(instancetype)initWithViewModel:(ProfileViewModel *)viewModel;
-(void)updateTableView;

@end
