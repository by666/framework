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
#import "STSelectLayerButton.h"

@interface VerificateUserView()<UITableViewDelegate,UITableViewDataSource,STSinglePickerLayerViewDelegate>

@property(strong, nonatomic)VerificateViewModel *mViewModel;
@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)STSinglePickerLayerView *validPickerLayerView;
@property(strong, nonatomic)UIButton *verificateBtn;
@property(strong, nonatomic)UIButton *rejectBtn;
@property(strong, nonatomic)STSelectLayerButton *validDateBtn;


@end

@implementation VerificateUserView{
    NSString *validDate;
    int validType;
}

-(instancetype)initWithViewModel:(VerificateViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    
    _tableView = [[UITableView alloc]init];
    _tableView.frame = CGRectMake(0, STHeight(10), ScreenWidth, STHeight(324));
    _tableView.backgroundColor = cwhite;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    [self addSubview:_tableView];
    
    [_tableView useDefaultProperty];
    
    [self initSelectValidDate];
    
    _validPickerLayerView = [[STSinglePickerLayerView alloc]initWithDatas:_mViewModel.vaildArray];
    _validPickerLayerView.delegate = self;
    _validPickerLayerView.hidden = YES;
    [self addSubview:_validPickerLayerView];
    
}

-(void)initSelectValidDate{
    UIView *validView = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(345), ScreenWidth, STHeight(60))];
    validView.backgroundColor = cwhite;
    [self addSubview:validView];
    
    
    UILabel *titleLabel = [[UILabel alloc]initWithFont:STFont(16) text:MSG_VERIFICATE_VALIDDATE textAlignment:NSTextAlignmentLeft textColor:c16 backgroundColor:nil multiLine:NO];
    titleLabel.frame = CGRectMake(STWidth(15), STHeight(22),STWidth(100) , STHeight(16));
    [validView addSubview:titleLabel];
    

    
    validDate = MSG_VERIFICATE_DATE_YEAR;
    validType = 3;
    CGSize validSize = [validDate sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];

    _validDateBtn = [[STSelectLayerButton alloc]initWithFrame:CGRectMake(ScreenWidth - STWidth(36) - validSize.width, 0, STWidth(36) + validSize.width, STHeight(60))];
    [_validDateBtn setSelectText:validDate];
    [_validDateBtn addTarget:self action:@selector(onClickValidBtn) forControlEvents:UIControlEventTouchUpInside];
    [validView addSubview:_validDateBtn];
    
    
    
    MessageStatu statu = _mViewModel.model.applyState;

    _verificateBtn = [[UIButton alloc]initWithFont:STFont(14) text:MSG_VERIFICATE_AGREE textColor:cwhite backgroundColor:c08 corner:STHeight(25) borderWidth:0 borderColor:nil];
    _verificateBtn.frame = CGRectMake(STWidth(50), ContentHeight - STHeight(130), STWidth(276), STHeight(50));
    [_verificateBtn addTarget:self action:@selector(onClickVerificateBtn) forControlEvents:UIControlEventTouchUpInside];
    [_verificateBtn setBackgroundColor:c08a forState:UIControlStateHighlighted];
    [self addSubview:_verificateBtn];
    if(statu == Reject || statu == Granted || statu == Expired){
        [_verificateBtn setTitle:[MessageModel translateStatu:_mViewModel.model.applyState overdueDate:_mViewModel.model.overdueDate] forState:UIControlStateNormal];
        [_verificateBtn setBackgroundColor:c12];
        _verificateBtn.enabled = NO;
    }
    
    
    _rejectBtn = [[UIButton alloc]initWithFont:STFont(14) text:MSG_VERIFICATE_REJECT textColor:c08 backgroundColor:nil corner:0 borderWidth:0 borderColor:nil];
    _rejectBtn.frame = CGRectMake(STWidth(112), ContentHeight - STHeight(64), STWidth(151), STHeight(24));
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
        return STHeight(96);
    }
    return STHeight(56.5);
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
    if([MSG_VERIFICATE_DATE_QUATERYEAD isEqualToString:result]){
        validType = 1;
    }
    else if([MSG_VERIFICATE_DATE_HALF isEqualToString:result]){
        validType = 2;
    }else if([MSG_VERIFICATE_DATE_YEAR isEqualToString:result]){
        validType = 3;
    }else if([MSG_VERIFICATE_DATE_FOREVER isEqualToString:result]){
        validType = 4;
    }
    [_validDateBtn setSelectText:result];
}

-(void)onClickVerificateBtn{
    if(_mViewModel){
        [_mViewModel doAgree:true valid:validType userTime:@""];
    }
}

-(void)onClickRejectBtn{
    if(_mViewModel){
        [_mViewModel doAgree:false valid:validType userTime:@""];
    }
}

-(void)updateView{
    [_tableView reloadData];
}

@end
