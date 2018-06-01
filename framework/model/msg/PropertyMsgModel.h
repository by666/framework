//
//  PropertyMsgModel.h
//  framework
//
//  Created by 黄成实 on 2018/6/1.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PropertyMsgModel : NSObject

@property(assign, nonatomic)long mid;
@property(copy, nonatomic)NSString *title;
@property(copy, nonatomic)NSString *timeStamp;
@property(copy, nonatomic)NSString *imageUrl;

+(NSMutableArray *)getTestDatas;

@end
