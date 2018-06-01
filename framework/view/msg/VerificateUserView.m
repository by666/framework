//
//  VerificateUserView.m
//  framework
//
//  Created by 黄成实 on 2018/5/31.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "VerificateUserView.h"
#import "VerificateViewCell.h"
#import "STSinglePickerLayerView.h"

@interface VerificateUserView()<UITableViewDelegate,UITableViewDataSource,STSinglePickerLayerViewDelegate>

@property(strong, nonatomic)VerificateViewModel *mViewModel;
@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)UIButton *validDateBtn;
@property(strong, nonatomic)STSinglePickerLayerView *validPickerLayerView;
@property(strong, nonatomic)UIButton *verificateBtn;
@property(strong, nonatomic)UIButton *rejectBtn;


@end

@implementation VerificateUserView{
    NSString *validDate;
}

-(instancetype)initWithViewModel:(VerificateViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    UILabel *titleLabel = [[UILabel alloc]initWithFont:STFont(17) text:MSG_VERIFICATE_USER_TITLE textAlignment:NSTextAlignmentLeft textColor:c11 backgroundColor:nil multiLine:NO];
    titleLabel.frame = CGRectMake(STWidth(15), STHeight(16), ScreenWidth - STWidth(30), STHeight(17));
    [self addSubview:titleLabel];
    
    _tableView = [[UITableView alloc]init];
    _tableView.frame = CGRectMake(0, STHeight(55), ScreenWidth, STHeight(95) + STHeight(60) * 4);
    _tableView.backgroundColor = cwhite;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_tableView];
    
    [self initSelectValidDate];
    
    _validPickerLayerView = [[STSinglePickerLayerView alloc]initWithDatas:_mViewModel.vaildArray];
    _validPickerLayerView.delegate = self;
    _validPickerLayerView.hidden = YES;
    [self addSubview:_validPickerLayerView];
    
}

-(void)initSelectValidDate{
    UIView *validView = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(404), ScreenWidth, STHeight(60))];
    validView.backgroundColor = cwhite;
    [self addSubview:validView];
    
    UIView *topLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
    topLineView.backgroundColor = c17;
    [validView addSubview:topLineView];
    
    UIView *bottomLineView = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(60)-1, ScreenWidth, 1)];
    bottomLineView.backgroundColor = c17;
    [validView addSubview:bottomLineView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFont:STFont(16) text:MSG_VERIFICATE_VALIDDATE textAlignment:NSTextAlignmentLeft textColor:c16 backgroundColor:nil multiLine:NO];
    titleLabel.frame = CGRectMake(STWidth(15), STHeight(22),STWidth(100) , STHeight(16));
    [validView addSubview:titleLabel];
    
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"ic_bottom_arrow"];
    imageView.frame = CGRectMake(ScreenWidth - STWidth(26), STHeight(26.5), STWidth(11), STHeight(7));
    [validView addSubview:imageView];
    
    validDate = MSG_VERIFICATE_DATE_YEAR;
    CGSize validSize = [validDate sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _validDateBtn = [[UIButton alloc]initWithFont:STFont(16) text:validDate textColor:c12 backgroundColor:nil corner:0 borderWidth:0 borderColor:nil];
    _validDateBtn.frame = CGRectMake(ScreenWidth - STWidth(26) - STWidth(10) - validSize.width, 0, validSize.width+STWidth(10), STHeight(60));
    [_validDateBtn addTarget:self action:@selector(onClickValidBtn) forControlEvents:UIControlEventTouchUpInside];
    [validView addSubview:_validDateBtn];
    
    
    MessageStatu statu = _mViewModel.model.messageStatu;

    _verificateBtn = [[UIButton alloc]initWithFont:STFont(14) text:MSG_VERIFICATE_AGREE textColor:cwhite backgroundColor:c08 corner:STHeight(22.4) borderWidth:0 borderColor:nil];
    _verificateBtn.frame = CGRectMake(STWidth(112), STHeight(490), STWidth(151), STHeight(45));
    [_verificateBtn addTarget:self action:@selector(onClickVerificateBtn) forControlEvents:UIControlEventTouchUpInside];
    [_verificateBtn setBackgroundColor:c08a forState:UIControlStateHighlighted];
    [self addSubview:_verificateBtn];
    if(statu == Reject || statu == Granted || statu == Expired){
        [_verificateBtn setTitle:[MessageModel translateStatu:statu] forState:UIControlStateNormal];
        [_verificateBtn setBackgroundColor:c08b];
        _verificateBtn.enabled = NO;
    }
    
    
    _rejectBtn = [[UIButton alloc]initWithFont:STFont(14) text:MSG_VERIFICATE_REJECT textColor:c21 backgroundColor:c15 corner:0 borderWidth:0 borderColor:nil];
    _rejectBtn.frame = CGRectMake(STWidth(112), STHeight(550), STWidth(151), STHeight(22.5));
    [_rejectBtn addTarget:self action:@selector(onClickRejectBtn) forControlEvents:UIControlEventTouchUpInside];
    _rejectBtn.hidden = YES;
    [self addSubview:_rejectBtn];
    if(statu == DefaultStatu){
        _rejectBtn.hidden = NO;
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_mViewModel.datas count];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        return STHeight(95);
    }
    return STHeight(60);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VerificateViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[VerificateViewCell identify]];
    if(!cell){
        cell = [[VerificateViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[VerificateViewCell identify]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSMutableArray *datas = _mViewModel.datas;
    if(!IS_NS_COLLECTION_EMPTY(datas)){
        TitleContentModel *model = [datas objectAtIndex:indexPath.row];
        [cell updateData:model position:indexPath.row];
    }
    return cell;
}


-(void)onClickValidBtn{
    _validPickerLayerView.hidden = NO;
    [_validPickerLayerView setData:validDate];
}

-(void)onSelectResult:(NSString *)result{
    validDate = result;
    CGSize validSize = [result sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _validDateBtn.frame = CGRectMake(ScreenWidth - STWidth(26) - STWidth(10) - validSize.width, 0, validSize.width+STWidth(10), STHeight(60));
    [_validDateBtn setTitle:result forState:UIControlStateNormal];
}

-(void)onClickVerificateBtn{
    if(_mViewModel){
        [_mViewModel doAgree];
    }
}

-(void)onClickRejectBtn{
    if(_mViewModel){
        [_mViewModel doReject];
    }
}

@end
