 //
//  EnterAuthPage.m
//  framework
//
//  Created by 黄成实 on 2018/5/30.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "EnterAuthPage.h"
#import "EnterAuthView.h"
#import "STObserverManager.h"
@interface EnterAuthPage ()<EnterAuthViewDelegate>

@property(strong, nonatomic)MessageModel *data;
@property(strong, nonatomic)EnterAuthView *enterAuthView;

@end

@implementation EnterAuthPage

+(void)show:(BaseViewController *)controller model:(MessageModel *)model{
    EnterAuthPage *page = [[EnterAuthPage alloc]init];
    page.data = model;
    [controller pushPage:page];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = c15;
    if(_data.messageType == VisitorEnter){
        [self showSTNavigationBar:MSG_ENTERAUTH_VISITOR_TITLE needback:YES];
    }else{
        [self showSTNavigationBar:MSG_ENTERAUTH_CAR_TITLE needback:YES];
    }
    [self initView];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setStatuBarBackgroud:cwhite];
}

-(void)initView{
 
    EnterAuthViewModel *viewModel = [[EnterAuthViewModel alloc]initWithData:_data];
    viewModel.delegate = self;
    
    _enterAuthView = [[EnterAuthView alloc]initWithViewModel:viewModel];
    _enterAuthView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    [self.view addSubview:_enterAuthView];

}

-(void)onDoReject:(MessageModel *)model{
    [[STObserverManager sharedSTObserverManager]sendMessage:Notify_MESSAGE_REJECT msg:model];
    [self backLastPage];
}

-(void)onDoAgree:(MessageModel *)model{
    [[STObserverManager sharedSTObserverManager]sendMessage:Notify_MESSAGE_AGREE msg:model];
    [self backLastPage];
}

@end
