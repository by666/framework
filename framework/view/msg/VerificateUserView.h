//
//  VerificateUserView.h
//  framework
//
//  Created by 黄成实 on 2018/5/31.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VerificateViewModel.h"

@interface VerificateUserView : UIView

-(instancetype)initWithViewModel:(VerificateViewModel *)viewModel;
-(void)updateView;
@end
