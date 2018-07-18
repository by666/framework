//
//  DeviceShareView.m
//  framework
//
//  Created by 黄成实 on 2018/6/8.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "DeviceShareView.h"
#import "DeviceShareCell.h"
#import "STDetailView.h"
@interface DeviceShareView()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)DeviceShareViewModel *mViewModel;
@property(strong, nonatomic)STDetailView *detailView;

@end

@implementation DeviceShareView

-(instancetype)initWithViewModel:(DeviceShareViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    [_mViewModel requestDatas];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ContentHeight)];
    _tableView.backgroundColor = c15;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.contentSize = CGSizeMake(ScreenWidth, STHeight(183)*[_mViewModel.datas count]);
    
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestMore)];
    _tableView.mj_footer.backgroundColor = cwhite;
    
    MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestNew)];
    header.lastUpdatedTimeLabel.hidden = YES;
    _tableView.mj_header = header;
    _tableView.mj_header.backgroundColor = cwhite;
    
    [_tableView useDefaultProperty];
    
    [self addSubview:_tableView];
    
    [self addSubview:[self detailView]];
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
    return STHeight(100);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_mViewModel.datas count];
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DeviceShareCell *cell = [tableView dequeueReusableCellWithIdentifier:[DeviceShareCell identify]];
    if(!cell){
        cell = [[DeviceShareCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[DeviceShareCell identify]];
    }
    [cell setBackgroundColor:cwhite];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.rentBtn.tag = indexPath.section;
    [cell.rentBtn addTarget:self action:@selector(onClickRentBtn:) forControlEvents:UIControlEventTouchUpInside];
    DeviceShareModel *model = [_mViewModel.datas objectAtIndex:indexPath.section];
    [cell updateData:model];
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DeviceShareModel *data = [_mViewModel.datas objectAtIndex:indexPath.section];
    _detailView.hidden = NO;
    [_detailView setTitle:data.name content:data.detail];
}

-(STDetailView *)detailView{
    if(_detailView == nil){
        _detailView = [[STDetailView alloc]init];
        _detailView.hidden = YES;
    }
    return _detailView;
}

-(void)onClickRentBtn:(id)sender{
    NSInteger tag = ((UIButton *)sender).tag;
    if(_mViewModel){
        DeviceShareModel *model = [_mViewModel.datas objectAtIndex:tag];
        [_mViewModel goDeviceShareOrderPage:model];
    }
}

-(void)requestMore{
    [_tableView.mj_header endRefreshing];
    [_tableView.mj_footer endRefreshing];
}

-(void)requestNew{
    [_tableView.mj_header endRefreshing];
    [_tableView.mj_footer endRefreshing];
}


@end
