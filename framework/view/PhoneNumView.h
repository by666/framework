//
//  PhoneNumView.h
//  framework
//
//  Created by 黄成实 on 2018/5/9.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhoneViewModel.h"

@interface PhoneNumView : UIView

-(instancetype)initWithViewModel:(PhoneViewModel *)viewModel;
-(void)updateView;

@end
