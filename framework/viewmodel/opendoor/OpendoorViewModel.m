//
//  OpendoorViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/6/6.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "OpendoorViewModel.h"

@implementation OpendoorViewModel

-(void)generateTempLock{
    if(_delegate){
        [_delegate onGenerateTempLock:YES];
    }
}

@end
