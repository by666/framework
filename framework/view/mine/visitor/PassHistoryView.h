//
//  PassHistoryView.h
//  framework
//
//  Created by 黄成实 on 2018/6/27.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PassHistoryViewModel.h"

@interface PassHistoryView : UIView

-(instancetype)initWithViewModel:(PassHistoryViewModel *)viewModel;
-(void)updateView;

@end
