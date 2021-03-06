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
    [super viewWillAppear:animated];
    [self setStatuBarBackgroud:cwhite];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

-(void)initView{
    AuthStatuViewModel *viewModel = [[AuthStatuViewModel alloc]init];
    viewModel.delegate = self;
    
    _authStatuView = [[AuthStatuView alloc]initWithViewModel:viewModel];
    _authStatuView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    _authStatuView.backgroundColor = cwhite;
    [self.view addSubview:_authStatuView];
    
}


-(void)onRequestBegin{
    WS(weakSelf)
    dispatch_main_async_safe(^{
        [MBProgressHUD showHUDAddedTo:weakSelf.view animated:YES];
    });
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if(_authStatuView){
        [_authStatuView onHurryRequest:YES];
    }
    
    //***test***
    if([respondModel.requestUrl isEqualToString:URL_VERIFY_USER]){
        [STToastUtil showSuccessTips:@"恭喜您，账户通过验证！"];
    }
}

-(void)onRequestFail:(NSString *)msg{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [STToastUtil showWarnTips:msg];
    if(_authStatuView){
        [_authStatuView onHurryRequest:YES];
    }
}



@end
