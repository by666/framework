//
//  VisitorHomeViewModel.m
//  framework
//
//  Created by by.huang on 2018/5/23.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "VisitorHomeViewModel.h"

@implementation VisitorHomeViewModel


-(void)goVisitorPeople{
    if(_delegate){
        [_delegate onGoVisitorPage:People];
    }
}

-(void)goVisitorCar{
    if(_delegate){
        [_delegate onGoVisitorPage:Car];
    }
}
@end
