//
//  ProfilePage.m
//  framework
//
//  Created by 黄成实 on 2018/5/15.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "ProfilePage.h"

@interface ProfilePage ()

@end

@implementation ProfilePage

+(void)show:(BaseViewController *)controller{
    ProfilePage *page = [[ProfilePage alloc]init];
    [controller pushPage:page];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = c01;
    [self showSTNavigationBar:@"个人资料" needback:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [self setStatuBarBackgroud:cwhite];
}


@end
