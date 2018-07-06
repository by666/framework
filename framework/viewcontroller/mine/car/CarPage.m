//
//  CarPage.m
//  framework
//
//  Created by 黄成实 on 2018/5/15.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "CarPage.h"
#import "CarView.h"
#import "CarHistoryPage.h"
#import "CarDetailPage.h"
#import "STObserverManager.h"
#import "MonthPaymentPage.h"
#import "PaymentRecordPage.h"
#import "AddCarPage.h"

@interface CarPage ()<CarViewDelegate,STObserverProtocol>

@property(strong, nonatomic)CarView *carView;
@property(strong, nonatomic)CarViewModel *viewModel;


@end

@implementation CarPage

+(void)show:(BaseViewController *)controller{
    CarPage *page = [[CarPage alloc]init];
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = cwhite;
    WS(weakSelf)
    [self showSTNavigationBar:MSG_CAR_TITLE needback:YES rightBtn:MSG_CAR_RECORD rightColor:c13 block:^{
        [PaymentRecordPage show:weakSelf index:1];
    }];
    [self initView];
    [[STObserverManager sharedSTObserverManager]registerSTObsever:Notify_DeleteCar delegate:self];
    [[STObserverManager sharedSTObserverManager]registerSTObsever:Notify_AddCar delegate:self];

}

-(void)dealloc{
    [[STObserverManager sharedSTObserverManager]removeSTObsever:Notify_DeleteCar];
    [[STObserverManager sharedSTObserverManager]removeSTObsever:Notify_AddCar];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setStatuBarBackgroud:cwhite];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

-(void)initView{
    _viewModel = [[CarViewModel alloc]init];
    _viewModel.delegate = self;
    
    _carView = [[CarView alloc]initWithViewModel:_viewModel];
    _carView.backgroundColor = cwhite;
    _carView.frame = CGRectMake(0 ,StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    [self.view addSubview:_carView];
}


-(void)onGetCarDatas:(Boolean)success datas:(NSMutableArray *)datas{
    
}


-(void)onShowDeletePrompt:(CarModel *)model{
    WS(weakSelf)
    [STAlertUtil showAlertController:MSG_PROMPT content:MSG_CAR_DELETE_TIPS controller:self confirm:^{
        [weakSelf.viewModel deleteCarModel:model];
    }];
}
-(void)onDeleteCarModel:(Boolean)succes model:(CarModel *)model row:(NSInteger)row{
    if(_carView){
        [_carView onDeleteCar:model row:row];
    }
}

-(void)onAddCarModel:(Boolean)success model:(CarModel *)model{
    [_carView updateView];
}

-(void)onGoCarDetailPage:(CarModel *)model{
    [CarDetailPage show:self model:model];
}

-(void)onGoPaymentRecordsPage{
    [PaymentRecordPage show:self index:1];
}

-(void)onGoPaymentPage:(CarModel *)model{
    [MonthPaymentPage show:self model:model];
}

-(void)onGoAddCarPage{
    [AddCarPage show:self];
}


-(void)onReciveResult:(NSString *)key msg:(id)msg{
    if([key isEqualToString:Notify_DeleteCar]){
        CarModel *model = msg;
        [_viewModel deleteCarModel:model];
    }else if([key isEqualToString:Notify_AddCar]){
        CarModel *model = msg;
        [_viewModel addCarModel:model];
    }
}


@end
