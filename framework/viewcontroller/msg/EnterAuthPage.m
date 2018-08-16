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
    if(IS_NS_STRING_EMPTY(_data.licenseNum)){
        [self showSTNavigationBar:MSG_ENTERAUTH_VISITOR_TITLE needback:YES];
    }else{
        [self showSTNavigationBar:MSG_ENTERAUTH_CAR_TITLE needback:YES];
    }
    [self initView];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setStatuBarBackgroud:cwhite];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
}

-(void)initView{
 
    EnterAuthViewModel *viewModel = [[EnterAuthViewModel alloc]initWithData:_data];
    viewModel.delegate = self;
    
    _enterAuthView = [[EnterAuthView alloc]initWithViewModel:viewModel];
    _enterAuthView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    [self.view addSubview:_enterAuthView];
    
    [viewModel requestData];

}



-(void)onRequestBegin{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if([respondModel.requestUrl isEqualToString:URL_GET_MESSAGE_VISITOR]){
        if(_enterAuthView){
            [_enterAuthView updateView];
        }
    }else if([respondModel.requestUrl isEqualToString:URL_POST_MESSAGE_VISITOR]){
        [[STObserverManager sharedSTObserverManager]sendMessage:Notify_Message_Statu_Change msg:data];
        [self backLastPage];
    }
}

-(void)onRequestFail:(NSString *)msg{
    [STToastUtil showFailureAlertSheet:msg];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

@end
