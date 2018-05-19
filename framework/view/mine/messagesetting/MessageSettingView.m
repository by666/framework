//
//  MessageSettingView.m
//  framework
//
//  Created by 黄成实 on 2018/5/18.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MessageSettingView.h"
#import "MessageSettingCell.h"
@interface MessageSettingView()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)MessageSettingViewModel *mViewModel;
@property(strong, nonatomic)UITableView *pushTableView;
@property(strong, nonatomic)UITableView *expreeTableView;

@end

@implementation MessageSettingView

-(instancetype)initWithViewModel:(MessageSettingViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    UILabel *pushTitleLabel = [[UILabel alloc]initWithFont:STFont(16) text:MSG_MESSAGESETTING_PUSH_TITLE textAlignment:NSTextAlignmentLeft textColor:c11 backgroundColor:nil multiLine:NO];
    pushTitleLabel.frame = CGRectMake(STWidth(15), STHeight(15), ScreenWidth - STWidth(30), STHeight(16));
    [self addSubview:pushTitleLabel];
    
    UILabel *pushTipsLabel = [[UILabel alloc]initWithFont:STFont(12) text:MSG_MESSAGESETTING_PUSH_TIPS textAlignment:NSTextAlignmentLeft textColor:c12 backgroundColor:nil multiLine:NO];
    pushTipsLabel.frame = CGRectMake(STWidth(15), STHeight(238), ScreenWidth - STWidth(30), STHeight(12));
    [self addSubview:pushTipsLabel];
    
    UILabel *expressTitleLabel = [[UILabel alloc]initWithFont:STFont(16) text:MSG_MESSAGESETTING_EXPRESS_TITLE textAlignment:NSTextAlignmentLeft textColor:c11 backgroundColor:nil multiLine:NO];
    expressTitleLabel.frame = CGRectMake(STWidth(15), STHeight(275), ScreenWidth - STWidth(30), STHeight(16));
    [self addSubview:expressTitleLabel];
    
    _pushTableView = [[UITableView alloc]init];
    _pushTableView.frame = CGRectMake(0, STHeight(52), ScreenWidth, STHeight(168));
    _pushTableView.backgroundColor = cwhite;
    _pushTableView.showsVerticalScrollIndicator = NO;
    _pushTableView.showsHorizontalScrollIndicator = NO;
    _pushTableView.delegate = self;
    _pushTableView.dataSource = self;
    _pushTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_pushTableView];
    
    _expreeTableView = [[UITableView alloc]init];
    _expreeTableView.frame = CGRectMake(0, STHeight(312), ScreenWidth, STHeight(114));
    _expreeTableView.backgroundColor = cwhite;
    _expreeTableView.showsVerticalScrollIndicator = NO;
    _expreeTableView.showsHorizontalScrollIndicator = NO;
    _expreeTableView.delegate = self;
    _expreeTableView.dataSource = self;
    _expreeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_expreeTableView];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == _pushTableView){
        return [_mViewModel.pushArray count];
    }
    else if(tableView == _expreeTableView){
        return [_mViewModel.expressArray count];
    }
    return 0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return STHeight(57);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:[MessageSettingCell identify]];
    if(!cell){
        cell = [[MessageSettingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MessageSettingCell identify]];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if(tableView == _pushTableView){
        [cell updateData:[_mViewModel.pushArray objectAtIndex:indexPath.row]];
    }else if(tableView == _expreeTableView){
        [cell updateData:[_mViewModel.expressArray objectAtIndex:indexPath.row]];
    }
    return cell;
}


@end
