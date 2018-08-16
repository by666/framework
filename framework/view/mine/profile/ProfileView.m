//
//  ProfileView.m
//  framework
//
//  Created by 黄成实 on 2018/5/16.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "ProfileView.h"
#import "ProfileCell.h"
#import "AccountManager.h"

@interface ProfileView()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)UIScrollView *scrollView;
@property(strong, nonatomic)ProfileViewModel *mViewModel;
@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)UIButton *tipsBtn;
@property(strong, nonatomic)UIButton *headImageView;

@end

@implementation ProfileView

-(instancetype)initWithViewModel:(ProfileViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ContentHeight)];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight);
    [self addSubview:_scrollView];
    
    UIView *faceView = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(10), ScreenWidth, STHeight(100))];
    faceView.backgroundColor = cwhite;
    [_scrollView addSubview:faceView];
    
    UILabel *faceTitle = [[UILabel alloc]initWithFont:STFont(16) text:MSG_PROFILE_AVATAR textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    CGSize faceSize = [MSG_PROFILE_AVATAR sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    faceTitle.frame = CGRectMake(STWidth(15), 0, faceSize.width, STHeight(100));
    [faceView addSubview:faceTitle];
    
    _headImageView = [[UIButton alloc]init];
    _headImageView.frame = CGRectMake(STWidth(273), STHeight(20), STHeight(60), STHeight(60));
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = STHeight(30);
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_headImageView setImage:[UIImage imageNamed:@"ic_default"] forState:UIControlStateNormal]; ;
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [faceView addSubview:_headImageView];
    
    UITapGestureRecognizer *recongnizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onSelectPhoto)];
    [_headImageView addGestureRecognizer:recongnizer];
    
    UserModel *userModel = [[AccountManager sharedAccountManager]getUserModel];
    NSURL *url = [[STUploadImageUtil sharedSTUploadImageUtil] getRealUrl:userModel.headUrl];
    [_headImageView sd_setImageWithURL:url forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"ic_default"]];
    UIImageView *arrowImageView = [[UIImageView alloc]init];
    arrowImageView.frame = CGRectMake(ScreenWidth - STWidth(33), (STHeight(100) - STWidth(13))/2, STWidth(13), STWidth(13));
    arrowImageView.image = [UIImage imageNamed:@"ic_arrow_right"];
    [faceView addSubview:arrowImageView];
    
    
    UILabel *faceTipsTitle = [[UILabel alloc]initWithFont:STFont(12) text:MSG_PROFILE_TIPS_TITLE textAlignment:NSTextAlignmentCenter textColor:c12 backgroundColor:nil multiLine:NO];
    CGSize faceTipsSize = [MSG_PROFILE_TIPS_TITLE sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(12)]];
    faceTipsTitle.frame = CGRectMake(STWidth(15), STHeight(110), faceTipsSize.width, STHeight(42));
    [_scrollView addSubview:faceTipsTitle];
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, STHeight(142), ScreenWidth, ContentHeight - STHeight(142))];
    _tableView.backgroundColor = c15;
    _tableView.scrollEnabled = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_scrollView addSubview:_tableView];

    [_tableView useDefaultProperty];


    _tipsBtn = [[UIButton alloc]initWithFont:STFont(14) text:MSG_PROFILE_VERIFY textColor:cwhite backgroundColor:c24 corner:0 borderWidth:0 borderColor:nil];
    _tipsBtn.frame = CGRectMake(0, 0, ScreenWidth, STHeight(26));
    _tipsBtn.hidden = YES;
    [_tipsBtn addTarget:self action:@selector(OnClickTipsBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_tipsBtn];
    
    [self fillInData];
}

-(void)fillInData{
    
    UserModel *userModel = [[AccountManager sharedAccountManager]getUserModel];
    LiveModel *liveModel = [[AccountManager sharedAccountManager] getLiveModel];
    ApplyModel *applyModel = [[AccountManager sharedAccountManager]getApplyModel];
    ProfileModel *model = [[ProfileModel alloc]init];
    model.name = userModel.userName;
    model.gender = [STPUtil getGenderfromIdNum:userModel.creid];
    model.birthday = [STPUtil getBirthdayFromIdNum:userModel.creid];
    model.idNum = userModel.creid;
    if(applyModel.statu == APPLY_PASS){
        model.identify = [STPUtil getLiveAttr:liveModel.liveAttr];
    }else{
        model.identify = @"";
    }
    model.phoneNum = userModel.phoneNum;
    model.headUrl = userModel.headUrl;
    
    _mViewModel.model = model;
    [_mViewModel updateProfile];
    
    
    if(applyModel.statu == APPLYING){
        _tipsBtn.hidden = NO;
    }

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rows = 0;
    switch (section) {
        case 0:
            rows = 4;
            break;
        case 1:
            rows = 3;
            break;
    }
    return rows;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1 && indexPath.row == 2){
        TitleContentModel *model = [_mViewModel.datas objectAtIndex:6];
        CGSize addressSize = [model.content sizeWithMaxWidth:ScreenWidth -  STWidth(150) font:[UIFont systemFontOfSize:STFont(16)]];
        //有住址的高度
        if(addressSize.height != 0){
            return addressSize.height + STHeight(38);
        }
    }
    return STHeight(54);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
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
    ProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:[ProfileCell identify]];
    if(!cell){
        cell = [[ProfileCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[ProfileCell identify]];
    }
    NSInteger position = 0;
    if(indexPath.section == 0){
        position = indexPath.row;
    }else{
        position = 4 + indexPath.row;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSMutableArray *datas = _mViewModel.datas;
    if(!IS_NS_COLLECTION_EMPTY(datas)){
        TitleContentModel *model = [datas objectAtIndex:position];
        [cell updateData:model position:position];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}


-(void)onSelectPhoto{
    if(_mViewModel){
        ApplyModel *model = [[AccountManager sharedAccountManager]getApplyModel];
        if(model.statu == APPLY_PASS){
            [_mViewModel goFaceEnterPage];
        }else{
            [STToastUtil showWarnTips:MSG_MINE_AUTH_TIPS];
        }
    }
}


-(void)OnClickTipsBtn{
    if(_mViewModel){
        [_mViewModel goAuthStatuPage];
    }
}


-(void)updateTableView{
    [_tableView reloadData];
    UserModel *userModel = [[AccountManager sharedAccountManager]getUserModel];
    NSURL *url = [[STUploadImageUtil sharedSTUploadImageUtil] getRealUrl:userModel.headUrl];
    [_headImageView sd_setImageWithURL:url forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"ic_default"]];
}



@end
