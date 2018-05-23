//
//  ProfileView.m
//  framework
//
//  Created by 黄成实 on 2018/5/16.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "ProfileView.h"
#import "ProfileCell.h"

@interface ProfileView()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)ProfileViewModel *mViewModel;
@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)UILabel *tipsLabel;

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
    

    _tipsLabel = [[UILabel alloc]initWithFont:STFont(14) text:MSG_PROFILE_VERIFY textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:c24 multiLine:NO];
    _tipsLabel.frame = CGRectMake(0, 0, ScreenWidth, STHeight(26));
    [self addSubview:_tipsLabel];
    
    [self fillInData];
}

-(void)fillInData{
    ProfileModel *model = [[ProfileModel alloc]init];
    model.name = @"虚竹";
    model.gender = @"男";
    model.birthday = @"11.11";
    model.idNum = @"36240219911110412";
    model.identify = @"业主";
    model.phoneNum = @"186****6420";
    
    _mViewModel.model = model;
    [_mViewModel updateProfile];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rows = 0;
    switch (section) {
        case 0:
            rows = 5;
            break;
        case 1:
            rows = 2;
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
            [_mViewModel goFaceEnterPage];
        }
    }
}

-(void)updateTableView{
    [_tableView reloadData];
}



@end
