//
//  DeviceShareHistoryView.h
//  framework
//
//  Created by 黄成实 on 2018/6/11.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeviceShareHistoryViewModel.h"
@interface DeviceShareHistoryView : UIView

-(instancetype)initWithViewModel:(DeviceShareHistoryViewModel *)viewModel;
-(void)updateView;

@end
