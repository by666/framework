//
//  OnePaymentView.m
//  framework
//
//  Created by 黄成实 on 2018/5/22.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "OnePaymentView.h"

@interface OnePaymentView()

@property(strong, nonatomic)OnePaymentViewModel *mViewModel;
@property(strong, nonatomic)UIView *mainView;
@property(strong, nonatomic)UIView *successView;

@end
@implementation OnePaymentView

-(instancetype)initWithViewModel:(OnePaymentViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    
    _mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ContentHeight)];
    [self addSubview:_mainView];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(10), ScreenWidth, STHeight(162))];
    view.backgroundColor = cwhite;
    [_mainView addSubview:view];
    
    NSArray *titles = @[@"车牌号码",@"进入时间",@"停车时长",@"缴费金额"];
    for(int i = 0 ; i< [titles count]; i++){
        UILabel *label = [[UILabel alloc]initWithFont:STFont(16) text:[titles objectAtIndex:i] textAlignment:NSTextAlignmentLeft textColor:c11 backgroundColor:nil multiLine:NO];
        label.frame = CGRectMake(STWidth(15), STHeight(25) + STHeight(37)*i, STWidth(100), STHeight(16));
        [_mainView addSubview:label];
    }
    
    NSArray *contents = @[_mViewModel.model.carNum,_mViewModel.model.enterTime,@"2小时15分",@"10元"];
    for(int i = 0 ; i< [contents count]; i++){
        UILabel *label = [[UILabel alloc]initWithFont:STFont(16) text:[contents objectAtIndex:i] textAlignment:NSTextAlignmentRight textColor:c12 backgroundColor:nil multiLine:NO];
        NSString *content = [contents objectAtIndex:i];
        CGSize lableSize = [content sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
        label.frame = CGRectMake(ScreenWidth - STWidth(15) - lableSize.width, STHeight(25) + STHeight(37)*i, lableSize.width, STHeight(16));
        [_mainView addSubview:label];
    }

    NSString *tipsStr =@"计费规则：\n\n1. 本次为代付，支付完成后访客车辆出场无需再次缴纳费用。\n\n2. 来访车辆首30分钟内免费，后续10元/小时。\n\n3. 支付完成后x分钟内出场;超时需计费。";
    UILabel *tipsLabel = [[UILabel alloc]initWithFont:STFont(14) text:tipsStr textAlignment:NSTextAlignmentLeft textColor:c20 backgroundColor:nil multiLine:YES];
    CGSize tipsSize = [STPUtil textSize:tipsStr maxWidth:ScreenWidth - STWidth(40) font:STFont(14)];
    tipsLabel.frame = CGRectMake(STWidth(20), STHeight(186), ScreenWidth - STWidth(40), tipsSize.height);
    [_mainView addSubview:tipsLabel];
    
    UIView *payView = [[UIView alloc]initWithFrame:CGRectMake(0, ContentHeight - STHeight(50), ScreenWidth, STHeight(50))];
    payView.backgroundColor = c20;
    [_mainView addSubview:payView];
    
    UIButton *paymentBtn = [[UIButton alloc]initWithFont:STFont(18) text:MSG_PAYMENT_PAY textColor:cwhite backgroundColor:c19 corner:0 borderWidth:0 borderColor:nil];
    paymentBtn.frame = CGRectMake(ScreenWidth -  STWidth(114),0, STWidth(114), STHeight(50));
    [paymentBtn addTarget:self action:@selector(doPay) forControlEvents:UIControlEventTouchUpInside];
    [payView addSubview:paymentBtn];
    
    UILabel *moneyLabel = [[UILabel alloc]initWithFont:STFont(18) text:@"¥ 10" textAlignment:NSTextAlignmentLeft textColor:cwhite backgroundColor:nil multiLine:YES];
    CGSize moneySize = [STPUtil textSize:@"¥ 10" maxWidth:ScreenWidth font:STFont(18)];
    moneyLabel.frame = CGRectMake(STWidth(15), STHeight(16), moneySize.width, STHeight(18));
    [payView addSubview:moneyLabel];
    
    [self initSuccessView];
}


-(void)initSuccessView{
    _successView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ContentHeight)];
    _successView.backgroundColor = cwhite;
    _successView.hidden = YES;
    [self addSubview:_successView];
    
    UIImageView *succesImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(158), STHeight(54), STWidth(60), STWidth(60))];
    succesImageView.image = [UIImage imageNamed:@"ic_pay_success"];
    [_successView addSubview:succesImageView];
    
    UILabel *tips1Label = [[UILabel alloc]initWithFont:STFont(18) text:MSG_ONEPAYMENT_SUCCEE_TIPS1 textAlignment:NSTextAlignmentCenter textColor:c20 backgroundColor:nil multiLine:YES];
    tips1Label.frame = CGRectMake(0, STHeight(142), ScreenWidth, STHeight(18));
    [_successView addSubview:tips1Label];
    
    UILabel *tips2Label = [[UILabel alloc]initWithFont:STFont(14) text:MSG_ONEPAYMENT_SUCCEE_TIPS2 textAlignment:NSTextAlignmentCenter textColor:c20 backgroundColor:nil multiLine:YES];
    tips2Label.frame = CGRectMake(0, STHeight(170), ScreenWidth, STHeight(14));
    [_successView addSubview:tips2Label];
    
}

-(void)doPay{
    if(_mViewModel){
        [_mViewModel doPay];
        _successView.hidden = NO;
        _mainView.hidden = YES;
    }
}

@end
