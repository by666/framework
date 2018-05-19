//
//  HabitantView.h
//  framework
//
//  Created by 黄成实 on 2018/5/15.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HabitantViewModel.h"
@interface HabitantView : UIView

-(instancetype)initWithViewModel:(HabitantViewModel *)viewModel;
-(void)updateView;

@end
