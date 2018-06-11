//
//  FixHistoryView.m
//  framework
//
//  Created by 黄成实 on 2018/6/8.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "FixHistoryView.h"
#import "FixHistoryCell.h"

@interface FixHistoryView()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)FixHistoryViewModel *mViewModel;
@property(strong, nonatomic)UITableView *tableView;

@end

@implementation FixHistoryView

-(instancetype)initWithViewModel:(FixHistoryViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    
    [_mViewModel requestNew];

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ContentHeight)];
    _tableView.backgroundColor = c15;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.contentSize = CGSizeMake(ScreenWidth, STHeight(183)*[_mViewModel.datas count]);
    
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestMore)];
    _tableView.mj_footer.backgroundColor = cwhite;
    
    MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestNew)];
    header.lastUpdatedTimeLabel.hidden = YES;
    _tableView.mj_header = header;
    _tableView.mj_header.backgroundColor = cwhite;
    
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
    FixModel *data = [_mViewModel.datas objectAtIndex:indexPath.section];
    if(data.expand){
        CGSize detailSize = [data.detail sizeWithMaxWidth:(ScreenWidth - STWidth(30)) font:[UIFont systemFontOfSize:STFont(16)]];
        return detailSize.height + STHeight(147);
    }
    return STHeight(173);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_mViewModel.datas count];
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FixHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:[FixHistoryCell identify]];
    if(!cell){
        cell = [[FixHistoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[FixHistoryCell identify]];
    }
    [cell setBackgroundColor:cwhite];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.expandBtn.tag = indexPath.section;
    [cell.expandBtn addTarget:self action:@selector(onClickExpandBtn:) forControlEvents:UIControlEventTouchUpInside];
    FixModel *model = [_mViewModel.datas objectAtIndex:indexPath.section];
    [cell updateData:model];
    return cell;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger position = indexPath.section;
  
}

-(void)onClickExpandBtn:(id)sender{
    UIButton *button = sender;
    NSInteger tag = button.tag;
    FixModel *data = [_mViewModel.datas objectAtIndex:tag];
    data.expand = !data.expand;
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:tag] withRowAnimation:UITableViewRowAnimationAutomatic];
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
