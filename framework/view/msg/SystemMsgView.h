//
//  SystemMsgView.h
//  framework
//
//  Created by 黄成实 on 2018/6/1.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SystemMsgViewModel.h"

@interface SystemMsgView : UIView

-(instancetype)initWithViewModel:(SystemMsgViewModel *)viewModel;
-(void)updateView;

@end
