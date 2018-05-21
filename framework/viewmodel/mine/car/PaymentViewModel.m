//
//  PaymentViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/21.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "PaymentViewModel.h"

@implementation PaymentViewModel


-(instancetype)initWithModel:(CarModel *)data{
    if(self == [super init]){
        _data = data;
        _titleDatas = [[NSMutableArray alloc]init];
        [self setData];
    }
    return self;
}

-(void)setData{
    [_titleDatas addObject:[TitleContentModel buildModel:@"车牌号" content:[NSString stringWithFormat:@"%@ %@",_data.carHead,_data.carNum]]];
    [_titleDatas addObject:[TitleContentModel buildModel:@"月卡类型" content:@"月卡A"]];
}

-(void)doWechatPay{
    if(_delegate){
        [_delegate onWechatPay:YES];
    }
}

@end
