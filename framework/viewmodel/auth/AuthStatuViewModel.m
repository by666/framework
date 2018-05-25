//
//  AuthStatuViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/24.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "AuthStatuViewModel.h"

@implementation AuthStatuViewModel


-(void)doHurryRequest{
    if(_delegate){
        [_delegate onHurryRequest:YES];
    }
}
@end
