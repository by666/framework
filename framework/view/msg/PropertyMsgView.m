//
//  PropertyMsgView.m
//  framework
//
//  Created by 黄成实 on 2018/6/1.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "PropertyMsgView.h"
#import "PropertyMsgCell.h"
#import "BaseNoDataView.h"

@interface PropertyMsgView()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)PropertyMsgViewModel *mViewModel;
@property(strong,nonatomic)UITableView *tableView;
@property(strong,nonatomic)UIView *selectView;
@property(strong,nonatomic)BaseNoDataView *noDataView;


@end

@implementation PropertyMsgView

-(instancetype)initWithViewModel:(PropertyMsgViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ContentHeight)];
    _tableView.backgroundColor = c15;
    _tableView.showsVerticalScrollIndicator = YES;
    _tableView.showsHorizontalScrollIndicator = YES;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestMore)];
    
//    _tableView.contentSize = CGSizeMake(ScreenWidth,[_mViewModel countDynamicHeight]);
    MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestNew)];
    header.lastUpdatedTimeLabel.hidden = YES;
    _tableView.mj_header = header;
    
    if (@available(iOS 11.0, *)) {
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight=0;
        _tableView.contentInsetAdjustmentBehavior= UIScrollViewContentInsetAdjustmentNever;
    }
    [self addSubview:_tableView];
    
    WS(weakSelf)
    _noDataView = [[BaseNoDataView alloc]initWithImage:@"消息中心_ic_无消息" title:MSG_NO_MESSAGE buttonTitle:MSG_BACK_HOME onclick:^{
        [weakSelf.mViewModel backLastPage];
    }];
    _noDataView.hidden = YES;
    [self addSubview:_noDataView];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_mViewModel.datas count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return STHeight(263);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return STHeight(15);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [self selectView];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PropertyMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:[PropertyMsgCell identify]];
    if(!cell){
        cell = [[PropertyMsgCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[PropertyMsgCell identify]];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    PropertyMsgModel *model = [_mViewModel.datas objectAtIndex:indexPath.section];
    [cell updateData:model];
    return cell;
}


-(UIView *)selectView{
    if(_selectView == nil){
        _selectView = [[UIView alloc]init];
        _selectView.backgroundColor = c15;
    }
    return _selectView;
}

-(void)requestMore{
    if(_mViewModel){
        [_mViewModel requestMoreDatas];
    }
}


-(void)requestNew{
    if(_mViewModel){
        [_mViewModel requestNewDatas];
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
    [_tableView.mj_header endRefreshing];
    [_tableView.mj_footer endRefreshing];
    [_tableView reloadData];
}

@end
