//
//  CarHistoryPage.m
//  framework
//
//  Created by 黄成实 on 2018/5/15.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "CarHistoryPage.h"
#import "CarHistoryView.h"
#import "OnePaymentPage.h"
#import "PaymentRecordPage.h"

@interface CarHistoryPage ()<CarHistoryViewDelegate>

@property(strong, nonatomic)CarHistoryView *carHistoryView;
@end

@implementation CarHistoryPage

+(void)show:(BaseViewController *)controller{
    CarHistoryPage *page = [[CarHistoryPage alloc]init];
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = c15;
    WS(weakSelf)
    [self showSTNavigationBar:MSG_CARHISTORY_TITLE needback:YES rightBtn:MSG_ONEPAYMENT_RIGHTBTN rightColor:c13 block:^{
        [PaymentRecordPage show:weakSelf index:0];
    }];
    
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setStatuBarBackgroud:cwhite];
}

-(void)initView{
    CarHistoryViewModel *viewModel = [[CarHistoryViewModel alloc]init];
    viewModel.delegate = self;
    
    _carHistoryView = [[CarHistoryView alloc]initWithViewModel:viewModel];
    _carHistoryView.backgroundColor = cwhite;
    _carHistoryView.frame = CGRectMake(0 ,StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    [self.view addSubview:_carHistoryView];
}

-(void)onGetCarHistoryDatas:(Boolean)success{
    
}

-(void)onGoOnePaymentPage:(CarHistoryModel *)model{
    [OnePaymentPage show:self model:model];
}

@end
