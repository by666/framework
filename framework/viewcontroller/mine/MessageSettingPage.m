//
//  MessageSettingPage.m
//  framework
//
//  Created by 黄成实 on 2018/5/15.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MessageSettingPage.h"

@interface MessageSettingPage ()

@end

@implementation MessageSettingPage

+(void)show:(BaseViewController *)controller{
    MessageSettingPage *page = [[MessageSettingPage alloc]init];
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = c01;
    [self showSTNavigationBar:@"消息通知设置" needback:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [self setStatuBarBackgroud:cwhite];
}


@end
