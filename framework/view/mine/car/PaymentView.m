//
//  PaymentView.m
//  framework
//
//  Created by 黄成实 on 2018/5/21.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "PaymentView.h"
#import "CarDetailCell.h"
#import "STResultView.h"
@interface PaymentView()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)PaymentViewModel *mViewModel;
@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)UIView *payView;
@property(strong, nonatomic)STResultView  *successView;
@end

@implementation PaymentView

-(instancetype)initWithViewModel:(PaymentViewModel *)viewModel{
    if(self == [self init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, STHeight(10), ScreenWidth, STHeight(56.5)*[_mViewModel.titleDatas count])];
    _tableView.backgroundColor = cwhite;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_tableView];
    
    UIView *payView = [[UIView alloc]initWithFrame:CGRectMake(0, ContentHeight - STHeight(50), ScreenWidth, STHeight(50))];
    payView.backgroundColor = c20;
    [self addSubview:payView];
    
    UIButton *paymentBtn = [[UIButton alloc]initWithFont:STFont(18) text:MSG_PAYMENT_PAY textColor:cwhite backgroundColor:c19 corner:0 borderWidth:0 borderColor:nil];
    paymentBtn.frame = CGRectMake(ScreenWidth -  STWidth(114),0, STWidth(114), STHeight(50));
    [paymentBtn addTarget:self action:@selector(doPay) forControlEvents:UIControlEventTouchUpInside];
    [paymentBtn setBackgroundColor:c19a forState:UIControlStateHighlighted];
    [payView addSubview:paymentBtn];
    
    UILabel *moneyLabel = [[UILabel alloc]initWithFont:STFont(18) text:@"¥ 300" textAlignment:NSTextAlignmentLeft textColor:cwhite backgroundColor:nil multiLine:YES];
    CGSize moneySize = [STPUtil textSize:@"¥ 300" maxWidth:ScreenWidth font:STFont(18)];
    moneyLabel.frame = CGRectMake(STWidth(15), STHeight(16), moneySize.width, STHeight(18));
    [payView addSubview:moneyLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(25)+moneySize.width, STHeight(16) , STWidth(1), STHeight(18))];
    lineView.backgroundColor = c09;
    [payView addSubview:lineView];
    
    UILabel *dateLabel = [[UILabel alloc]initWithFont:STFont(12) text:@"缴费截止至2019.05.21" textAlignment:NSTextAlignmentLeft textColor:c09 backgroundColor:nil multiLine:YES];
    CGSize dateSize = [STPUtil textSize:@"缴费截止至2019.05.21" maxWidth:ScreenWidth font:STFont(12)];
    dateLabel.frame = CGRectMake(STWidth(34)+moneySize.width, STHeight(19), dateSize.width, STHeight(12));
    [payView addSubview:dateLabel];
    
    
    _successView = [[STResultView alloc]initWithTips:MSG_PAYMENT_SUCCEE_TIPS1 tips2:MSG_PAYMENT_SUCCEE_TIPS2];
    _successView.hidden = YES;
    [self addSubview:_successView];
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_mViewModel.titleDatas count];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return STHeight(56.5);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CarDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:[CarDetailCell identify]];
    if(!cell){
        cell = [[CarDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[CarDetailCell identify]];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    TitleContentModel *model = [_mViewModel.titleDatas objectAtIndex:indexPath.row];
    [cell updateData:model];
    return cell;
}

-(void)doPay{
    if(_mViewModel){
        [_mViewModel doWechatPay];
    }
}

-(void)updateView{
    _tableView.hidden = YES;
    _payView.hidden = YES;
    _successView.hidden = NO;
}

@end
