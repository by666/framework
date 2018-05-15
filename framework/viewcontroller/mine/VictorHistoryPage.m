//
//  VictorHistoryPage.m
//  framework
//
//  Created by 黄成实 on 2018/5/15.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "VictorHistoryPage.h"

@interface VictorHistoryPage ()

@end

@implementation VictorHistoryPage

+(void)show:(BaseViewController *)controller{
    VictorHistoryPage *page = [[VictorHistoryPage alloc]init];
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = c01;
    [self showSTNavigationBar:@"访客通行记录" needback:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [self setStatuBarBackgroud:cwhite];
}

@end
