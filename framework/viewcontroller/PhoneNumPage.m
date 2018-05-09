//
//  PhoneNumPage.m
//  framework
//
//  Created by 黄成实 on 2018/5/9.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "PhoneNumPage.h"
#import "PhoneViewModel.h"
#import "PhoneNumView.h"

@interface PhoneNumPage ()<PhoneDelegate>

@property(strong, nonatomic)PhoneViewModel *mViewModel;
@property(strong, nonatomic)PhoneNumView *mPhoneNumView;

@end

@implementation PhoneNumPage


- (void)viewDidLoad {
    [super viewDidLoad];
    _mViewModel = [[PhoneViewModel alloc]init];
    _mViewModel.delegate = self;
    [self initView];
}


-(void)initView{
    _mPhoneNumView = [[PhoneNumView alloc]initWithViewModel:_mViewModel];
    _mPhoneNumView.frame = CGRectMake(0, StatuBarHeight, ScreenWidth, ScreenHeight - StatuBarHeight);
    _mPhoneNumView.backgroundColor = c01;
    [self.view addSubview:_mPhoneNumView];
}

-(void)OnBindPhoneNum:(Boolean)success msg:(NSString *)msg{
    [MBProgressHUD hideHUDForView:_mPhoneNumView animated:YES];
    if(success){
        [_mPhoneNumView updateView];
        [STAlertUtil showAlertController:@"提示" content:@"绑定成功" controller:self];
    }else{
        [STAlertUtil showAlertController:@"提示" content:msg controller:self];
    }

}


@end
