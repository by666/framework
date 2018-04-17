//
//  TestView.h
//  framework
//
//  Created by 黄成实 on 2018/4/17.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestViewModel.h"

@interface TestView : UIView

-(instancetype)init;
-(void)bindViewModel:(TestViewModel *)viewModel;

@end
