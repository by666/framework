//
//  PaymentRecordPage.m
//  framework
//
//  Created by 黄成实 on 2018/5/21.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "PaymentRecordPage.h"
#import "PaymentRecordView.h"
#import "MainPage.h"

@interface PaymentRecordPage()<PaymentRecordViewDelegate>

@property(assign, nonatomic)NSInteger mIndex;
@property(strong, nonatomic)PaymentRecordView *paymentRecordView;
@end

@implementation PaymentRecordPage

+(void)show:(BaseViewController *)controller index:(NSInteger)index{
    PaymentRecordPage *page = [[PaymentRecordPage alloc]init];
    page.mIndex = index;
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = c15;
    [self showSTNavigationBar:MSG_PAYMENTRECORD_TITLE needback:YES];
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated{
    [self setStatuBarBackgroud:cwhite];
}

-(void)initView{
    PaymentRecordViewModel *viewModel = [[PaymentRecordViewModel alloc]init];
    viewModel.delegate = self;
    
    _paymentRecordView = [[PaymentRecordView alloc]initWithViewModel:viewModel index:_mIndex];
    _paymentRecordView.backgroundColor = c15;
    _paymentRecordView.frame = CGRectMake(0 ,StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    [self.view addSubview:_paymentRecordView];
 
}


-(void)onGetVisitorPaymentDatas:(Boolean)success{
    
}

-(void)onGetMonthPaymentDatas:(Boolean)success{
    
}

@end
