//
//  ReportFixViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/6/6.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "ReportFixViewModel.h"
#import "TestModelManager.h"
#import "STTimeUtil.h"

@implementation ReportFixViewModel

-(void)doReprotFix:(NSString *)orderTimeStr category:(NSString *)categoryStr detail:(NSString *)detailStr{
    if(_delegate){
        FixModel *model = [[FixModel alloc]init];
        model.category = categoryStr;
        model.orderTime = orderTimeStr;
        model.detail = detailStr;
        model.reportTime = [STTimeUtil generateDate:[STTimeUtil getCurrentTimeStamp] format:@"MM.dd HH:mm"];
        [[TestModelManager sharedTestModelManager].reportFixDatas insertObject:model atIndex:0];
        [_delegate onDoReportFix:YES];
    }
}


@end
