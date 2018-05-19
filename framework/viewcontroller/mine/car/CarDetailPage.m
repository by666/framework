
//
//  CarDetailPage.m
//  framework
//
//  Created by 黄成实 on 2018/5/19.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "CarDetailPage.h"

@implementation CarDetailPage

+(void)show:(BaseViewController *)controller{
    CarDetailPage *page = [[CarDetailPage alloc]init];
    [controller pushPage:page];
}

@end
