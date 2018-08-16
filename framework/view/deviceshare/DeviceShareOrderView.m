//
//  DeviceShareOrderView.m
//  framework
//
//  Created by 黄成实 on 2018/6/8.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "DeviceShareOrderView.h"
#import "STResultView.h"
#import "DeviceShareOrderViewCell.h"
#import "STSinglePickerLayerView.h"

@interface DeviceShareOrderView()<UITableViewDelegate,UITableViewDataSource,STSinglePickerLayerViewDelegate>

@property(strong, nonatomic)DeviceShareOrderViewModel *mViewModel;
@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)UIView *payView;
@property(strong, nonatomic)STSinglePickerLayerView *pickerView;
@property(strong, nonatomic)STResultView  *successView;
@property(strong, nonatomic) UILabel *moneyLabel;
@end

@implementation DeviceShareOrderView{
    int per;
    int days;
}

-(instancetype)initWithViewModel:(DeviceShareOrderViewModel *)viewModel{
    if(self == [self init]){
        _mViewModel = viewModel;
        days = 1;
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
    
    UIButton *paymentBtn = [[UIButton alloc]initWithFont:STFont(18) text:MSG_PAYMENT_PAY textColor:cwhite backgroundColor:c08 corner:0 borderWidth:0 borderColor:nil];
    paymentBtn.frame = CGRectMake(ScreenWidth -  STWidth(114),0, STWidth(114), STHeight(50));
    [paymentBtn addTarget:self action:@selector(doPay) forControlEvents:UIControlEventTouchUpInside];
    [paymentBtn setBackgroundColor:c08a forState:UIControlStateHighlighted];
    [payView addSubview:paymentBtn];
    
    per = [[_mViewModel.data.price substringWithRange:NSMakeRange(0, _mViewModel.data.price.length - 3)] intValue];
    NSString *moneyStr = [NSString stringWithFormat:@"¥ %d元",per];
    _moneyLabel = [[UILabel alloc]initWithFont:STFont(18) text:moneyStr textAlignment:NSTextAlignmentLeft textColor:cwhite backgroundColor:nil multiLine:YES];
    [_moneyLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:STFont(18)]];
    _moneyLabel.frame = CGRectMake(STWidth(15), STHeight(16), ScreenWidth - STWidth(15) - STWidth(114), STHeight(18));
    [payView addSubview:_moneyLabel];
    
    NSMutableArray *datas = [[NSMutableArray alloc]init];
    for(int i = 1 ; i <= 10; i++){
        [datas addObject:[NSString stringWithFormat:@"%d天",i]];
    }
    _pickerView = [[STSinglePickerLayerView alloc]initWithDatas:datas];
    _pickerView.hidden = YES;
    _pickerView.delegate = self;
    [self addSubview:_pickerView];
    
    NSString *random = [NSString stringWithFormat:@"%d%d%d%d",arc4random() % 5,arc4random() % 5,arc4random() % 5,arc4random() % 5];
    _successView = [[STResultView alloc]initWithTips:MSG_DEVICESHAREORDER_PAYSUCCESS tips2:[NSString stringWithFormat:MSG_DEVICESHAREORDER_CODE,random]];
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
    DeviceShareOrderViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[DeviceShareOrderViewCell identify]];
    if(!cell){
        cell = [[DeviceShareOrderViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[DeviceShareOrderViewCell identify]];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if(indexPath.row == 1){
        [cell.selectBtn addTarget:self action:@selector(onClickSelectBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    TitleContentModel *model = [_mViewModel.titleDatas objectAtIndex:indexPath.row];
    [cell updateData:model];
    return cell;
}

-(void)onClickSelectBtn{
    _pickerView.hidden = NO;
    TitleContentModel *model = [_mViewModel.titleDatas objectAtIndex:1];
    [_pickerView setData:[NSString stringWithFormat:@"%@天",model.content]];
}

-(void)onSelectResult:(NSString *)result{
    TitleContentModel *model = [_mViewModel.titleDatas objectAtIndex:1];
    model.content = [result substringWithRange:NSMakeRange(0, result.length -1)];
    days = [model.content intValue];
    _moneyLabel.text = [NSString stringWithFormat:@"¥ %d元",per * days];
    [_tableView reloadData];
}



-(void)doPay{
    if(_mViewModel){
        [_mViewModel doWechatPay:days];
    }
}

-(void)onPaySuccess{
    _successView.hidden = NO;
}

-(void)updateView{
    _tableView.hidden = YES;
    _payView.hidden = YES;
    _successView.hidden = NO;
}

@end
