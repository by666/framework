//
//  DeviceShareOrderPage.m
//  framework
//
//  Created by 黄成实 on 2018/6/8.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "DeviceShareOrderPage.h"
#import "DeviceShareOrderView.h"

@interface DeviceShareOrderPage ()<DeviceShareOrderViewDelegate>

@property(strong, nonatomic)DeviceShareModel *mData;
@property(strong, nonatomic)DeviceShareOrderView *deviceOrderView;
@end

@implementation DeviceShareOrderPage


+(void)show:(BaseViewController *)controller data:(DeviceShareModel *)data{
    DeviceShareOrderPage *page = [[DeviceShareOrderPage alloc]init];
    page.mData = data;
    [controller pushPage:page];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = c15;
    [self showSTNavigationBar:MSG_DEVICESHAREORDER_TITLE needback:YES];
    [self initView];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setStatuBarBackgroud:cwhite];
}


-(void)initView{
    DeviceShareOrderViewModel *viewModel = [[DeviceShareOrderViewModel alloc]initWithData:_mData];
    viewModel.delegate = self;
    
    _deviceOrderView = [[DeviceShareOrderView alloc]initWithViewModel:viewModel];
    _deviceOrderView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    _deviceOrderView.backgroundColor = c15;
    [self.view addSubview:_deviceOrderView];
}

-(void)onDoWechatPay{
    WS(weakSelf)
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
            [weakSelf.deviceOrderView onPaySuccess];
        });
    });
}

@end
