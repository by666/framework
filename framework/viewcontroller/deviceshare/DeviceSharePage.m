//
//  DeviceSharePage.m
//  framework
//
//  Created by 黄成实 on 2018/6/7.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "DeviceSharePage.h"
#import "DeviceShareView.h"
#import "DeviceShareOrderPage.h"
#import "DeviceShareHistoryPage.h"
@interface DeviceSharePage ()<DeviceShareViewDelegate>
@property(strong, nonatomic)DeviceShareView *deviceShareView;
@end

@implementation DeviceSharePage

+(void)show:(BaseViewController *)controller{
    DeviceSharePage *page = [[DeviceSharePage alloc]init];
    [controller pushPage:page];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = c15;
    WS(weakSelf)
    [self showSTNavigationBar:MSG_DEVICESHARE_TITLE needback:YES rightBtn:MSG_DEVICESHARE_RIGHT_BTN rightColor:c13 block:^{
        [DeviceShareHistoryPage show:weakSelf];
    }];
    [self initView];
}


-(void)viewWillAppear:(BOOL)animated{
    [self setStatuBarBackgroud:cwhite];
}


-(void)initView{
    DeviceShareViewModel *viewModel = [[DeviceShareViewModel alloc]init];
    viewModel.delegate = self;
    
    _deviceShareView = [[DeviceShareView alloc]initWithViewModel:viewModel];
    _deviceShareView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    _deviceShareView.backgroundColor = c15;
    [self.view addSubview:_deviceShareView];
}

-(void)onRequestDatas:(Boolean)success datas:(NSMutableArray *)datas{
}

-(void)onGoDeviceShareOrderPage:(DeviceShareModel *)model{
    [DeviceShareOrderPage show:self data:model];
}



@end
