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

@property(strong, nonatomic)ProfileViewModel *mViewModel;
@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)UIButton *tipsBtn;

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
    _tableView = [[UITableView alloc]init];
    _tableView.frame = CGRectMake(0, 0, ScreenWidth, ContentHeight);
    _tableView.backgroundColor = c15;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_tableView];


    _tipsBtn = [[UIButton alloc]initWithFont:STFont(14) text:MSG_PROFILE_VERIFY textColor:cwhite backgroundColor:c24 corner:0 borderWidth:0 borderColor:nil];
    _tipsBtn.frame = CGRectMake(0, 0, ScreenWidth, STHeight(26));
    [_tipsBtn addTarget:self action:@selector(OnClickTipsBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_tipsBtn];
    
    [self fillInData];
}

-(void)fillInData{
    
    UserModel *userModel = [[AccountManager sharedAccountManager]getUserModel];
    LiveModel *liveModel = [[AccountManager sharedAccountManager] getLiveModel];
    ProfileModel *model = [[ProfileModel alloc]init];
    model.name = userModel.userName;
    model.gender = [STPUtil getGenderfromIdNum:userModel.creid];
    model.birthday = [STPUtil getBirthdayFromIdNum:userModel.creid];
    model.idNum = userModel.creid;
    model.identify = [STPUtil getLiveAttr:liveModel.liveAttr];
    model.phoneNum = userModel.phoneNum;
    model.headUrl = userModel.headUrl;
    
    _mViewModel.model = model;
    [_mViewModel updateProfile];
    
    if(liveModel.statu == STATU_YES){
        _tipsBtn.hidden = YES;
    }

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rows = 0;
    switch (section) {
        case 0:
            rows = 5;
            break;
        case 1:
            rows = 3;
            break;
    }
    return rows;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0 && indexPath.row == 0){
        return STHeight(90);
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
        position = 5 + indexPath.row;
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
    if(indexPath.section == 0 && indexPath.row == 0){
        if(_mViewModel){
            LiveModel *model = [[AccountManager sharedAccountManager]getLiveModel];
            if(model.statu == STATU_YES){
                [_mViewModel goFaceEnterPage];
            }else{
                [STToastUtil showWarnTips:MSG_MINE_AUTH_TIPS];
            }
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
}



@end
