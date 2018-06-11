//
//  DeviceShareHistoryPage.m
//  framework
//
//  Created by 黄成实 on 2018/6/8.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "DeviceShareHistoryPage.h"
#import "DeviceShareHistoryView.h"
@interface DeviceShareHistoryPage ()<DeviceShareHistoryDelegate>

@property(strong, nonatomic)DeviceShareHistoryView *deviceShareHistoryView;
@end

@implementation DeviceShareHistoryPage

+(void)show:(BaseViewController *)controller{
    DeviceShareHistoryPage *page = [[DeviceShareHistoryPage alloc]init];
    [controller pushPage:page];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = c15;
    [self showSTNavigationBar:MSG_DEVICESHAREHISTORY_TITLE needback:YES];
    [self initView];
}


-(void)viewWillAppear:(BOOL)animated{
    [self setStatuBarBackgroud:cwhite];
}


-(void)initView{
    DeviceShareHistoryViewModel *viewModel = [[DeviceShareHistoryViewModel alloc]init];
    viewModel.delegate = self;
    
    _deviceShareHistoryView = [[DeviceShareHistoryView alloc]initWithViewModel:viewModel];
    _deviceShareHistoryView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    _deviceShareHistoryView.backgroundColor = c15;
    [self.view addSubview:_deviceShareHistoryView];
}

-(void)onRequestDatas:(Boolean)success{
    if(success){
        WS(weakSelf)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)( 1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.deviceShareHistoryView updateView];
            });
        });
    }
}

@end
