//
//  OnePaymentViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/22.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "OnePaymentViewModel.h"

@implementation OnePaymentViewModel

-(instancetype)init{
    if(self == [super init]){
        _model = [[CarHistoryModel alloc]init];
    }
    return self;
}


-(void)doPay{
    if(_delegate){
        [_delegate onPayResult:YES];
    }
}
@end
