//
//  ReportFixPage.m
//  framework
//
//  Created by 黄成实 on 2018/6/6.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "ReportFixPage.h"
#import "ReportFixView.h"
#import "FixHistroyPage.h"

@interface ReportFixPage ()<ReportFixViewDelegate>

@property(strong, nonatomic)ReportFixView *reportFixView;

@end

@implementation ReportFixPage

+(void)show:(BaseViewController *)controller{
    ReportFixPage *page = [[ReportFixPage alloc]init];
    [controller pushPage:page];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = c15;
    WS(weakSelf)
    [self showSTNavigationBar:MSG_REPORTFIX_TITLE needback:YES rightBtn:MSG_REPORTFIX_RIGHT_BTN rightColor:c08 block:^{
        [FixHistroyPage show:weakSelf fromReportFix:NO];
    }];
    [self initView];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setStatuBarBackgroud:cwhite];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}


-(void)initView{
    ReportFixViewModel *viewModel = [[ReportFixViewModel alloc]init];
    viewModel.delegate = self;
    
    _reportFixView = [[ReportFixView alloc]initWithViewModel:viewModel];
    _reportFixView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    _reportFixView.backgroundColor = c15;
    [self.view addSubview:_reportFixView];
}

-(void)onDoReportFix:(Boolean)success{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
            [FixHistroyPage show:weakSelf fromReportFix:YES];

        });
    });
}


@end
