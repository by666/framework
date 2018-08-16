//
//  MessageView.m
//  framework
//
//  Created by 黄成实 on 2018/5/29.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MessageView.h"
#import "MessageCell.h"
#import "AccountManager.h"

@interface MessageView()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)MessageViewModel *mViewModel;

@property(strong, nonatomic)UIButton *propertyBtn;
@property(strong, nonatomic)UIButton *systemBtn;
@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)UIView *selectView;

@property(strong, nonatomic)UIView *noDataView;

@end

@implementation MessageView{
    NSMutableArray *superScriptLabels;
}

-(instancetype)initWithViewModel:(MessageViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        superScriptLabels = [[NSMutableArray alloc]init];
        [self initView];
    }
    return self;
}

-(void)initView{

    _propertyBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, STHeight(13), ScreenWidth/2, STHeight(88))];
    _propertyBtn.backgroundColor = cwhite;
    [_propertyBtn addTarget:self action:@selector(onClickPropertyBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_propertyBtn];
    [self addSubviewInBtn:_propertyBtn title:MSG_MESSAGE_PROPERTY_BTN image:[UIImage imageNamed:@"消息中心_icon_物业消息"] superscript:2];
    
    _systemBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2, STHeight(13), ScreenWidth/2, STHeight(88))];
    _systemBtn.backgroundColor = cwhite;
    [_systemBtn addTarget:self action:@selector(onClickSystemBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_systemBtn];
    [self addSubviewInBtn:_systemBtn title:MSG_MESSAGE_SYSTEM_BTN image:[UIImage imageNamed:@"消息中心_icon_系统消息"] superscript:199];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/2, STHeight(13), LineHeight, STHeight(88))];
    lineView.backgroundColor = cline;
    [self addSubview:lineView];
    
    [self initTableView];
    [self addSubview:[self noDataView]];
    
}


-(UIView *)noDataView{
    if(_noDataView == nil){
        _noDataView = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(111), ScreenWidth, ContentHeight - STHeight(111))];
        _noDataView.backgroundColor = cwhite;
        _noDataView.hidden = YES;
        [self addSubview:_noDataView];
        
        UIImageView *noDataimageView = [[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth - STWidth(100))/2, STHeight(70), STWidth(100), STWidth(100))];
        noDataimageView.image = [UIImage imageNamed:@"消息中心_ic_无消息"];
        noDataimageView.contentMode =UIViewContentModeScaleAspectFill;
        [_noDataView addSubview:noDataimageView];
        
        UILabel *tipsLabel = [[UILabel alloc]initWithFont:STFont(16) text:MSG_MESSAGE_NO_DATAS textAlignment:NSTextAlignmentCenter textColor:c12 backgroundColor:nil multiLine:NO];
        tipsLabel.frame = CGRectMake(0, STHeight(190), ScreenWidth, STHeight(16));
        [_noDataView addSubview:tipsLabel];
    }
    return _noDataView;
}

-(void)addSubviewInBtn:(UIView *)view title:(NSString *)title image:(UIImage *)image superscript:(NSInteger)count{
    
    UILabel *titleLabel = [[UILabel alloc]initWithFont:STFont(16) text:title textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    titleLabel.frame = CGRectMake(0, STHeight(55), ScreenWidth/2, STHeight(16));
    [view addSubview:titleLabel];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth/2 - STHeight(26))/2, STHeight(16), STHeight(26), STHeight(26))];
    imageView.image = image;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [view addSubview:imageView];
    
    NSString *countStr = [NSString stringWithFormat:@"%ld",count];
    UILabel *superScriptLabel = [[UILabel alloc]initWithFont:STFont(12) text:countStr textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:c18 multiLine:NO];
    superScriptLabel.layer.masksToBounds = YES;
    superScriptLabel.layer.cornerRadius = STHeight(7);
    CGSize labelSize = [countStr sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(12)]];
    superScriptLabel.frame = CGRectMake(STWidth(100), STHeight(12),labelSize.width + STWidth(6) , STHeight(14));
    [view addSubview:superScriptLabel];
    
    [superScriptLabels addObject:superScriptLabel];

}


-(void)initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, STHeight(111), ScreenWidth, ContentHeight - STHeight(111))];
    _tableView.backgroundColor = c15;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_tableView];
                                                              
   _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestMore)];
    
    MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestNew)];
    header.lastUpdatedTimeLabel.hidden = YES;
    _tableView.mj_header = header;

    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_mViewModel.datas count];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return STHeight(82);
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:[MessageCell identify]];
    if(!cell){
        cell = [[MessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MessageCell identify]];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    MessageModel *model = [_mViewModel.datas objectAtIndex:indexPath.row];
    [cell updateData:model];
    return cell;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if(!IS_NS_COLLECTION_EMPTY(_mViewModel.datas)){
        MessageModel *model = [_mViewModel.datas objectAtIndex:indexPath.row];
        MessageType messageType = [MessageModel translateType:model.applyType];
        if(messageType == UserAuth){
            UserModel *userModel = [[AccountManager sharedAccountManager]getUserModel];
            ApplyModel *applyModel = [[AccountManager sharedAccountManager]getApplyModel];
            if(![model.receiverUid isEqualToString:userModel.userUid]){
                if(model.applyState == 1){
                    return;
                }else if(model.applyState == 2){
                    if(applyModel.statu == APPLY_PASS){
                        [STToastUtil showSuccessTips:MSG_MESSAGE_HAS_AUTH_SUCCESS];
                    }else{
                        [_mViewModel goAuthUserPage];
                    }
                    return;
                }
            }
       }
        if(_mViewModel){
            [_mViewModel goMessageDetailPage:model];
        }
    }
}


-(UIView *)selectView{
    if(_selectView == nil){
        _selectView = [[UIView alloc]init];
        _selectView.backgroundColor = c15;
    }
    return _selectView;
}


-(void)onClickPropertyBtn{
    if(_mViewModel){
        if(!IS_NS_COLLECTION_EMPTY(superScriptLabels)){
            UIView *view  = [superScriptLabels objectAtIndex:0];
            view.hidden = YES;
        }
        [_mViewModel goPropertyPage];
    }
}
 
-(void)onClickSystemBtn{
    if(_mViewModel){
        if(!IS_NS_COLLECTION_EMPTY(superScriptLabels)){
            UIView *view  = [superScriptLabels objectAtIndex:1];
            view.hidden = YES;
        }
        [_mViewModel goSystemPage];
    }
}

-(void)updateView:(Boolean)hasMoreData{
    if(IS_NS_COLLECTION_EMPTY(_mViewModel.datas)){
        _tableView.hidden = YES;
        _noDataView.hidden = NO;
    }else{
        _tableView.hidden = NO;
        _noDataView.hidden = YES;
    }
    if(!hasMoreData){
        [_tableView.mj_footer endRefreshingWithNoMoreData];
    }else{
        [_tableView.mj_footer endRefreshing];
    }
    [_tableView.mj_header endRefreshing];
    [_tableView reloadData];

}


-(void)requestMore{
    if(_mViewModel){
        [_mViewModel requestMessageList:YES];
    }
 
}

-(void)requestNew{
    if(_mViewModel){
        [_mViewModel requestMessageList:NO];
    }
}

@end
