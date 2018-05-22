//
//  CarHistoryModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/22.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarHistoryModel : NSObject

@property(copy, nonatomic)NSString *carNum;
@property(copy, nonatomic)NSString *name;
@property(copy, nonatomic)NSString *enterTime;
@property(copy, nonatomic)NSString *exitTime;
@property(assign, nonatomic)Boolean hasPaid;

+(CarHistoryModel *)buildModel:(NSString *)carNum name:(NSString *)name enterTime:(NSString *)enterTime exitTime:(NSString *)exitTime hasPaid:(Boolean)hasPaid;

@end
