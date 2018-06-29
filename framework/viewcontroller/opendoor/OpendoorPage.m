//
//  OpendoorPage.m
//  framework
//
//  Created by 黄成实 on 2018/6/6.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "OpendoorPage.h"
#import "OpendoorView.h"

@interface OpendoorPage ()<OpendoorViewDelegate>

@property(strong, nonatomic)OpendoorView *opendoorView;

@end

@implementation OpendoorPage

+(void)show:(BaseViewController *)controller{
    OpendoorPage *page = [[OpendoorPage alloc]init];
    [controller pushPage:page];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = cwhite;
    [self showSTNavigationBar:MSG_OPENDOOR_TITLE needback:YES];
    [self initView];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setStatuBarBackgroud:cwhite];
}


-(void)initView{
    OpendoorViewModel *viewModel = [[OpendoorViewModel alloc]init];
    viewModel.delegate = self;
    
    _opendoorView = [[OpendoorView alloc]initWithViewModel:viewModel];
    _opendoorView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    _opendoorView.backgroundColor = cwhite;
    [self.view addSubview:_opendoorView];
}


-(void)onGenerateTempLock:(Boolean)success{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
            [weakSelf.opendoorView onGenerateTempLock];
        });
    });
}

@end

