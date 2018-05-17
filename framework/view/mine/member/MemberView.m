//
//  MemberView.m
//  framework
//
//  Created by 黄成实 on 2018/5/17.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MemberView.h"
#import "MemberCell.h"

@interface MemberView()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)MemberViewModel *mViewModel;
@property(strong, nonatomic)UIButton *addMemberBtn;
@property(strong, nonatomic)UITableView *tableView;

@end

@implementation MemberView

-(instancetype)initWithViewModel:(MemberViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    
    UILabel *titleLabel = [[UILabel alloc]initWithFont:STFont(16) text:MSG_MEMBER_TIPS textAlignment:NSTextAlignmentCenter textColor:c16 backgroundColor:nil multiLine:NO];
    titleLabel.frame = CGRectMake(STWidth(15), STHeight(16), ScreenWidth - STWidth(30), STHeight(16));
    [self addSubview:titleLabel];
    
    _addMemberBtn = [[UIButton alloc]initWithFont:STFont(18) text:MSG_MEMBER_ADDBTN textColor:cwhite backgroundColor:c08 corner:STHeight(25) borderWidth:0 borderColor:nil];
    _addMemberBtn.frame = CGRectMake(STWidth(49), STHeight(503), STWidth(276), STHeight(50));
    [_addMemberBtn addTarget:self action:@selector(onClickAddMemberBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_addMemberBtn];
    
    _tableView = [[UITableView alloc]init];
    _tableView.frame = CGRectMake(0, STHeight(48), ScreenWidth, ContentHeight - STHeight(200));
    _tableView.backgroundColor = cwhite;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;    
    [self addSubview:_tableView];
    
    [_mViewModel getMemberModels];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_mViewModel.datas count];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return STHeight(59.5);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MemberCell *cell = [tableView dequeueReusableCellWithIdentifier:[MemberCell identify]];
    if(!cell){
        cell = [[MemberCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MemberCell identify]];
    }
 
    if(_mViewModel && !IS_NS_COLLECTION_EMPTY(_mViewModel.datas)){
        [cell updateData:[_mViewModel.datas objectAtIndex:indexPath.row]];
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
}



-(void)updateView{
    [_tableView reloadData];
}


-(void)onClickAddMemberBtn{
    if(_mViewModel){
        [_mViewModel goEditMemberView];
    }
}

@end


