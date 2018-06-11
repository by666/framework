//
//  FixModel.h
//  framework
//
//  Created by 黄成实 on 2018/6/8.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FixModel : NSObject

@property(copy, nonatomic)NSString *reportTime;
@property(copy, nonatomic)NSString *orderTime;
@property(copy, nonatomic)NSString *category;
@property(copy, nonatomic)NSString *detail;
@property(assign, nonatomic)Boolean expand;

+(NSMutableArray *)getTestDatas;

@end
