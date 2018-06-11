//
//  ReportFixViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/6/6.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "ReportFixViewModel.h"

@implementation ReportFixViewModel

-(void)doReprotFix{
    if(_delegate){
        [_delegate onDoReportFix:YES];
    }
}


@end
