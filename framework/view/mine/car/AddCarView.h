//
//  AddCarView.h
//  framework
//
//  Created by 黄成实 on 2018/5/19.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddCarViewModel.h"

@interface AddCarView : UIView

-(instancetype)initWithViewModel:(AddCarViewModel *)viewModel;

-(void)addCarData;

@end
