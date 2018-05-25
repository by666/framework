//
//  CarHistoryView.m
//  framework
//
//  Created by 黄成实 on 2018/5/22.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "CarHistoryView.h"
#import "CarHistoryCell.h"
#import "CarHistoryModel.h"

@interface CarHistoryView()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)CarHistoryViewModel *mViewModel;
@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)UILabel *noHistoryLabel;

@end

@implementation CarHistoryView

-(instancetype)initWithViewModel:(CarHistoryViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    
    [_mViewModel getCarHistoryDatas];
    
    
    _noHistoryLabel = [[UILabel alloc]initWithFont:STFont(18) text:MSG_CARHISTORY_NODATA textAlignment:NSTextAlignmentCenter textColor:c12 backgroundColor:nil multiLine:NO];
    _noHistoryLabel.frame = CGRectMake(0, STHeight(125), ScreenWidth, STHeight(18));
    [self addSubview:_noHistoryLabel];

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ContentHeight)];
    _tableView.backgroundColor = c15;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.contentSize = CGSizeMake(ScreenWidth, STHeight(141)*[_mViewModel.datas count]);
    [self addSubview:_tableView];
    
    
    if(IS_NS_COLLECTION_EMPTY(_mViewModel.datas)){
        _noHistoryLabel.hidden = NO;
        _tableView.hidden = YES;
    }else{
        _noHistoryLabel.hidden = YES;
        _tableView.hidden = NO;
    }
    
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
    return STHeight(131);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_mViewModel.datas count];
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CarHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:[CarHistoryCell identify]];
    if(!cell){
        cell = [[CarHistoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[CarHistoryCell identify]];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    CarHistoryModel *model = [_mViewModel.datas objectAtIndex:indexPath.section];
    [cell updateData:model];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger position = indexPath.section;
    if(!IS_NS_COLLECTION_EMPTY(_mViewModel.datas)){
        CarHistoryModel *model = [_mViewModel.datas objectAtIndex:position];
        if(!model.hasPaid){
            [_mViewModel goOnePaymentPage:model];
        }
    }
    
}


@end
