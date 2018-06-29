//
//  PassHistoryView.m
//  framework
//
//  Created by 黄成实 on 2018/6/27.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "PassHistoryView.h"
#import "PassHistoryCell.h"

@interface PassHistoryView()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)PassHistoryViewModel *mViewModel;
@property(strong,nonatomic)UITableView *tableView;

@end

@implementation PassHistoryView

-(instancetype)initWithViewModel:(PassHistoryViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, STHeight(10), ScreenWidth, ContentHeight -STHeight(10))];
    _tableView.backgroundColor = c15;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_tableView];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_mViewModel.datas count];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(!IS_NS_COLLECTION_EMPTY(_mViewModel.datas)){
        PassHistoryModel *model = [_mViewModel.datas objectAtIndex:indexPath.row];
        if(IS_NS_STRING_EMPTY(model.licenseNum)){
            return STHeight(105);
        }
        return STHeight(126);
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PassHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:[PassHistoryCell identify]];
    if(!cell){
        cell = [[PassHistoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[PassHistoryCell identify]];
    }
    [cell setBackgroundColor:cwhite];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    PassHistoryModel *model = [_mViewModel.datas objectAtIndex:indexPath.row];
    [cell updateData:model];
    return cell;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(!IS_NS_COLLECTION_EMPTY(_mViewModel.datas)){
        PassHistoryModel *model = [_mViewModel.datas objectAtIndex:indexPath.row];
        if(_mViewModel){
            [_mViewModel goPassPage:model];
        }
    }
    
}

-(void)updateView{
    CGFloat countHeight = 0;
    if(!IS_NS_COLLECTION_EMPTY(_mViewModel.datas)){
        for(PassHistoryModel *model in _mViewModel.datas){
            if(IS_NS_STRING_EMPTY(model.licenseNum)){
                countHeight +=STHeight(105);
            }else{
                countHeight +=STHeight(126);
            }
        }
    }
    _tableView.contentSize = CGSizeMake(ScreenWidth, countHeight);
    [_tableView reloadData];
}


@end
