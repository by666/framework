//
//  VisitorHistoryView.m
//  framework
//
//  Created by by.huang on 2018/5/23.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "VisitorHistoryView.h"
#import "VisitorHistoryCell.h"
#import "BaseNoDataView.h"

@interface  VisitorHistoryView()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)VisitorHistoryViewModel *mViewModel;
@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)BaseNoDataView *noDataView;

@end


@implementation VisitorHistoryView

-(instancetype)initWithViewModel:(VisitorHistoryViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ContentHeight)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.contentSize = CGSizeMake(ScreenWidth, STHeight(110)*[_mViewModel.datas count]);
    [_tableView useDefaultProperty];
    [self addSubview:_tableView];
    
    WS(weakSelf)
    _noDataView = [[BaseNoDataView alloc]initWithImage:@"共享设备订单页_ic_无记录" title:MSG_NO_VISITOR buttonTitle:MSG_BACK_HOME onclick:^{
        if(weakSelf.mViewModel){
            [weakSelf.mViewModel backLastPage];
        }
    }];
    _noDataView.hidden = YES;
    [self addSubview:_noDataView];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_mViewModel.datas count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return STHeight(108);
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VisitorHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:[VisitorHistoryCell identify]];
    if(!cell){
        cell = [[VisitorHistoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[VisitorHistoryCell identify]];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    VisitorHistoryModel *model = [_mViewModel.datas objectAtIndex:indexPath.section];
    [cell updateData:model];
    return cell;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger position = indexPath.section;
    if(!IS_NS_COLLECTION_EMPTY(_mViewModel.datas)){
        VisitorHistoryModel *model = [_mViewModel.datas objectAtIndex:position];
        if(_mViewModel){
            VisitorModel *tempModel = [[VisitorModel alloc]init];
            tempModel.name = model.userName;
            tempModel.faceUrl = model.faceUrl;
            tempModel.carNum = model.licenseNum;
            [_mViewModel goVisitorPage:tempModel];
        }
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
}
@end
