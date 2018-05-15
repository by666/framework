//
//  HabitantView.m
//  framework
//
//  Created by 黄成实 on 2018/5/15.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "HabitantView.h"

@interface HabitantView()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)HabitantViewModel *mViewModel;
@property(strong, nonatomic)UITableView *tableView;

@end

@implementation HabitantView

-(instancetype)initWithViewModel:(HabitantViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    _tableView = [[UITableView alloc]init];
    _tableView.frame = CGRectMake(0, 0, ScreenWidth, ContentHeight);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_tableView];
    
    [_mViewModel requestDatas];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_mViewModel.models count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return STHeight(60);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HabitantView"];
    NSMutableArray *datas = _mViewModel.models;
    if(!IS_NS_COLLECTION_EMPTY(datas)){
        HabitantModel *model = [datas objectAtIndex:indexPath.row];
        NSString *content=  [NSString stringWithFormat:@"%@，%@，有效期：%@",model.name,model.identity,model.validDate];
        cell.textLabel.text = content;
    }
    return cell;
}


-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}


-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    HabitantModel *model = [_mViewModel.models objectAtIndex:indexPath.row];
    __weak HabitantView *weakSelf = self;
    [STAlertUtil showAlertController:@"警告" content:[NSString stringWithFormat:@"删除\"%@\"后,将会删除其账号全部信息，请慎重",model.name] controller:weakSelf.mViewModel.controller confirm:^{
        [weakSelf.mViewModel.models removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPath.row inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
    }];
 
}




-(void)updateView{
    [_tableView reloadData];
}

@end
