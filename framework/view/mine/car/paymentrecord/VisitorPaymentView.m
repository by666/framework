//
//  VisitorPaymentView.m
//  framework
//
//  Created by 黄成实 on 2018/5/22.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "VisitorPaymentView.h"
#import "VisitorPaymentCell.h"

@interface VisitorPaymentView()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)PaymentRecordViewModel *mViewModel;
@property(strong, nonatomic)UITableView *tableView;

@end

@implementation VisitorPaymentView

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
    _tableView.contentSize = CGSizeMake(ScreenWidth, STHeight(190)*[_mViewModel.visitorPaymentDatas count]);
    [self addSubview:_tableView];
    
    [_mViewModel getVisitorPaymentDatas];
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
    return STHeight(180);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_mViewModel.visitorPaymentDatas count];
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VisitorPaymentCell *cell = [tableView dequeueReusableCellWithIdentifier:[VisitorPaymentCell identify]];
    if(!cell){
        cell = [[VisitorPaymentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[VisitorPaymentCell identify]];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    VisitorPaymentModel *model = [_mViewModel.visitorPaymentDatas objectAtIndex:indexPath.section];
    [cell updateData:model];
    return cell;
}

@end
