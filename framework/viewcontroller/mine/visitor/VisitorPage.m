//
//  VisitorPage.m
//  framework
//
//  Created by 黄成实 on 2018/5/15.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "VisitorPage.h"

@interface VisitorPage ()

@end

@implementation VisitorPage

+(void)show:(BaseViewController *)controller{
    VisitorPage *page = [[VisitorPage alloc]init];
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = c01;
    [self showSTNavigationBar:MSG_VISITOR_TITLE needback:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [self setStatuBarBackgroud:cwhite];
}
@end
