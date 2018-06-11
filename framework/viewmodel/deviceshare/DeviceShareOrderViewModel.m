//
//  DeviceShareOrderViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/6/8.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "DeviceShareOrderViewModel.h"
#import "TitleContentModel.h"
@implementation DeviceShareOrderViewModel

-(instancetype)initWithData:(DeviceShareModel *)model{
    if(self == [super init]){
        _data = model;
        _titleDatas = [[NSMutableArray alloc]init];
        [self initTitleDatas];
    }
    return self;
}

-(void)initTitleDatas{
    [_titleDatas addObject:[TitleContentModel buildModel:MSG_DEVICESHAREORDER_NAME content:_data.name]];
    [_titleDatas addObject:[TitleContentModel buildModel:MSG_DEVICESHAREORDER_DAYS content:@"1"]];
    [_titleDatas addObject:[TitleContentModel buildModel:MSG_DEVICESHAREORDER_PRICE content:_data.price]];
    [_titleDatas addObject:[TitleContentModel buildModel:MSG_DEVICESHAREORDER_MORTAGAGE content:@"免押金"]];
}


-(void)doWechatPay{
    if(_delegate){
        [_delegate onDoWechatPay];
    }
}
@end
