//
//  SystemMsgPage.m
//  framework
//
//  Created by 黄成实 on 2018/6/1.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "SystemMsgPage.h"
#import "SystemMsgView.h"

@interface SystemMsgPage ()<SystemMsgViewDelegate>

@property (strong, nonatomic)SystemMsgView *systemMsgView;

@end

@implementation SystemMsgPage

+(void)show:(BaseViewController *)controller{
    SystemMsgPage *page = [[SystemMsgPage alloc]init];
    [controller pushPage:page];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = c15;
    [self showSTNavigationBar:MSG_SYSTEMMSG_TITLE needback:YES];
    [self initView];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setStatuBarBackgroud:cwhite];
}

-(void)initView{
    
    SystemMsgViewModel *viewModel = [[SystemMsgViewModel alloc]init];
    viewModel.delegate = self;

    _systemMsgView = [[SystemMsgView alloc]initWithViewModel:viewModel];
    _systemMsgView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    _systemMsgView.backgroundColor = c15;
    [self.view addSubview:_systemMsgView];
    
    
}


-(void)onRequestCallback:(Boolean)success datas:(NSMutableArray *)datas{
    if(success){
        [_systemMsgView updateView];
    }
}

@end
