//
//  PaymentView.h
//  framework
//
//  Created by 黄成实 on 2018/5/21.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaymentViewModel.h"

@interface PaymentView : UIView

-(instancetype)initWithViewModel:(PaymentViewModel *)viewModel;
-(void)updateView;
@end
