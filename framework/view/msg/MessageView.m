//
//  MessageView.m
//  framework
//
//  Created by 黄成实 on 2018/5/29.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MessageView.h"
#import "MessageCell.h"

@interface MessageView()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)MessageViewModel *mViewModel;

@property(strong, nonatomic)UIButton *propertyBtn;
@property(strong, nonatomic)UIButton *systemBtn;
@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)UIView *selectView;
@property(strong, nonatomic)UIScrollView *scrollView;
@property(strong, nonatomic)UILabel *tipsLabel;

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
    
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.frame = CGRectMake(0, 0, ScreenWidth, ContentHeight);
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.backgroundColor = c15;
    _scrollView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestMore)];
    _scrollView.mj_footer.backgroundColor = cwhite;
    
    _scrollView.contentSize = CGSizeMake(ScreenWidth, STHeight(111) + [_mViewModel.datas count] * STHeight(82));
    MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestNew)];
    header.lastUpdatedTimeLabel.hidden = YES;
    _scrollView.mj_header = header;
    _scrollView.mj_header.backgroundColor = cwhite;
    [self addSubview:_scrollView];

    _propertyBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, STHeight(13), ScreenWidth/2, STHeight(88))];
    _propertyBtn.backgroundColor = cwhite;
    [_propertyBtn addTarget:self action:@selector(onClickPropertyBtn) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_propertyBtn];
    [self addSubviewInBtn:_propertyBtn title:MSG_MESSAGE_PROPERTY_BTN image:[UIImage imageNamed:@"ic_property_msg"] superscript:2];
    
    _systemBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2, STHeight(13), ScreenWidth/2, STHeight(88))];
    _systemBtn.backgroundColor = cwhite;
    [_systemBtn addTarget:self action:@selector(onClickSystemBtn) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_systemBtn];
    [self addSubviewInBtn:_systemBtn title:MSG_MESSAGE_SYSTEM_BTN image:[UIImage imageNamed:@"ic_system_msg"] superscript:199];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/2, STHeight(13), 1, STHeight(88))];
    lineView.backgroundColor = c17;
    [_scrollView addSubview:lineView];
    
    [self initTableView];
    if(IS_NS_COLLECTION_EMPTY(_mViewModel.datas)){
        _scrollView.hidden = YES;
        [self addSubview:[self tipsLabel]];
    }
    
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
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, STHeight(111), ScreenWidth, STHeight(82)*[_mViewModel.datas count])];
    _tableView.backgroundColor = c01;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.scrollEnabled = NO;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _tableView.contentSize = CGSizeMake(ScreenWidth, STHeight(82)*[_mViewModel.datas count]);
    [_scrollView addSubview:_tableView];
    
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


-(UILabel *)tipsLabel{
    if(_tipsLabel == nil){
        _tipsLabel = [[UILabel alloc]initWithFont:STFont(16) text:MSG_MESSAGE_NO_DATAS textAlignment:NSTextAlignmentCenter textColor:c16 backgroundColor:nil multiLine:NO];
        _tipsLabel.frame = CGRectMake(0, STHeight(183), ScreenWidth, STHeight(16));
    }
    return _tipsLabel;
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

-(void)onRejectCallback:(MessageModel *)model{
    if(_mViewModel){
        [_mViewModel doReject:model];
    }
}

-(void)onAgreeCallback:(MessageModel *)model{
    if(_mViewModel){
        [_mViewModel doAgree:model];
    }
}

-(void)updateView{
    [_tableView reloadData];
}


-(void)requestMore{
    [_scrollView.mj_footer endRefreshingWithNoMoreData];
}

-(void)requestNew{
    [_scrollView.mj_header endRefreshing];
}

@end
