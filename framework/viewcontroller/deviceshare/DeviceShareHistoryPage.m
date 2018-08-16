//
//  DeviceShareHistoryPage.m
//  framework
//
//  Created by 黄成实 on 2018/6/8.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "DeviceShareHistoryPage.h"
#import "DeviceShareHistoryView.h"
#import "MainPage.h"
@interface DeviceShareHistoryPage ()<DeviceShareHistoryDelegate>

@property(strong, nonatomic)DeviceShareHistoryView *deviceShareHistoryView;
@property(assign, nonatomic)Boolean fromOrder;

@end

@implementation DeviceShareHistoryPage

+(void)show:(BaseViewController *)controller fromOrder:(Boolean)fromOrder{
    DeviceShareHistoryPage *page = [[DeviceShareHistoryPage alloc]init];
    page.fromOrder = fromOrder;
    [controller pushPage:page];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = c15;
    [self showSTNavigationBar:MSG_DEVICESHAREHISTORY_TITLE needback:YES];
    [self initView];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setStatuBarBackgroud:cwhite];
}


-(void)initView{
    DeviceShareHistoryViewModel *viewModel = [[DeviceShareHistoryViewModel alloc]init];
    viewModel.delegate = self;
    
    _deviceShareHistoryView = [[DeviceShareHistoryView alloc]initWithViewModel:viewModel];
    _deviceShareHistoryView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    _deviceShareHistoryView.backgroundColor = c15;
    [self.view addSubview:_deviceShareHistoryView];
    
    [viewModel requestDatas];

}

-(void)onRequestDatas:(Boolean)success{
    if(_deviceShareHistoryView){
        [_deviceShareHistoryView updateView];
    }
}

-(void)backLastPage{
    if(_fromOrder){
        for (UIViewController *temp in self.navigationController.viewControllers) {
            if ([temp isKindOfClass:[MainPage class]]) {
                [self.navigationController popToViewController:temp animated:YES];
                break;
            }
        }
    }else{
        [super backLastPage];
    }
}

@end
