//
//  AddCarPage.m
//  framework
//
//  Created by 黄成实 on 2018/5/19.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "AddCarPage.h"
#import "AddCarView.h"

@interface AddCarPage()<AddCarViewDelegate>

@property(strong, nonatomic)AddCarView *addCarView;
@end

@implementation AddCarPage

+(void)show:(BaseViewController *)controller{
    AddCarPage *page = [[AddCarPage alloc]init];
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = c15;
    [self initView];

    __weak AddCarPage *weakSelf = self;
    [self showSTNavigationBar:MSG_ADDCAR_TITLE needback:YES rightBtn:MSG_COMMIT block:^{
        [weakSelf.addCarView addCarData];
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [self setStatuBarBackgroud:cwhite];
}

-(void)initView{
    AddCarViewModel *viewModel = [[AddCarViewModel alloc]init];
    viewModel.delegate = self;
    
    _addCarView = [[AddCarView alloc]initWithViewModel:viewModel];
    _addCarView.backgroundColor = c15;
    _addCarView.frame = CGRectMake(0 ,StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    [self.view addSubview:_addCarView];
}

-(void)onAddCarDatas:(Boolean)success data:(CarModel *)data{
    if(success){
        [self backLastPage];
    }else{
        [STAlertUtil showAlertController:@"" content:MSG_ADDCAR_CARNUM_ERROR controller:self];
    }
}




@end
