//
//  PaymentRecordViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/21.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "PaymentRecordViewModel.h"
#import "MonthPaymentModel.h"
#import "VisitorPaymentModel.h"

@implementation PaymentRecordViewModel

-(instancetype)init{
    if(self == [super init]){
        _monthPaymentDatas = [[NSMutableArray alloc]init];
        [self setupMonthPaymentDatas];
        
        _visitorPaymentDatas = [[NSMutableArray alloc]init];
        [self setupVisitorPaymentDatas];
    }
    return self;
}

-(void)setupMonthPaymentDatas{
    [_monthPaymentDatas addObject:[MonthPaymentModel buildModel:@"粤B Y6666" name:@"张三丰" expiryDate:@"2018.5.22-2019.5.22" cardType:@"月卡A" amount:@"300" payDate:@"2018.5.22 12:30"]];
    [_monthPaymentDatas addObject:[MonthPaymentModel buildModel:@"粤B 1234H" name:@"张三丰" expiryDate:@"2018.5.22-2019.5.22" cardType:@"月卡A" amount:@"300" payDate:@"2018.5.22 12:30"]];
    [_monthPaymentDatas addObject:[MonthPaymentModel buildModel:@"粤B 3FC84" name:@"张翠山" expiryDate:@"2018.5.22-2019.5.22" cardType:@"月卡A" amount:@"300" payDate:@"2018.5.22 12:30"]];
    [_monthPaymentDatas addObject:[MonthPaymentModel buildModel:@"粤B 4380DF" name:@"张无忌" expiryDate:@"2018.5.22-2019.5.22" cardType:@"月卡A" amount:@"300" payDate:@"2018.5.22 12:30"]];
}

-(void)setupVisitorPaymentDatas{
    [_visitorPaymentDatas addObject:[VisitorPaymentModel buildModel:@"粤B 23452" name:@"乔峰" enterTime:@"2018.5.22 12:35" exitTime:@"2018.5.22 14:40" parkTime:@"2小时5分钟" amount:@"10"]];
    [_visitorPaymentDatas addObject:[VisitorPaymentModel buildModel:@"粤B FD893" name:@"段誉" enterTime:@"2018.5.22 13:35" exitTime:@"2018.5.22 14:00" parkTime:@"0小时25分钟" amount:@"5"]];
    [_visitorPaymentDatas addObject:[VisitorPaymentModel buildModel:@"粤B SD78F" name:@"杨过" enterTime:@"2018.5.22 14:35" exitTime:@"2018.5.22 18:35" parkTime:@"4小时0分钟" amount:@"20"]];
    [_visitorPaymentDatas addObject:[VisitorPaymentModel buildModel:@"粤B SD932" name:@"黄蓉" enterTime:@"2018.5.22 14:00" exitTime:@"2018.5.22 14:40" parkTime:@"0小时40分钟" amount:@"8"]];

}

-(void)getMonthPaymentDatas{
    if(_delegate){
        [_delegate onGetMonthPaymentDatas:YES];
    }
}

-(void)getVisitorPaymentDatas{
    if(_delegate){
        [_delegate onGetVisitorPaymentDatas:YES];
    }
}

@end
