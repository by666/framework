//
//  VisitorHistoryView.h
//  framework
//
//  Created by by.huang on 2018/5/23.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VisitorHistoryViewModel.h"

@interface VisitorHistoryView : UIView


-(instancetype)initWithViewModel:(VisitorHistoryViewModel *)viewModel;
-(void)updateView;

@end
