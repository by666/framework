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
#import "BaseNoNetView.h"
#import "STNetUtil.h"
@interface VisitorHistoryPage ()<VisitorHistoryViewDelegate>

@property(strong, nonatomic)VisitorHistoryView *visitorHistoryView;
@property(strong, nonatomic)BaseNoNetView *noNetView;
@property(strong, nonatomic)VisitorHistoryViewModel *viewModel;

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
    _viewModel = [[VisitorHistoryViewModel alloc]init];
    _viewModel.delegate = self;
    
    _visitorHistoryView = [[VisitorHistoryView alloc]initWithViewModel:_viewModel];
    _visitorHistoryView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    _visitorHistoryView.backgroundColor = c15;
    [self.view addSubview:_visitorHistoryView];
    
    if([STNetUtil isNetAvailable]){
        _visitorHistoryView.hidden = NO;
        [_viewModel getVisitoryHistoryDatas];
        
    }else{
        _visitorHistoryView.hidden = YES;
        WS(weakSelf)
        _noNetView = [[BaseNoNetView alloc]initWithBlock:^{
            if(weakSelf.viewModel){
                [weakSelf.viewModel getVisitoryHistoryDatas];
            }
        }];
        [self.view addSubview:_noNetView];
    }

    
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
    _visitorHistoryView.hidden = NO;
    _noNetView.hidden = YES;
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

-(void)onBackLastPage{
    [self backLastPage];
}

@end
