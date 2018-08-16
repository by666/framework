//
//  HabitantView.m
//  framework
//
//  Created by 黄成实 on 2018/5/15.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "HabitantView.h"
#import "HabitantCell.h"
#import "STTimeUtil.h"
#import "BaseNoDataView.h"

@interface HabitantView()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)HabitantViewModel *mViewModel;
@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)BaseNoDataView *noDataView;

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
    _tableView.frame = CGRectMake(0, STHeight(10), ScreenWidth, ContentHeight - STHeight(10));
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self addSubview:_tableView];
    
    [_tableView useDefaultProperty];
    
    _noDataView = [[BaseNoDataView alloc]initWithImage:@"住户管理_ic_无记录" title:MSG_NO_HABITANT buttonTitle:@"" onclick:nil];
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
    return STHeight(84.5);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HabitantCell *cell = [tableView dequeueReusableCellWithIdentifier:[HabitantCell identify]];
    if(!cell){
        cell = [[HabitantCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[HabitantCell identify]];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if(_mViewModel && !IS_NS_COLLECTION_EMPTY(_mViewModel.datas)){
        [cell updateData:[_mViewModel.datas objectAtIndex:indexPath.row]];
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_mViewModel){
        
        HabitantModel *currentModel = [_mViewModel.datas objectAtIndex:indexPath.row];
        //业主不可点击
        if(currentModel.liveAttr == Live_Owner){
            return;
        }
        [_mViewModel goUserInfoPage:currentModel];
    }
}


-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    HabitantModel *model = [_mViewModel.datas objectAtIndex:indexPath.row];
    //业主不可点击
    if(model.liveAttr == Live_Owner){
        return NO;
    }
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}


-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return MSG_DELETE;
}

- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    HabitantModel *model = [_mViewModel.datas objectAtIndex:indexPath.row];
    WS(weakSelf)
    [STAlertUtil showAlertController:MSG_WARN content:[NSString stringWithFormat:@"删除\"%@\"后,将会删除其账号全部信息，请慎重",model.userName] controller:weakSelf.mViewModel.controller confirm:^{
        
        if(weakSelf.mViewModel){
            [weakSelf.mViewModel deleteHabitant:model];
        }
//        [weakSelf.mViewModel.datas removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPath.row inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
    }];
 
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
