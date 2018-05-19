//
//  CarHistoryPage.m
//  framework
//
//  Created by 黄成实 on 2018/5/15.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "CarHistoryPage.h"

@interface CarHistoryPage ()

@end

@implementation CarHistoryPage

+(void)show:(BaseViewController *)controller{
    CarHistoryPage *page = [[CarHistoryPage alloc]init];
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = c01;
    [self showSTNavigationBar:@"车辆通行记录" needback:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [self setStatuBarBackgroud:cwhite];
}


@end
