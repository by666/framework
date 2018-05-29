//
//  MessagePage.m
//  framework
//
//  Created by 黄成实 on 2018/5/29.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MessagePage.h"

@interface MessagePage ()

@end

@implementation MessagePage

+(void)show:(BaseViewController *)controller{
    MessagePage *page = [[MessagePage alloc]init];
    [controller pushPage:page];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = cwhite;
    [self showSTNavigationBar:MSG_MESSAGE_TITLE needback:YES];
    [self initView];
}


-(void)viewWillAppear:(BOOL)animated{
    [self setStatuBarBackgroud:cwhite];
}

-(void)initView{
//    AuthStatuViewModel *viewModel = [[AuthStatuViewModel alloc]init];
//    viewModel.delegate = self;
//
//    _authStatuView = [[AuthStatuView alloc]initWithViewModel:viewModel];
//    _authStatuView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
//    _authStatuView.backgroundColor = cwhite;
//    [self.view addSubview:_authStatuView];
}

@end
