//
//  DeviceShareModel.h
//  framework
//
//  Created by 黄成实 on 2018/6/8.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceShareModel : NSObject

@property(copy, nonatomic)NSString *imageSrc;
@property(copy, nonatomic)NSString *name;
@property(copy, nonatomic)NSString *price;
@property(copy, nonatomic)NSString *brief;
@property(strong, nonatomic)NSMutableArray *detailDatas;


+(NSMutableArray *)getTestDatas;


@end
