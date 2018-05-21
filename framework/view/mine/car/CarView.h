//
//  CarView.h
//  framework
//
//  Created by 黄成实 on 2018/5/19.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarViewModel.h"

@interface CarView : UIView

-(instancetype)initWithViewModel:(CarViewModel *)viewModel;
-(void)updateView;

@end
