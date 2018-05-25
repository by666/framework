//
//  AuthStatuView.h
//  framework
//
//  Created by 黄成实 on 2018/5/24.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AuthStatuViewModel.h"

@interface AuthStatuView : UIView

-(instancetype)initWithViewModel:(AuthStatuViewModel *)viewModel;
-(void)onHurryRequest:(Boolean)success;

@end
