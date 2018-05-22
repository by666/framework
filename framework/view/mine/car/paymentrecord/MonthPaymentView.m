//
//  MonthPaymentView.m
//  framework
//
//  Created by 黄成实 on 2018/5/22.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MonthPaymentView.h"
#import "MonthPaymentCell.h"
@interface MonthPaymentView()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)PaymentRecordViewModel *mViewModel;
@property(strong, nonatomic)UITableView *tableView;

@end

@implementation MonthPaymentView

-(instancetype)initWithViewModel:(PaymentRecordViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}


-(void)initView{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ContentHeight - STHeight(44))];
    _tableView.backgroundColor = c15;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.contentSize = CGSizeMake(ScreenWidth, STHeight(206)*[_mViewModel.monthPaymentDatas count]);
    [self addSubview:_tableView];
    
    [_mViewModel getMonthPaymentDatas];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = c15;
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return STHeight(10);
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return STHeight(196);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_mViewModel.monthPaymentDatas count];
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MonthPaymentCell *cell = [tableView dequeueReusableCellWithIdentifier:[MonthPaymentCell identify]];
    if(!cell){
        cell = [[MonthPaymentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MonthPaymentCell identify]];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    MonthPaymentModel *model = [_mViewModel.monthPaymentDatas objectAtIndex:indexPath.section];
    [cell updateData:model];
    return cell;
}
@end
