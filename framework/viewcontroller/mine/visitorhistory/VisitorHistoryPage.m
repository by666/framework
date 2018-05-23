//
//  VisitorHistoryPage.m
//  framework
//
//  Created by 黄成实 on 2018/5/15.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "VisitorHistoryPage.h"
#import "VisitorHistoryView.h"
#import "VisitorPage.h"
@interface VisitorHistoryPage ()<VisitorHistoryViewDelegate>

@end

@implementation VisitorHistoryPage

+(void)show:(BaseViewController *)controller{
    VisitorHistoryPage *page = [[VisitorHistoryPage alloc]init];
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = c15;
    WS(weakSelf)
    [self showSTNavigationBar:MSG_VISITORHISTORY_TITLE needback:YES rightBtn:MSG_VISITORHISTORY_RIGHTBTN block:^{
        [VisitorPage show:self type:People];
    }];
    [self initView];
}

-(void)initView{
    VisitorHistoryViewModel *viewModel = [[VisitorHistoryViewModel alloc]init];
    viewModel.delegate = self;
    
    VisitorHistoryView *visitorHistoryView = [[VisitorHistoryView alloc]initWithViewModel:viewModel];
    visitorHistoryView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    visitorHistoryView.backgroundColor = c15;
    [self.view addSubview:visitorHistoryView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self setStatuBarBackgroud:cwhite];
}

-(void)onGetVisitoryHistoryDatas:(Boolean)success{
    
}

-(void)onGoVisitorPage:(VisitorModel *)model{
    [VisitorPage show:self type:People model:model];
}

@end
