//
//  HabitantView.m
//  framework
//
//  Created by 黄成实 on 2018/5/15.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "HabitantView.h"
#import "HabitantCell.h"
#import "STTimeUtil.h"

@interface HabitantView()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)HabitantViewModel *mViewModel;
@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)UIView *layerView;
@property(strong, nonatomic)HabitantModel *currentModel;
@property(strong, nonatomic)UIDatePicker *picker;
@property(strong, nonatomic)UIButton *cancelBtn;
@property(strong, nonatomic)UIButton *confirmBtn;
@property(strong, nonatomic)UILabel *tipsLabel;

@end

@implementation HabitantView

-(instancetype)initWithViewModel:(HabitantViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        _currentModel = [[HabitantModel alloc]init];
        [self initView];
    }
    return self;
}

-(void)initView{
    _tableView = [[UITableView alloc]init];
    _tableView.frame = CGRectMake(0, STHeight(10), ScreenWidth, ContentHeight - STHeight(10));
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_tableView];
    
    _layerView = [[UIView alloc]init];
    _layerView.frame =  CGRectMake(0, 0, ScreenWidth, ContentHeight);
    _layerView.backgroundColor = [cblack colorWithAlphaComponent:0.8];
    _layerView.hidden = YES;
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(OnClickLayerView)];
    [_layerView addGestureRecognizer:recognizer];
    [self addSubview:_layerView];
    [_layerView addSubview:[self picker]];
    
    [_layerView addSubview:[self tipsLabel]];
    [_layerView addSubview:[self cancelBtn]];
    [_layerView addSubview:[self confirmBtn]];
    
    [_mViewModel requestDatas];
}

-(UILabel *)tipsLabel{
    if(_tipsLabel == nil){
        NSString *text = [NSString stringWithFormat:MSG_HABITANT_TIPS,_currentModel.name];
        _tipsLabel = [[UILabel alloc]initWithFont:STFont(14) text:text textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:c19 multiLine:NO];
        _tipsLabel.frame = CGRectMake(0, ContentHeight - STHeight(290), ScreenWidth, STHeight(40));
    }
    return _tipsLabel;
}

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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_mViewModel.datas count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return STHeight(60);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HabitantCell *cell = [tableView dequeueReusableCellWithIdentifier:[HabitantCell identify]];
    if(!cell){
        cell = [[HabitantCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[HabitantCell identify]];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if(_mViewModel && !IS_NS_COLLECTION_EMPTY(_mViewModel.datas)){
        [cell updateData:[_mViewModel.datas objectAtIndex:indexPath.row]];
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    _currentModel = [_mViewModel.datas objectAtIndex:indexPath.row];
    NSString *dateStr = [STTimeUtil generateDate:[STTimeUtil getCurrentTimeStamp]];
    if(![_currentModel.validDate isEqualToString:MSG_HABITANT_FOREVER]){
        dateStr = _currentModel.validDate;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:MSG_DATE_FORMAT];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    [_picker setDate:date];
    _tipsLabel.text =  [NSString stringWithFormat:MSG_HABITANT_TIPS,_currentModel.name];
    _layerView.hidden = NO;
}


-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}


-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return MSG_DELETE;
}

- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    HabitantModel *model = [_mViewModel.datas objectAtIndex:indexPath.row];
    __weak HabitantView *weakSelf = self;
    [STAlertUtil showAlertController:MSG_WARN content:[NSString stringWithFormat:@"删除\"%@\"后,将会删除其账号全部信息，请慎重",model.name] controller:weakSelf.mViewModel.controller confirm:^{
        [weakSelf.mViewModel.datas removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPath.row inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
    }];
 
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
    dateFormatter.dateFormat = MSG_DATE_FORMAT;

    for(int i = 0 ; i < [_mViewModel.datas count] ; i++){
        HabitantModel *model = [[_mViewModel datas]objectAtIndex:i];
        if([_currentModel.name isEqualToString: model.name]){
            _currentModel.validDate = [dateFormatter stringFromDate:date];
            [_mViewModel.datas replaceObjectAtIndex:i withObject:_currentModel];
        }
    }
    
    [self updateView];
}

-(void)updateView{
    [_tableView reloadData];
}

@end
