//
//  CarDetailView.m
//  framework
//
//  Created by 黄成实 on 2018/5/21.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "CarDetailView.h"
#import "CarDetailCell.h"

@interface CarDetailView()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)CarDetailViewModel *mViewModel;
@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)UIButton *paymentBtn;

@end

@implementation CarDetailView

-(instancetype)initWithViewModel:(CarDetailViewModel *)viewModel{
    if(self == [self init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    
    UIView *contentView= [[UIView alloc]init];
    contentView.backgroundColor = cwhite;
    contentView.frame = CGRectMake(0, STHeight(10), ScreenWidth, ContentHeight - STHeight(10));
    [self addSubview:contentView];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, STHeight(10), ScreenWidth, STHeight(56.5)*[_mViewModel.titleDatas count])];
    _tableView.backgroundColor = cwhite;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_tableView];
    
    _paymentBtn = [[UIButton alloc]initWithFont:STFont(18) text:MSG_CARDETAIL_PAYMENT textColor:cwhite backgroundColor:c19 corner:STHeight(25) borderWidth:0 borderColor:nil];
    _paymentBtn.frame = CGRectMake(STWidth(50), STHeight(419), STWidth(276), STHeight(50));
    [_paymentBtn setBackgroundColor:c19a forState:UIControlStateHighlighted];
    [_paymentBtn addTarget:self action:@selector(goPaymentPage) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_paymentBtn];
    
    UILabel *tipsLabel = [[UILabel alloc]initWithFont:STFont(14) text:MSG_CARDETAIL_TIPS textAlignment:NSTextAlignmentLeft textColor:c12 backgroundColor:nil multiLine:YES];
    tipsLabel.frame = CGRectMake(STWidth(21), STHeight(532), ScreenWidth - STWidth(42), STHeight(37));
    [self addSubview:tipsLabel];
    

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

-(void)goPaymentPage{
    if(_mViewModel){
        [_mViewModel goPaymentPage];
    }
}
@end
