//
//  CarHistoryViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/22.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "CarHistoryViewModel.h"
#import "CarHistoryModel.h"

@implementation CarHistoryViewModel

-(instancetype)init{
    if(self == [super init]){
        _datas = [[NSMutableArray alloc]init];
        [self setupCarHistoryDatas];
    }
    return self;
}

-(void)setupCarHistoryDatas{
    [_datas addObject:[CarHistoryModel buildModel:@"粤B 23452" name:@"乔峰" enterTime:@"2018.5.22 12:35" exitTime:@"2018.5.22 14:40" hasPaid:NO]];
    [_datas addObject:[CarHistoryModel buildModel:@"粤B FD893" name:@"段誉" enterTime:@"2018.5.22 13:35" exitTime:@"2018.5.22 14:00" hasPaid:YES]];
    [_datas addObject:[CarHistoryModel buildModel:@"粤B SD78F" name:@"杨过" enterTime:@"2018.5.22 14:35" exitTime:@"2018.5.22 18:35" hasPaid:NO]];
    [_datas addObject:[CarHistoryModel buildModel:@"粤B SD932" name:@"黄蓉" enterTime:@"2018.5.22 14:00" exitTime:@"2018.5.22 14:40" hasPaid:YES]];

}


-(void)getCarHistoryDatas{
    if(_delegate){
        [_delegate onGetCarHistoryDatas:YES];
    }
}

-(void)goOnePaymentPage:(CarHistoryModel *)model{
    if(_delegate){
        [_delegate onGoOnePaymentPage:model];
    }
}
@end
