//
//  OnePaymentPage.m
//  framework
//
//  Created by 黄成实 on 2018/5/22.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "OnePaymentPage.h"
#import "OnePaymentView.h"

@interface OnePaymentPage ()<OnePaymentViewDelegate>

@property(strong, nonatomic)OnePaymentView *onePaymentView;
@property(strong, nonatomic)CarHistoryModel *model;
@end

@implementation OnePaymentPage

+(void)show:(BaseViewController *)controller model:(CarHistoryModel *)model{
    OnePaymentPage *page = [[OnePaymentPage alloc]init];
    page.model = model;
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = c15;
    [self showSTNavigationBar:MSG_ONEPAYMENT_TITLE needback:YES];
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated{
    [self setStatuBarBackgroud:cwhite];
}

-(void)initView{
    OnePaymentViewModel *viewModel = [[OnePaymentViewModel alloc]init];
    viewModel.model = _model;
    viewModel.delegate = self;
    
    _onePaymentView = [[OnePaymentView alloc]initWithViewModel:viewModel];
    _onePaymentView.backgroundColor = c15;
    _onePaymentView.frame = CGRectMake(0 ,StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    [self.view addSubview:_onePaymentView];
}


-(void)onPayResult:(Boolean)success{
    
}

@end
