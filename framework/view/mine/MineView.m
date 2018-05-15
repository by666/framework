//
//  MineView.m
//  framework
//
//  Created by 黄成实 on 2018/5/15.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MineView.h"

@interface MineView()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)MineViewModel *mViewModel;
@property(strong, nonatomic)UIView *topView;
@property(strong, nonatomic)UIButton *avatarBtn;
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
    _topView.frame = CGRectMake(0, 0, ScreenWidth, STHeight(260));
    _topView.backgroundColor = c01;
    [self addSubview:_topView];
    
    _avatarBtn = [[UIButton alloc]init];
    _avatarBtn.backgroundColor = cblack;
    _avatarBtn.frame = CGRectMake(STWidth(147.5), STHeight(70), STWidth(80), STWidth(80));
    _avatarBtn.layer.masksToBounds = YES;
    _avatarBtn.layer.cornerRadius = STWidth(40);
    [self addSubview:_avatarBtn];
    
    _nameLabel = [[UILabel alloc]initWithFont:STFont(18) text:@"黄成实" textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    _nameLabel.frame = CGRectMake(0, STHeight(170), ScreenWidth, STHeight(18));
    [self addSubview:_nameLabel];
    
    _districtLabel = [[UILabel alloc]initWithFont:STFont(14) text:@"上合花园" textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    _districtLabel.frame = CGRectMake(0, STHeight(200), ScreenWidth, STHeight(14));
    [self addSubview:_districtLabel];
}

-(void)initList{
    _tableView = [[UITableView alloc]init];
    _tableView.frame = CGRectMake(0, STHeight(260), ScreenWidth, ScreenHeight - STHeight(260));
    _tableView.backgroundColor = c09;
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
        case 3:
            rows = 1;
            break;
    }
    return rows;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return STHeight(20);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(0, 0, ScreenWidth, STHeight(20));
    return view;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mine"];
    NSInteger position = 0;
    if(indexPath.section == 0){
        position = indexPath.row;
    }else if(indexPath.section == 1){
        position = 3 + indexPath.row;
    }else if(indexPath.section == 2){
        position = 5 + indexPath.row;
    }else{
        position = 7 + indexPath.row;
    }
    cell.textLabel.text = [_mViewModel.titleArray objectAtIndex:position];
    cell.imageView.image = [UIImage imageNamed:@"ic_back"];
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
    }else if(section == 2){
        switch (indexPath.row) {
            case 0:
                [_mViewModel goMessageSettingPage];
                break;
            case 1:
                [_mViewModel goAccountManagePage];
                break;
        }
    }else{
        [_mViewModel goSettingPage];
    }
}


@end
