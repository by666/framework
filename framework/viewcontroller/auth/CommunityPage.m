//
//  CommunityPage.m
//  framework
//
//  Created by 黄成实 on 2018/5/28.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "CommunityPage.h"

@interface CommunityPage ()

@end

@implementation CommunityPage

+(void)show:(BaseViewController *)controller{
    CommunityPage *page = [[CommunityPage alloc]init];
    [controller pushPage:page];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = c15;
    [self initView];
    [self showSTNavigationBar:MSG_COMMUNITY_TITLE needback:YES];
}


-(void)viewWillAppear:(BOOL)animated{
    [self setStatuBarBackgroud:cwhite];
}

-(void)initView{
    
}

@end
