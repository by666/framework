//
//  DeviceShareOrderViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/6/8.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "DeviceShareOrderViewModel.h"
#import "TitleContentModel.h"
#import "TestModelManager.h"
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


-(void)doWechatPay:(int)days{
    if(_delegate){
        DeviceShareHistoryModel *model = [[DeviceShareHistoryModel alloc]init];
        model.orderTime = @"08-13 15:32";
        model.imageSrc = _data.imageSrc;
        model.name = _data.name;
        model.price = [_data.price substringWithRange:NSMakeRange(0, _data.price.length - 3)];
        int per = [model.price intValue];
        model.total = [NSString stringWithFormat:@"%d",per *days];
        model.days = [NSString stringWithFormat:@"%d",days];
        
        NSMutableArray *tempDatas = [TestModelManager sharedTestModelManager].deviceShareDatas;
        NSString *orderNumber;
        if(!IS_NS_COLLECTION_EMPTY(tempDatas)){
            DeviceShareHistoryModel *tempModel =  [tempDatas objectAtIndex:0];
            orderNumber = [NSString stringWithFormat:@"%d", [tempModel.orderNum intValue] + 1];
        }
        model.orderNum = orderNumber;
        [[TestModelManager sharedTestModelManager].deviceShareDatas insertObject:model atIndex:0];
        [_delegate onDoWechatPay];
    }
}
@end
