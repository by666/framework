//
//  MineView.m
//  framework
//
//  Created by 黄成实 on 2018/5/15.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MineView.h"
#import "MineCell.h"

@interface MineView()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)MineViewModel *mViewModel;
@property(strong, nonatomic)UIView *topView;
@property(strong, nonatomic)UIButton *avatarBtn;
@property(strong, nonatomic)UIButton *settingBtn;
@property(strong, nonatomic)UILabel *nameLabel;
@property(strong, nonatomic)UILabel *districtLabel;
@property(strong, nonatomic)UITableView *tableView;


@end

@implementation MineView

-(instancetype)initWithViewModel:(MineViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    [self initTop];
    [self initList];
}

-(void)initTop{
    _topView = [[UIView alloc]init];
    _topView.frame = CGRectMake(0, 0, ScreenWidth, STHeight(219.1));
    [self addSubview:_topView];
    [STColorUtil setGradientColor:_topView startColor:c01 endColor:c02 director:Top];
    
    UILabel *mineTitleLabel = [[UILabel alloc]initWithFont:STFont(18) text:MSG_MINE_TITLE textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    mineTitleLabel.frame = CGRectMake(0, STHeight(32), ScreenWidth, STHeight(22));
    [self addSubview:mineTitleLabel];
    
    _avatarBtn = [[UIButton alloc]init];
    _avatarBtn.backgroundColor = cblack;
    _avatarBtn.frame = CGRectMake(STWidth(156), STHeight(78), STWidth(62), STWidth(62));
    _avatarBtn.layer.masksToBounds = YES;
    _avatarBtn.layer.cornerRadius = STWidth(31);
    [_avatarBtn addTarget:self action:@selector(OnClickAvatarBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_avatarBtn];
    
    UIImageView *editImageView = [[UIImageView alloc]init];
    editImageView.frame = CGRectMake(STWidth(206), STHeight(81), STWidth(23), STWidth(23));
    editImageView.backgroundColor = c01;
    editImageView.userInteractionEnabled = NO;
    [self addSubview:editImageView];
    
    _nameLabel = [[UILabel alloc]initWithFont:STFont(18) text:@"虚竹" textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    _nameLabel.frame = CGRectMake(0, STHeight(154), ScreenWidth, STHeight(18));
    [self addSubview:_nameLabel];
    
    UIImageView *districtImageView = [[UIImageView alloc]init];
    districtImageView.backgroundColor = c01;
    districtImageView.frame = CGRectMake(STWidth(150), STHeight(180), STHeight(14), STHeight(14));
    [self addSubview:districtImageView];
    
    _districtLabel = [[UILabel alloc]initWithFont:STFont(14) text:@"缥缈峰" textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    _districtLabel.frame = CGRectMake(STWidth(163), STHeight(180), STWidth(70), STHeight(14));
    [self addSubview:_districtLabel];
    
    _settingBtn = [[UIButton alloc]init];
    _settingBtn.backgroundColor = c01;
    _settingBtn.frame = CGRectMake(STWidth(342), STHeight(31.4), STWidth(20), STWidth(20));
    [_settingBtn addTarget:self action:@selector(onClickSettingBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_settingBtn];
}

-(void)initList{
    _tableView = [[UITableView alloc]init];
    _tableView.frame = CGRectMake(0, STHeight(219.1), ScreenWidth, ScreenHeight - STHeight(219.1));
    _tableView.backgroundColor = c15;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self addSubview:_tableView];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rows = 0;
    switch (section) {
        case 0:
            rows = 3;
            break;
        case 1:
            rows = 2;
            break;
        case 2:
            rows = 2;
            break;
    }
    return rows;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return STHeight(54);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return STHeight(9.9);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(0, 0, ScreenWidth, STHeight(9.9));
    return view;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineCell *cell = [tableView dequeueReusableCellWithIdentifier:[MineCell identify]];
    if(!cell){
        cell = [[MineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MineCell identify]];
    }
    NSInteger position = 0;
    if(indexPath.section == 0){
        position = indexPath.row;
    }else if(indexPath.section == 1){
        position = 3 + indexPath.row;
    }else{
        position = 5 + indexPath.row;
    }
    [cell updateData:[_mViewModel.titleArray objectAtIndex:position]];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger section = indexPath.section;
    if(section == 0){
        switch (indexPath.row) {
            case 0:
                [_mViewModel goMemberPage];
                break;
            case 1:
                [_mViewModel goVictorPage];
                break;
            case 2:
                [_mViewModel goVictorHistoryPage];
            break;
        }
    }else if(section == 1){
        switch (indexPath.row) {
            case 0:
                [_mViewModel goCarPage];
                break;
            case 1:
                [_mViewModel goCarHistoryPage];
                break;
        }
    }else{
        switch (indexPath.row) {
            case 0:
                [_mViewModel goMessageSettingPage];
                break;
            case 1:
                [_mViewModel goAccountManagePage];
                break;
        }
    }
}

#pragma mark 点击修改头像
-(void)OnClickAvatarBtn{
    if(_mViewModel){
        [_mViewModel goProfilePage];
    }
}

#pragma mark 点击设置
-(void)onClickSettingBtn{
    if(_mViewModel){
        [_mViewModel goSettingPage];
    }
}


@end
