//
//  VerificateUserPage.m
//  framework
//
//  Created by 黄成实 on 2018/5/30.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "VerificateUserPage.h"
#import "VerificateUserView.h"
#import "STObserverManager.h"
@interface VerificateUserPage ()<VerificateViewDelegate>

@property(strong, nonatomic)MessageModel *data;
@property(strong, nonatomic)VerificateUserView *verificateUserView;

@end

@implementation VerificateUserPage

+(void)show:(BaseViewController *)controller model:(MessageModel *)model{
    VerificateUserPage *page = [[VerificateUserPage alloc]init];
    page.data = model;
    [controller pushPage:page];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = c15;
    [self showSTNavigationBar:MSG_VERIFICATE_USER_TITLE needback:YES];
    [self initView];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setStatuBarBackgroud:cwhite];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

-(void)initView{
    VerificateViewModel *viewModel = [[VerificateViewModel alloc]initWithModel:_data];
    viewModel.delegate = self;
    
    _verificateUserView = [[VerificateUserView alloc]initWithViewModel:viewModel];
    _verificateUserView.frame = CGRectMake(0,StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    _verificateUserView.backgroundColor = c15;
    [self.view addSubview:_verificateUserView];
    
    [viewModel requestData];
}


-(void)onRequestBegin{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if([respondModel.requestUrl isEqualToString:URL_GET_MESSAGE_APPLY]){
        if(_verificateUserView){
            [_verificateUserView updateView];
        }
    }else if([respondModel.requestUrl isEqualToString:URL_POST_MESSAGE_APPLY]){
        [[STObserverManager sharedSTObserverManager]sendMessage:Notify_Message_Statu_Change msg:data];
        [self backLastPage];
    }
}

-(void)onRequestFail:(NSString *)msg{
    [STToastUtil showFailureAlertSheet:msg];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

@end
