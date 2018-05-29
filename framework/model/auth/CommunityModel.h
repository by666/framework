//
//  CommunityModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/29.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommunityModel : NSObject

@property(copy, nonatomic)NSString *name;
@property(copy, nonatomic)NSString *address;


+(NSMutableArray *)getTestDatas;



@end
