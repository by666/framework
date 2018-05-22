//
//  VisitorHistoryPage.m
//  framework
//
//  Created by 黄成实 on 2018/5/15.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "VisitorHistoryPage.h"

@interface VisitorHistoryPage ()

@end

@implementation VisitorHistoryPage

+(void)show:(BaseViewController *)controller{
    VisitorHistoryPage *page = [[VisitorHistoryPage alloc]init];
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = c01;
    [self showSTNavigationBar:MSG_VISITORHISTORY_TITLE needback:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [self setStatuBarBackgroud:cwhite];
}

@end
