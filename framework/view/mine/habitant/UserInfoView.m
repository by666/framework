//
//  UserInfoView.m
//  framework
//
//  Created by 黄成实 on 2018/8/14.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "UserInfoView.h"
#import "UserInfoCell.h"
#import "STSelectLayerButton.h"
#import "STTimeUtil.h"

@interface UserInfoView()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)UIView *layerView;
@property(strong, nonatomic)UIDatePicker *picker;
@property(strong, nonatomic)UIButton *cancelBtn;
@property(strong, nonatomic)UIButton *confirmBtn;
//@property(strong, nonatomic)UILabel *tipsLabel;
@property(strong, nonatomic)UserInfoViewModel *mViewModel;
@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)STSelectLayerButton *validDateBtn;
@property(strong, nonatomic)UIButton *commitBtn;

@end

@implementation UserInfoView

-(instancetype)initWithViewModel:(UserInfoViewModel *)viewModel{
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
    
    
    [self initSelectView];
    
    _commitBtn = [[UIButton alloc]initWithFont:STFont(14) text:MSG_COMMIT textColor:cwhite backgroundColor:c08 corner:STHeight(25) borderWidth:0 borderColor:nil];
    _commitBtn.frame = CGRectMake(STWidth(50), ContentHeight - STHeight(130), STWidth(276), STHeight(50));
    [_commitBtn addTarget:self action:@selector(onClickCommitBtn) forControlEvents:UIControlEventTouchUpInside];
    [_commitBtn setBackgroundColor:c08a forState:UIControlStateHighlighted];
    [self addSubview:_commitBtn];
    
    
    _layerView = [[UIView alloc]init];
    _layerView.frame =  CGRectMake(0, 0, ScreenWidth, ContentHeight);
    _layerView.backgroundColor = [cblack colorWithAlphaComponent:0.8];
    _layerView.hidden = YES;
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(OnClickLayerView)];
    [_layerView addGestureRecognizer:recognizer];
    [self addSubview:_layerView];
    [_layerView addSubview:[self picker]];
    
//    [_layerView addSubview:[self tipsLabel]];
    [_layerView addSubview:[self cancelBtn]];
    [_layerView addSubview:[self confirmBtn]];
}


-(void)initSelectView{
    UIView *validView = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(345), ScreenWidth, STHeight(60))];
    validView.backgroundColor = cwhite;
    [self addSubview:validView];
    
    
    UILabel *titleLabel = [[UILabel alloc]initWithFont:STFont(16) text:MSG_VERIFICATE_VALIDDATE textAlignment:NSTextAlignmentLeft textColor:c16 backgroundColor:nil multiLine:NO];
    titleLabel.frame = CGRectMake(STWidth(15), STHeight(22),STWidth(100) , STHeight(16));
    [validView addSubview:titleLabel];
    
    NSString *overdue = [_mViewModel.model.overdue stringByReplacingOccurrencesOfString:@"年" withString:@"."];
    overdue = [overdue stringByReplacingOccurrencesOfString:@"月" withString:@"."];
    overdue = [overdue stringByReplacingOccurrencesOfString:@"日" withString:@""];
    
    CGSize validSize = [overdue sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _validDateBtn = [[STSelectLayerButton alloc]initWithFrame:CGRectMake(ScreenWidth - STWidth(36) - validSize.width, 0, STWidth(36) + validSize.width, STHeight(60))];
    [_validDateBtn setSelectText:overdue];
    [_validDateBtn addTarget:self action:@selector(onClickValidBtn) forControlEvents:UIControlEventTouchUpInside];
    [validView addSubview:_validDateBtn];
    
}

//-(UILabel *)tipsLabel{
//    if(_tipsLabel == nil){
//        NSString *text = [NSString stringWithFormat:MSG_HABITANT_TIPS,_mViewModel.model.userName];
//        _tipsLabel = [[UILabel alloc]initWithFont:STFont(14) text:text textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:c19 multiLine:NO];
//        _tipsLabel.frame = CGRectMake(0, ContentHeight - STHeight(290), ScreenWidth, STHeight(40));
//    }
//    return _tipsLabel;
//}

-(UIButton *)cancelBtn{
    if(_cancelBtn == nil){
        _cancelBtn = [[UIButton alloc]initWithFont:STFont(16) text:MSG_CANCEL textColor:c12 backgroundColor:c15 corner:0 borderWidth:0 borderColor:nil];
        _cancelBtn.frame = CGRectMake(0, ContentHeight - STHeight(250), ScreenWidth/2, STHeight(50));
        [_cancelBtn addTarget:self action:@selector(OnClickCancelBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

-(UIButton *)confirmBtn{
    if(_confirmBtn == nil){
        _confirmBtn = [[UIButton alloc]initWithFont:STFont(16) text:MSG_CONFIRM textColor:c20 backgroundColor:c15 corner:0 borderWidth:0 borderColor:nil];
        _confirmBtn.frame = CGRectMake(ScreenWidth/2, ContentHeight - STHeight(250), ScreenWidth/2, STHeight(50));
        [_confirmBtn addTarget:self action:@selector(OnClickConfirmBtn) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _confirmBtn;
}


-(UIDatePicker *)picker{
    if(_picker == nil){
        _picker = [[UIDatePicker alloc]init];
        _picker.frame = CGRectMake(0, ContentHeight - STHeight(200), ScreenWidth, STHeight(200));
        _picker.datePickerMode = UIDatePickerModeDate;
        [_picker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
        _picker.backgroundColor = cwhite;
    }
    return _picker;
}


-(void)OnClickLayerView{
    _layerView.hidden = YES;
}

-(void)OnClickCancelBtn{
    _layerView.hidden = YES;
}

-(void)OnClickConfirmBtn{
    _layerView.hidden = YES;
    
    NSDate *date = _picker.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = MSG_DATE_FORMAT_ZH;
    _mViewModel.model.overdue = [dateFormatter stringFromDate:date];
    
    NSString *dateStr = [_mViewModel.model.overdue stringByReplacingOccurrencesOfString:@"年" withString:@"."];
    dateStr = [dateStr stringByReplacingOccurrencesOfString:@"月" withString:@"."];
    dateStr = [dateStr stringByReplacingOccurrencesOfString:@"日" withString:@""];
    [_validDateBtn setSelectText:dateStr];
    
}

-(void)onClickCommitBtn{
    if(_mViewModel){
        [_mViewModel updateHabitant];
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
    UserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:[UserInfoCell identify]];
    if(!cell){
        cell = [[UserInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[UserInfoCell identify]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSMutableArray *datas = _mViewModel.datas;
    if(!IS_NS_COLLECTION_EMPTY(datas)){
        TitleContentModel *model = [datas objectAtIndex:indexPath.row];
        [cell updateData:model position:indexPath.row];
    }
    return cell;
}


-(void)updateView{
    
}

-(void)onClickValidBtn{
    NSString *dateStr = [STTimeUtil generateDate_CH:[STTimeUtil getCurrentTimeStamp]];
    if(![_mViewModel.model.overdue isEqualToString:MSG_HABITANT_FOREVER]){
        dateStr = _mViewModel.model.overdue;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:MSG_DATE_FORMAT_ZH];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    [_picker setDate:date];
//    _tipsLabel.text =  [NSString stringWithFormat:MSG_HABITANT_TIPS,_mViewModel.model.userName];
    _layerView.hidden = NO;
}


@end
