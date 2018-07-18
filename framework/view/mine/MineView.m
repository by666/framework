//
//  MineView.m
//  framework
//
//  Created by 黄成实 on 2018/5/15.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MineView.h"
#import "MineCell.h"
#import "AccountManager.h"
#import "STImageButton.h"

@interface MineView()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)MineViewModel *mViewModel;
@property(strong, nonatomic)UIView *topView;
@property(strong, nonatomic)STImageButton *avatarBtn;
@property(strong, nonatomic)UIButton *backBtn;
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
    
    UserModel *userModel = [[AccountManager sharedAccountManager]getUserModel];
    MainModel *mainModel = [[AccountManager sharedAccountManager]getMainModel];

    _topView = [[UIView alloc]init];
    _topView.frame = CGRectMake(0, 0, ScreenWidth, STHeight(219.1));
    [self addSubview:_topView];
    [STColorUtil setGradientColor:_topView startColor:c01 endColor:c02 director:Top];
    
    UILabel *mineTitleLabel = [[UILabel alloc]initWithFont:STFont(18) text:MSG_MINE_TITLE textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    mineTitleLabel.frame = CGRectMake(0, STHeight(32), ScreenWidth, STHeight(22));
    [self addSubview:mineTitleLabel];
    
    

    _avatarBtn = [[STImageButton alloc]init];
    _avatarBtn.backgroundColor = cwhite;
    _avatarBtn.frame = CGRectMake(STWidth(156), STHeight(78), STWidth(62), STWidth(62));
    _avatarBtn.layer.masksToBounds = YES;
    _avatarBtn.layer.cornerRadius = STWidth(31);
    _avatarBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_avatarBtn setImage:[UIImage imageNamed:@"ic_default"] forState:UIControlStateNormal];
    if(!IS_NS_STRING_EMPTY(userModel.headUrl)){
        NSURL *url = [[STUploadImageUtil sharedSTUploadImageUtil] getRealUrl:userModel.headUrl];
        [_avatarBtn sd_setImageWithURL:url forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"ic_default"]];
    }
    [_avatarBtn addTarget:self action:@selector(OnClickAvatarBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_avatarBtn];
    
    UIImageView *editImageView = [[UIImageView alloc]init];
    editImageView.frame = CGRectMake(STWidth(206), STHeight(81), STWidth(23), STWidth(23));
    editImageView.backgroundColor = c07;
    editImageView.layer.masksToBounds = YES;
    editImageView.layer.cornerRadius = STWidth(11.5);
    editImageView.image = [UIImage imageNamed:@"ic_edit_head"];
    editImageView.contentMode = UIViewContentModeScaleAspectFit;
    editImageView.userInteractionEnabled = NO;
    [self addSubview:editImageView];
    
    
    _nameLabel = [[UILabel alloc]initWithFont:STFont(18) text:userModel.userName textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    _nameLabel.frame = CGRectMake(0, STHeight(154), ScreenWidth, STHeight(18));
    [self addSubview:_nameLabel];
    

    CGSize districtSize = [mainModel.detailAddr sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(14)]];
    CGFloat districtWidth  =   STWidth(20)+ districtSize.width;

    UIImageView *districtImageView = [[UIImageView alloc]init];
    districtImageView.image = [UIImage imageNamed:@"ic_building_white"];
    districtImageView.contentMode = UIViewContentModeScaleAspectFill;
    districtImageView.frame = CGRectMake((ScreenWidth - districtWidth)/2, STHeight(180), STWidth(14), STHeight(14));
    [self addSubview:districtImageView];
    
    _districtLabel = [[UILabel alloc]initWithFont:STFont(14) text:mainModel.detailAddr textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    _districtLabel.frame = CGRectMake((ScreenWidth - districtWidth)/2 + STWidth(20), STHeight(180),districtSize.width, STHeight(14));
    [self addSubview:_districtLabel];
    
    _settingBtn = [[UIButton alloc]init];
    [_settingBtn setImage:[UIImage imageNamed:@"ic_setting"] forState:UIControlStateNormal];
    _settingBtn.frame = CGRectMake(STWidth(342), STHeight(31.4), STWidth(20), STWidth(20));
    _settingBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_settingBtn addTarget:self action:@selector(onClickSettingBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_settingBtn];
    
    _backBtn = [[UIButton alloc]init];
    [_backBtn setImage:[UIImage imageNamed:@"ic_arrow_back_white"] forState:UIControlStateNormal];
    _backBtn.frame = CGRectMake(STWidth(15), STHeight(31.4), STWidth(20), STWidth(20));
    _backBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_backBtn addTarget:self action:@selector(onClickBackBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_backBtn];
}

-(void)initList{
    _tableView = [[UITableView alloc]init];
    _tableView.frame = CGRectMake(0, STHeight(219.1), ScreenWidth, ScreenHeight - STHeight(219.1));
    _tableView.backgroundColor = c15;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    UIImage *image = [UIImage imageNamed:[_mViewModel.imageArray objectAtIndex:position]];
    if(position == 2 || position == 4 || position == 6){
        [cell updateData:[_mViewModel.titleArray objectAtIndex:position] image:image hidden:YES];
    }else{
        [cell updateData:[_mViewModel.titleArray objectAtIndex:position] image:image hidden:NO];
    }
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


#pragma mark 点击返回
-(void)onClickBackBtn{
    if(_mViewModel){
        [_mViewModel goBack];
    }
}


//更新头像
-(void)updateFace{
    UserModel *userModel = [[AccountManager sharedAccountManager]getUserModel];
    if(!IS_NS_STRING_EMPTY(userModel.headUrl)){
        NSURL *url = [[STUploadImageUtil sharedSTUploadImageUtil] getRealUrl:userModel.headUrl];
        [_avatarBtn sd_setImageWithURL:url forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"ic_default"]];
    }
}
@end
