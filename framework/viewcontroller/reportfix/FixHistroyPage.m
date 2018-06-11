//
//  FixHistroyPage.m
//  framework
//
//  Created by 黄成实 on 2018/6/8.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "FixHistroyPage.h"
#import "FixHistoryView.h"

@interface FixHistroyPage ()<FixHistoryViewDelegate>

@property(strong, nonatomic)FixHistoryView *fixHistoryView;
@end

@implementation FixHistroyPage


+(void)show:(BaseViewController *)controller{
    FixHistroyPage *page = [[FixHistroyPage alloc]init];
    [controller pushPage:page];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = c15;
    [self showSTNavigationBar:MSG_FIXHISTORY_TITLE needback:YES];
    [self initView];
}


-(void)viewWillAppear:(BOOL)animated{
    [self setStatuBarBackgroud:cwhite];
}


-(void)initView{
  
    FixHistoryViewModel *viewModel = [[FixHistoryViewModel alloc]init];
    viewModel.delegate = self;
    
    _fixHistoryView = [[FixHistoryView alloc]initWithViewModel:viewModel];
    _fixHistoryView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    _fixHistoryView.backgroundColor = c15;
    
    [self.view addSubview:_fixHistoryView];
}

-(void)onRequestDatasCallback:(Boolean)success datas:(NSMutableArray *)datas{
    
}

@end
