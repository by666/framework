//
//  SettingView.m
//  framework
//
//  Created by 黄成实 on 2018/5/16.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "SettingView.h"
#import "SettingCell.h"

@interface SettingView()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)SettingViewModel *mViewModel;
@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)UIButton *logoutBtn;

@end


@implementation SettingView

-(instancetype)initWithViewModel:(SettingViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    _tableView = [[UITableView alloc]init];
    _tableView.frame = CGRectMake(0, STHeight(10), ScreenWidth, ContentHeight - STHeight(10));
    _tableView.backgroundColor = c15;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_tableView];
    
    _logoutBtn = [[UIButton alloc]initWithFont:STFont(18) text:MSG_SETTING_LOGOUT textColor:cwhite backgroundColor:c08 corner:STHeight(25) borderWidth:0 borderColor:nil];
    [_logoutBtn addTarget:self action:@selector(onClickLogoutBtn) forControlEvents:UIControlEventTouchUpInside];
    _logoutBtn.frame = CGRectMake(STWidth(50), STHeight(513), STHeight(276), STHeight(50));
    [_logoutBtn setBackgroundColor:c08a forState:UIControlStateHighlighted];
    [self addSubview:_logoutBtn];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_mViewModel.datas count];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return STHeight(54);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:[SettingCell identify]];
    if(!cell){
        cell = [[SettingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[SettingCell identify]];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if(!IS_NS_COLLECTION_EMPTY(_mViewModel.datas)){
        TitleContentModel *model = [_mViewModel.datas objectAtIndex:indexPath.row];
        [cell updateData:model position:indexPath.row];
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(_mViewModel){
        NSInteger position = indexPath.row;
        switch (position) {
            case 2:
                [_mViewModel goUpdatePhoneNumPage];
                break;
            case 3:
                [_mViewModel goAboutPage];
                break;
            default:
                break;
        }
    }
}

-(void)onClickLogoutBtn{
    if(_mViewModel){
        [_mViewModel logout];
    }
}

@end
