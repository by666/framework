//
//  AuthUserPage.m
//  framework
//
//  Created by 黄成实 on 2018/5/24.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "AuthUserPage.h"
#import "AuthUserView.h"
#import "CommunityPage.h"
#import "AuthFacePage.h"

@interface AuthUserPage ()<AuthUserViewDelegate>

@property(strong, nonatomic)AuthUserView *authUserView;
@end

@implementation AuthUserPage

+(void)show:(BaseViewController *)controller{
    AuthUserPage *page = [[AuthUserPage alloc]init];
    [controller pushPage:page];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = c15;
    [self initView];
    [self showSTNavigationBar:MSG_AUTHUSER_TITLE needback:YES];
}


-(void)viewWillAppear:(BOOL)animated{
    [self setStatuBarBackgroud:cwhite];
}

-(void)dealloc{
    if(_authUserView){
        [_authUserView removeView];
    }
}

-(void)initView{
    AuthUserViewModel *viewModel = [[AuthUserViewModel alloc]init];
    viewModel.delegate = self;
    
    _authUserView = [[AuthUserView alloc]initWithViewModel:viewModel];
    _authUserView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    _authUserView.backgroundColor = c15;
    [self.view addSubview:_authUserView];
}


-(void)onGoCommunity{
    [CommunityPage show:self];
}


-(void)submitUserInfo:(Boolean)success msg:(NSString *)errorMsg{
    [_authUserView onSubmitResult:success errorMsg:errorMsg];
    if(success){
        [AuthFacePage show:self];
    }
}



@end
