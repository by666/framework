
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
    
    WS(weakSelf)
    [self showSTNavigationBar:MSG_CARDETAIL_TITLE needback:YES rightBtn:MSG_DELETE block:^{
        [weakSelf deleteCar];
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

 -(void)deleteCar{
     WS(weakSelf)
     [STAlertUtil showAlertController:MSG_WARN content:MSG_CAR_DELETE_TIPS controller:self confirm:^{
         if(weakSelf.viewModel){
             [weakSelf.viewModel deleteCarData];
         }
     }];
 }

-(void)onGoPaymentPage{
    [MonthPaymentPage show:self model:_model];
}

-(void)onDeleteCarData{
    [[STObserverManager sharedSTObserverManager] sendMessage:Notify_DeleteCar msg:_model];
    [self backLastPage];
}
     
     

@end
