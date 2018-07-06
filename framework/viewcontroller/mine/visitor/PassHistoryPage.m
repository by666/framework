//
//  PassHistoryPage.m
//  framework
//
//  Created by 黄成实 on 2018/6/27.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "PassHistoryPage.h"
#import "PassHistoryView.h"
#import "PassPage.h"
#import "STObserverManager.h"
#import "VisitorHomePage.h"
@interface PassHistoryPage ()<PassHistoryViewDelegate,STObserverProtocol>

@property(strong, nonatomic)PassHistoryView *passHistoryView;
@property(strong, nonatomic)PassHistoryViewModel *viewModel;
@end

@implementation PassHistoryPage

+(void)show:(BaseViewController *)controller{
    PassHistoryPage *page = [[PassHistoryPage alloc]init];
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = c15;
    [self showSTNavigationBar:MSG_PASSHISTORY_TITLE needback:YES];
    [self initView];
    [[STObserverManager sharedSTObserverManager]registerSTObsever:Notify_DeleteCheck delegate:self];
}

-(void)backLastPage{
    for (UIViewController *temp in self.navigationController.viewControllers) {
        if ([temp isKindOfClass:[VisitorHomePage class]]) {
            [self.navigationController popToViewController:temp animated:YES];
            break;
        }
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setStatuBarBackgroud:cwhite];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

-(void)dealloc{
    [[STObserverManager sharedSTObserverManager]removeSTObsever:Notify_DeleteCheck];
}


-(void)initView{
   
    _viewModel = [[PassHistoryViewModel alloc]init];
    _viewModel.delegate = self;
    
    _passHistoryView = [[PassHistoryView alloc]initWithViewModel:_viewModel];
    _passHistoryView.frame = CGRectMake(0, StatuBarHeight+NavigationBarHeight, ScreenWidth, ContentHeight);
    _passHistoryView.backgroundColor = c15;
    [self.view addSubview:_passHistoryView];
    
    [_viewModel requestDatas];
}


-(void)onRequestBegin{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

-(void)onRequestFail:(NSString *)msg{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [STToastUtil showFailureAlertSheet:msg];
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if(_passHistoryView){
        [_passHistoryView updateView];
    }
}

-(void)onGoPassPage:(PassHistoryModel *)model{
    PassModel *passModel = [[PassModel alloc]init];
    passModel.password = model.pwd;
    passModel.userUid = model.userUid;
    passModel.checkId = model.checkId;
    
    VisitorModel *visitorModel = [[VisitorModel alloc]init];
    visitorModel.name = model.userName;
    visitorModel.visitDate = model.startTime;
    visitorModel.carNum = model.licenseNum;
    visitorModel.faceUrl = model.faceUrl;
    
    [PassPage show:self passModel:passModel visitorModel:visitorModel needDelete:YES];
}

-(void)onReciveResult:(NSString *)key msg:(id)msg{
    if([key isEqualToString:Notify_DeleteCheck]){
        if(_viewModel){
            [_viewModel requestDatas];
        }
    }
}

@end
