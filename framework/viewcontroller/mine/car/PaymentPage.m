//
//  PaymentPage.m
//  framework
//
//  Created by 黄成实 on 2018/5/21.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "PaymentPage.h"
#import "PaymentView.h"

@interface PaymentPage()<PaymentViewDelegate>

@property(strong, nonatomic)CarModel *model;
@property(strong, nonatomic)PaymentViewModel *viewModel;
@property(strong, nonatomic)PaymentView *paymentView;

@end

@implementation PaymentPage


+(void)show:(BaseViewController *)controller model:(CarModel *)model{
    PaymentPage *page = [[PaymentPage alloc]init];
    page.model = model;
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = c15;
    [self showSTNavigationBar:MSG_PAYMENT_TITLE needback:YES];
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated{
    [self setStatuBarBackgroud:cwhite];
}

-(void)initView{
    PaymentViewModel *viewModel = [[PaymentViewModel alloc]initWithModel:_model];
    viewModel.delegate = self;
    
    _paymentView = [[PaymentView alloc]initWithViewModel:viewModel];
    _paymentView.backgroundColor = c15;
    _paymentView.frame = CGRectMake(0 ,StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    [self.view addSubview:_paymentView];
}

-(void)onWechatPay:(Boolean)success{
    [_paymentView updateView];
}

@end
