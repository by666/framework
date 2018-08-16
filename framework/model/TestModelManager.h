//
//  TestModelManager.h
//  framework
//
//  Created by 黄成实 on 2018/7/24.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FixModel.h"
#import "DeviceShareHistoryModel.h"

@interface TestModelManager : NSObject
SINGLETON_DECLARATION(TestModelManager)

@property(strong, nonatomic)NSMutableArray *reportFixDatas;
@property(strong, nonatomic)NSMutableArray *deviceShareDatas;


-(void)initTestDatas;

@end
