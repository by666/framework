//
//  FixHistroyPage.m
//  framework
//
//  Created by 黄成实 on 2018/6/8.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "FixHistroyPage.h"
#import "FixHistoryView.h"
#import "MainPage.h"

@interface FixHistroyPage ()<FixHistoryViewDelegate>

@property(strong, nonatomic)FixHistoryView *fixHistoryView;
@property(assign, nonatomic)Boolean fromReportFix;

@end

@implementation FixHistroyPage

+(void)show:(BaseViewController *)controller fromReportFix:(Boolean)fromReportFix{
    FixHistroyPage *page = [[FixHistroyPage alloc]init];
    page.fromReportFix = fromReportFix;
    [controller pushPage:page];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = c15;
    [self showSTNavigationBar:MSG_FIXHISTORY_TITLE needback:YES];
    [self initView];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setStatuBarBackgroud:cwhite];
}


-(void)initView{
  
    FixHistoryViewModel *viewModel = [[FixHistoryViewModel alloc]init];
    viewModel.delegate = self;
    
    _fixHistoryView = [[FixHistoryView alloc]initWithViewModel:viewModel];
    _fixHistoryView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    _fixHistoryView.backgroundColor = c15;
    
    [self.view addSubview:_fixHistoryView];
    
    [viewModel requestNew];

}

 -(void)backLastPage{
     if(_fromReportFix){
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
     
     
-(void)onRequestDatasCallback:(Boolean)success datas:(NSMutableArray *)datas{
    [_fixHistoryView updateView];
}

@end
