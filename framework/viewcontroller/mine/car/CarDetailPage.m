
//
//  CarDetailPage.m
//  framework
//
//  Created by 黄成实 on 2018/5/19.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "CarDetailPage.h"
#import "STObserverManager.h"
#import "MonthPaymentPage.h"

@interface CarDetailPage()<CarDetailViewDelegate>

@property(strong, nonatomic)CarDetailView *carDetailView;
@property(strong, nonatomic)CarDetailViewModel *viewModel;
@property(strong, nonatomic)CarModel *model;

@end

@implementation CarDetailPage

+(void)show:(BaseViewController *)controller model:(CarModel *)model{
    CarDetailPage *page = [[CarDetailPage alloc]init];
    page.model = model;
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = c15;
    [self initView];
    
    __weak CarDetailPage *weakSelf = self;
    [self showSTNavigationBar:MSG_CARDETAIL_TITLE needback:YES rightBtn:MSG_DELETE block:^{
        [weakSelf.viewModel deleteCarData];
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [self setStatuBarBackgroud:cwhite];
}

-(void)initView{
    _viewModel = [[CarDetailViewModel alloc]initWithModel:_model];
    _viewModel.delegate = self;
    
    _carDetailView = [[CarDetailView alloc]initWithViewModel:_viewModel];
    _carDetailView.backgroundColor = c15;
    _carDetailView.frame = CGRectMake(0 ,StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    [self.view addSubview:_carDetailView];
}


-(void)onGoPaymentPage{
    [MonthPaymentPage show:self model:_model];
}

-(void)onDeleteCarData{
    [[STObserverManager sharedSTObserverManager] sendMessage:Notify_DeleteCar msg:_model];
    [self backLastPage];
}

@end
