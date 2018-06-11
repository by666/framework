//
//  ReportFixView.h
//  framework
//
//  Created by 黄成实 on 2018/6/6.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReportFixViewModel.h"

@interface ReportFixView : UIView

-(instancetype)initWithViewModel:(ReportFixViewModel *)viewModel;
-(void)onReportFixSuccess;
@end
