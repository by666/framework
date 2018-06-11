//
//  ReportFixViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/6/6.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol ReportFixViewDelegate

-(void)onDoReportFix:(Boolean)success;

@end

@interface ReportFixViewModel : NSObject

@property(weak, nonatomic)id<ReportFixViewDelegate> delegate;

-(void)doReprotFix;

@end
