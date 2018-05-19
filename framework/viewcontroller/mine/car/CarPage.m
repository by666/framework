//
//  CarPage.m
//  framework
//
//  Created by 黄成实 on 2018/5/15.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "CarPage.h"
#import "CarView.h"
#import "AddCarPage.h"

@interface CarPage ()<CarViewDelegate>

@property(strong, nonatomic)CarView *carView;

@end

@implementation CarPage

+(void)show:(BaseViewController *)controller{
    CarPage *page = [[CarPage alloc]init];
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = cwhite;
    [self showSTNavigationBar:MSG_CAR_TITLE needback:YES ];
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated{
    [self setStatuBarBackgroud:cwhite];
}

-(void)initView{
    CarViewModel *viewModel = [[CarViewModel alloc]init];
    viewModel.delegate = self;
    
    _carView = [[CarView alloc]initWithViewModel:viewModel];
    _carView.backgroundColor = cwhite;
    _carView.frame = CGRectMake(0 ,StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    [self.view addSubview:_carView];
}


-(void)onGetCarDatas:(Boolean)success datas:(NSMutableArray *)datas{
    
}

-(void)onDeleteCarModel:(Boolean)succes model:(CarModel *)model{
    
}

-(void)onGoCarDetailPage:(CarModel *)model{
    
}

-(void)onGoPaymentRecordsPage{
    
}

-(void)onGoPaymentPage:(CarModel *)model{
    
}

-(void)onGoAddCarPage{
    [AddCarPage show:self];
}



@end
