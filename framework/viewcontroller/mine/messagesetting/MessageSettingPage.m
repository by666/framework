//
//  MessageSettingPage.m
//  framework
//
//  Created by 黄成实 on 2018/5/15.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MessageSettingPage.h"
#import "MessageSettingView.h"
@interface MessageSettingPage()<MessageSettingViewDelegate>

@end

@implementation MessageSettingPage

+(void)show:(BaseViewController *)controller{
    MessageSettingPage *page = [[MessageSettingPage alloc]init];
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = c15;
    [self showSTNavigationBar:MSG_MESSAGESETTING_TITLE needback:YES];
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated{
    [self setStatuBarBackgroud:cwhite];
}

-(void)initView{
    MessageSettingViewModel *viewModel = [[MessageSettingViewModel alloc]init];
    viewModel.delegate = self;
    
    MessageSettingView *messageSettingView = [[MessageSettingView alloc]initWithViewModel:viewModel];
    messageSettingView.backgroundColor = c15;
    messageSettingView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    [self.view addSubview:messageSettingView];
}



@end
