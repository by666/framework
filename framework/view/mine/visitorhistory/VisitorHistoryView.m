//
//  VisitorHistoryView.m
//  framework
//
//  Created by by.huang on 2018/5/23.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "VisitorHistoryView.h"
#import "VisitorHistoryCell.h"

@interface  VisitorHistoryView()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)VisitorHistoryViewModel *mViewModel;
@property(strong, nonatomic)UITableView *tableView;

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
    _tableView.backgroundColor = c15;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.contentSize = CGSizeMake(ScreenWidth, STHeight(110)*[_mViewModel.datas count]);
    [self addSubview:_tableView];
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
    VisitorHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:[VisitorHistoryCell identify]];
    if(!cell){
        cell = [[VisitorHistoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[VisitorHistoryCell identify]];
    }
    [cell setBackgroundColor:c15];
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
    [_tableView reloadData];
}
@end
