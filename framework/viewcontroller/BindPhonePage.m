//
//  PhoneNumPage.m
//  framework
//
//  Created by 黄成实 on 2018/5/9.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "BindPhonePage.h"
#import "BindPhoneViewModel.h"
#import "BindPhoneView.h"
#import "MainPage.h"

@interface BindPhonePage ()<PhoneDelegate>

@property(strong, nonatomic)BindPhoneViewModel *mViewModel;
@property(strong, nonatomic)BindPhoneView *mBindPhoneView;

@end

@implementation BindPhonePage


- (void)viewDidLoad {
    [super viewDidLoad];
    _mViewModel = [[BindPhoneViewModel alloc]init];
    _mViewModel.delegate = self;
    [self initView];
}


-(void)initView{
    _mBindPhoneView = [[BindPhoneView alloc]initWithViewModel:_mViewModel];
    _mBindPhoneView.frame = CGRectMake(0, StatuBarHeight, ScreenWidth, ScreenHeight - StatuBarHeight);
    _mBindPhoneView.backgroundColor = c01;
    [self.view addSubview:_mBindPhoneView];
}

-(void)OnBindPhoneNum:(Boolean)success msg:(NSString *)msg{
    [MBProgressHUD hideHUDForView:_mBindPhoneView animated:YES];
    if(success){
        [_mBindPhoneView updateView];
        MainPage *page = [[MainPage alloc]init];
        [self pushPage:page];
    }else{
        [STAlertUtil showAlertController:@"提示" content:msg controller:self];
    }

}


@end
