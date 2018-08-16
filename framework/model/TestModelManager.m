//
//  TestModelManager.m
//  framework
//
//  Created by 黄成实 on 2018/7/24.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "TestModelManager.h"

@implementation TestModelManager
SINGLETON_IMPLEMENTION(TestModelManager)

-(void)initTestDatas{
    _reportFixDatas =  [FixModel getTestDatas];
    _deviceShareDatas = [DeviceShareHistoryModel getTestDatas];

}

@end
