//
//  DeviceShareOrderView.h
//  framework
//
//  Created by 黄成实 on 2018/6/8.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeviceShareOrderViewModel.h"
@interface DeviceShareOrderView : UIView

-(instancetype)initWithViewModel:(DeviceShareOrderViewModel *)viewModel;
-(void)updateView;
-(void)onPaySuccess;

@end
