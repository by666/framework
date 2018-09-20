//
//  WYUserModel.m
//  framework
//
//  Created by by.huang on 2018/9/20.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "WYUserModel.h"

@implementation WYUserModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"wyid": @"id"};
}

@end
