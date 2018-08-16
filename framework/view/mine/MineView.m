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
#import "STNetUtil.h"

@interface MineView()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)MineViewModel *mViewModel;
@property(strong, nonatomic)UIView *topView;
@property(strong, nonatomic)STImageButton *avatarBtn;
@property(strong, nonatomic)UIButton *backBtn;
//@property(strong, nonatomic)UIButton *settingBtn;
@property(strong, nonatomic)UILabel *nameLabel;
@property(strong, nonatomic)UILabel *districtLabel;
@property(strong, nonatomic)UITableView *tableView;



@end

@implementation MineView{
    LiveModel *liveModel;
}

-(instancetype)initWithViewModel:(MineViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        liveModel = [[AccountManager sharedAccountManager]getLiveModel];
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
    _topView.frame = CGRectMake(0, 0, ScreenWidth, STHeight(220));
    [self addSubview:_topView];
    [STColorUtil setGradientColor:_topView startColor:c01 endColor:c02 director:Top];
    
    UILabel *mineTitleLabel = [[UILabel alloc]initWithFont:STFont(18) text:MSG_MINE_TITLE textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    if(IS_IPHONE_X){
        mineTitleLabel.frame = CGRectMake(0, StatuBarHeight, ScreenWidth, STHeight(22));
    }else{
        mineTitleLabel.frame = CGRectMake(0, STHeight(32), ScreenWidth, STHeight(22));
    }
    [self addSubview:mineTitleLabel];
    
    

    _avatarBtn = [[STImageButton alloc]init];
    _avatarBtn.backgroundColor = cwhite;
    _avatarBtn.frame = CGRectMake(STWidth(158), STHeight(74), STWidth(60), STWidth(60));
    _avatarBtn.layer.masksToBounds = YES;
    _avatarBtn.layer.cornerRadius = STWidth(30);
    _avatarBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_avatarBtn setImage:[UIImage imageNamed:@"ic_default"] forState:UIControlStateNormal];
    if(!IS_NS_STRING_EMPTY(userModel.headUrl)){
        NSURL *url = [[STUploadImageUtil sharedSTUploadImageUtil] getRealUrl:userModel.headUrl];
        [_avatarBtn sd_setImageWithURL:url forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"ic_default"]];
    }
    [_avatarBtn addTarget:self action:@selector(OnClickAvatarBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_avatarBtn];
    
    UIImageView *editImageView = [[UIImageView alloc]init];
    editImageView.frame = CGRectMake(STWidth(206), STHeight(81), STWidth(24), STWidth(24));
    editImageView.backgroundColor = c07;
    editImageView.layer.masksToBounds = YES;
    editImageView.layer.cornerRadius = STWidth(12);
    editImageView.image = [UIImage imageNamed:@"我_icon_编辑"];
    editImageView.contentMode = UIViewContentModeScaleAspectFit;
    editImageView.userInteractionEnabled = NO;
    [self addSubview:editImageView];
    
    
    _nameLabel = [[UILabel alloc]initWithFont:STFont(18) text:userModel.userName textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    _nameLabel.frame = CGRectMake(0, STHeight(154), ScreenWidth, STHeight(18));
    [self addSubview:_nameLabel];
    

    CGSize districtSize = [mainModel.districtName sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(14)]];
    CGFloat districtWidth  =   STWidth(20)+ districtSize.width;

    UIImageView *districtImageView = [[UIImageView alloc]init];
    districtImageView.image = [UIImage imageNamed:@"我_icon_小区"];
    districtImageView.contentMode = UIViewContentModeScaleAspectFill;
    districtImageView.frame = CGRectMake((ScreenWidth - districtWidth)/2, STHeight(180), STWidth(14), STHeight(14));
    [self addSubview:districtImageView];
    
    _districtLabel = [[UILabel alloc]initWithFont:STFont(14) text:mainModel.districtName textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    _districtLabel.frame = CGRectMake((ScreenWidth - districtWidth)/2 + STWidth(20), STHeight(180),districtSize.width, STHeight(14));
    [self addSubview:_districtLabel];
    
//    _settingBtn = [[UIButton alloc]init];
//    [_settingBtn setImage:[UIImage imageNamed:@"我_icon_设置"] forState:UIControlStateNormal];
//    if(IS_IPHONE_X){
//        _settingBtn.frame = CGRectMake(STWidth(342), StatuBarHeight , STWidth(20), STWidth(20));
//    }else{
//        _settingBtn.frame = CGRectMake(STWidth(342), STHeight(33) , STWidth(20), STWidth(20));
//    }
//    _settingBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    [_settingBtn addTarget:self action:@selector(onClickSettingBtn) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:_settingBtn];

    
    _backBtn = [[UIButton alloc]init];
    UIImage *image = [UIImage imageNamed:@"导航栏通用_icon_返回_白"];
    [_backBtn setImage:image forState:UIControlStateNormal];
    _backBtn.frame = CGRectMake(0, StatuBarHeight, STWidth(30) + image.size.width,NavigationBarHeight);
    [_backBtn addTarget:self action:@selector(onClickBackBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_backBtn];
}

-(void)initList{
    _tableView = [[UITableView alloc]init];
    _tableView.frame = CGRectMake(0, STHeight(220), ScreenWidth, ScreenHeight - STHeight(220));
    _tableView.backgroundColor = c15;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self addSubview:_tableView];
    
    [_tableView useDefaultProperty];
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
        case 3:
        case 4:
           rows = 1;
           break;
    }
    return rows;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return STHeight(56);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return STHeight(10);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(0, 0, ScreenWidth, STHeight(10));
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
    }else if(indexPath.section == 2){
        position = 5 + indexPath.row;
    }else if(indexPath.section == 3){
        position = 6 + indexPath.row;
    }else{
        position = 7 + indexPath.row;
    }
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    UIImage *image = [UIImage imageNamed:[_mViewModel.imageArray objectAtIndex:position]];

    if(position == 2 || position == 4 || position == 5 || position == 6 || position == 7){
        [cell updateData:[_mViewModel.titleArray objectAtIndex:position] image:image hidden:YES];
    }else{
        [cell updateData:[_mViewModel.titleArray objectAtIndex:position] image:image hidden:NO];
    }

    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger section = indexPath.section;
    if(section == 4){
        [_mViewModel doLogout];
        return;
    }

    ApplyModel *applyModel = [[AccountManager sharedAccountManager]getApplyModel];
//    if(![STNetUtil isNetAvailable]){
//        [STToastUtil showFailureAlertSheet:MSG_NET_ERROR];
//        return;
//    }
    if(applyModel.statu == APPLY_DEFAULT){
        [_mViewModel openCheckInfoAlert];
        return;
    }
    if(applyModel.statu == APPLYING){
        [_mViewModel goAuthStatuPage];
        return;
    }
    if(applyModel.statu == APPLY_REJECT){
        [_mViewModel showAuthFailDialog];
        return;
    }
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
                [_mViewModel goReportFixPage];
                break;
            case 1:
                [_mViewModel goDeviceSharePage];
                break;
        }
    }else if(section == 2){
        [_mViewModel goAccountManagePage];
    }else if(section == 3){
        [_mViewModel goAboutPage];
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
