//
//  MainView2.h
//  framework
//
//  Created by 黄成实 on 2018/8/6.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewModel.h"
@interface MainView2 : UIView

-(instancetype)initWithViewModel:(MainViewModel *)viewModel;
-(void)updateMemberView;
-(void)updateMsgView;

@end
