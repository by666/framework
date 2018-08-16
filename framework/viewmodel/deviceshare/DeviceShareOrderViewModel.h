//
//  DeviceShareOrderViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/6/8.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeviceShareModel.h"

@protocol DeviceShareOrderViewDelegate

-(void)onDoWechatPay;

@end

@interface DeviceShareOrderViewModel : NSObject

@property(weak, nonatomic)id<DeviceShareOrderViewDelegate> delegate;
@property(strong, nonatomic)NSMutableArray *titleDatas;
@property(strong, nonatomic)DeviceShareModel *data;

-(instancetype)initWithData:(DeviceShareModel *)model;
-(void)doWechatPay:(int)days;

@end
