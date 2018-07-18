//
//  VisitorHistoryPage.m
//  framework
//
//  Created by 黄成实 on 2018/5/15.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "VisitorHistoryPage.h"
#import "VisitorHistoryView.h"
#import "VisitorPage.h"
@interface VisitorHistoryPage ()<VisitorHistoryViewDelegate>

@property(strong, nonatomic)VisitorHistoryView *visitorHistoryView;
@end

@implementation VisitorHistoryPage

+(void)show:(BaseViewController *)controller{
    VisitorHistoryPage *page = [[VisitorHistoryPage alloc]init];
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = c15;
    WS(weakSelf)
    [self showSTNavigationBar:MSG_VISITORHISTORY_TITLE needback:YES rightBtn:MSG_VISITORHISTORY_RIGHTBTN  rightColor:c13 block:^{
        [VisitorPage show:weakSelf type:People];
    }];
    [self initView];
}

-(void)initView{
    VisitorHistoryViewModel *viewModel = [[VisitorHistoryViewModel alloc]init];
    viewModel.delegate = self;
    
    _visitorHistoryView = [[VisitorHistoryView alloc]initWithViewModel:viewModel];
    _visitorHistoryView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    _visitorHistoryView.backgroundColor = c15;
    [self.view addSubview:_visitorHistoryView];
    
    [viewModel getVisitoryHistoryDatas];

    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setStatuBarBackgroud:cwhite];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

-(void)onRequestBegin{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if(_visitorHistoryView){
        [_visitorHistoryView updateView];
    }
}

-(void)onRequestFail:(NSString *)msg{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [STToastUtil showFailureAlertSheet:msg];
}

-(void)onGoVisitorPage:(VisitorModel *)model{
    [VisitorPage show:self type:People model:model];
}

@end
