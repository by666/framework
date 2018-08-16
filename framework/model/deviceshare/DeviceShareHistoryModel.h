//
//  DeviceShareHistoryModel.h
//  framework
//
//  Created by 黄成实 on 2018/6/11.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceShareHistoryModel : NSObject

@property(copy, nonatomic)NSString *orderNum;
@property(copy, nonatomic)NSString *orderTime;
@property(copy, nonatomic)NSString *imageSrc;
@property(copy, nonatomic)NSString *name;
@property(copy, nonatomic)NSString *price;
@property(copy, nonatomic)NSString *total;
@property(copy, nonatomic)NSString *days;


+(NSMutableArray *)getTestDatas;
@end
