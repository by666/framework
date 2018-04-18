//
//  STRuntimeUtil.h
//  framework
//
//  Created by 黄成实 on 2018/4/18.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STRuntimeUtil : NSObject

//获取类所有的属性名
+(NSArray *)getAllPropertyNames:(Class)tempClass;

//获取类所有的方法名
+(NSArray *)getAllMethodNames:(Class)tempClass;

@end
