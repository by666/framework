
//
//  DeviceShareHistoryView.m
//  framework
//
//  Created by 黄成实 on 2018/6/11.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "DeviceShareHistoryView.h"
#import "DeviceShareHistotyViewCell.h"
#import "BaseNoDataView.h"

@interface DeviceShareHistoryView()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)DeviceShareHistoryViewModel *mViewModel;
@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)BaseNoDataView *noDataView;


@end
@implementation DeviceShareHistoryView

-(instancetype)initWithViewModel:(DeviceShareHistoryViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ContentHeight)];
    _tableView.backgroundColor = c15;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestMore)];
    MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestNew)];
    header.lastUpdatedTimeLabel.hidden = YES;
    _tableView.mj_header = header;
    
    [_tableView useDefaultProperty];
    [self addSubview:_tableView];
    
    _noDataView = [[BaseNoDataView alloc]initWithImage:@"共享设备订单页_ic_无记录" title:MSG_NO_DEVICESHAREHISTORY buttonTitle:@"" onclick:nil];
    _noDataView.hidden = YES;
    [self addSubview:_noDataView];
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
    return STHeight(118);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_mViewModel.datas count];
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DeviceShareHistotyViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[DeviceShareHistotyViewCell identify]];
    if(!cell){
        cell = [[DeviceShareHistotyViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[DeviceShareHistotyViewCell identify]];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    DeviceShareHistoryModel *model = [_mViewModel.datas objectAtIndex:indexPath.section];
    [cell updateData:model];
    return cell;
}


-(void)requestMore{
    if(_mViewModel){
        [_mViewModel requestDatas];
    }
}


-(void)requestNew{
    if(_mViewModel){
        [_mViewModel requestDatas];
    }
}


-(void)updateView{
    if(IS_NS_COLLECTION_EMPTY(_mViewModel.datas)){
        _noDataView.hidden = NO;
        _tableView.hidden = YES;
    }else{
        _noDataView.hidden = YES;
        _tableView.hidden = NO;
    }
    [_tableView reloadData];
    [_tableView.mj_header endRefreshing];
    [_tableView.mj_footer endRefreshing];
    _tableView.contentSize = CGSizeMake(ScreenWidth, STHeight(128) * [_mViewModel.datas count]);
}


@end
