//
//  AuthStatuPage.m
//  framework
//
//  Created by 黄成实 on 2018/5/24.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "AuthStatuPage.h"
#import "AuthStatuView.h"

@interface AuthStatuPage ()<AuthStatuViewDelegate>

@property(strong, nonatomic)AuthStatuView *authStatuView;
@end

@implementation AuthStatuPage

+(void)show:(BaseViewController *)controller{
    AuthStatuPage *page = [[AuthStatuPage alloc]init];
    [controller pushPage:page];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = cwhite;
    [self showSTNavigationBar:MSG_AUTHSTATU_TITLE needback:YES];
    [self initView];
}


-(void)viewWillAppear:(BOOL)animated{
    [self setStatuBarBackgroud:cwhite];
}

-(void)initView{
    AuthStatuViewModel *viewModel = [[AuthStatuViewModel alloc]init];
    viewModel.delegate = self;
    
    _authStatuView = [[AuthStatuView alloc]initWithViewModel:viewModel];
    _authStatuView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    _authStatuView.backgroundColor = cwhite;
    [self.view addSubview:_authStatuView];
}

-(void)onHurryRequest:(Boolean)success{
    if(_authStatuView){
        [_authStatuView onHurryRequest:success];
    }
}

@end
