//
//  DeviceShareHistoryViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/6/11.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeviceShareHistoryModel.h"
@protocol DeviceShareHistoryDelegate

-(void)onRequestDatas:(Boolean)success;

@end

@interface DeviceShareHistoryViewModel : NSObject

@property(strong,nonatomic)NSMutableArray *datas;
@property(weak, nonatomic)id<DeviceShareHistoryDelegate> delegate;

-(instancetype)init;
-(void)requestDatas;

@end
