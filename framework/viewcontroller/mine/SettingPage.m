//
//  SettingPage.m
//  framework
//
//  Created by 黄成实 on 2018/5/15.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "SettingPage.h"

@interface SettingPage ()

@end

@implementation SettingPage

+(void)show:(BaseViewController *)controller{
    SettingPage *page = [[SettingPage alloc]init];
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = c01;
    [self showSTNavigationBar:@"设置" needback:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [self setStatuBarBackgroud:cwhite];
}

@end
