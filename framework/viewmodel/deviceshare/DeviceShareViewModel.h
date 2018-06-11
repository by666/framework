//
//  DeviceShareViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/6/8.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeviceShareModel.h"

@protocol DeviceShareViewDelegate

-(void)onGoDeviceShareOrderPage:(DeviceShareModel *)model;
-(void)onRequestDatas:(Boolean)success datas:(NSMutableArray *)datas;

@end

@interface DeviceShareViewModel : NSObject

@property(strong, nonatomic)NSMutableArray *datas;
@property(weak, nonatomic)id<DeviceShareViewDelegate> delegate;

-(instancetype)init;

//跳转到下单页面
-(void)goDeviceShareOrderPage:(DeviceShareModel *)model;

-(void)requestDatas;

@end
