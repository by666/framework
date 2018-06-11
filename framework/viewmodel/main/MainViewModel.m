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


-(void)goOpendoorPage{
    if(_delegate){
        [_delegate onGoOpendoorPage];
    }
}

-(void)goCarPage{
    if(_delegate){
        [_delegate onGoCarPage];
    }
}

-(void)goVisitorPage{
    if(_delegate){
        [_delegate onGoVisitorPage];
    }
}

-(void)goVisitorHistoryPage{
    if(_delegate){
        [_delegate onGoVisitorHistoryPage];
    }
}

-(void)goReportFixPage{
    if(_delegate){
        [_delegate onGoReportFixPage];
    }
}

-(void)goDeviceSharePage{
    if(_delegate){
        [_delegate onGoDeviceSharePage];
    }
}

-(void)doCallProperty{
    if(_delegate){
        [_delegate onDoCallProperty];
    }
}

-(void)goMessagePage{
    if(_delegate){
        [_delegate onGoMessagePage];
    }
}

-(void)goMinePage{
    if(_delegate){
        [_delegate onGoMinePage];
    }
}
@end
