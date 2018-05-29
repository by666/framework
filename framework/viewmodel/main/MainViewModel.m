//
//  MainViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/9.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MainViewModel.h"

@implementation MainViewModel


-(instancetype)init{
    if(self == [super init]){
        
    }
    return self;
}


-(void)goMinePage{
    if(_delegate){
        [_delegate onGoMinePage];
    }
}

-(void)goMessagePage{
    if(_delegate){
        [_delegate onGoMessagePage];
    }
}
@end
