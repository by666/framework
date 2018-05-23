//
//  STDateLayerView.m
//  framework
//
//  Created by by.huang on 2018/5/23.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "STDateLayerView.h"

@interface STDateLayerView()

@property(strong, nonatomic)UIDatePicker *picker;
@property(strong, nonatomic)UIButton *cancelBtn;
@property(strong, nonatomic)UIButton *confirmBtn;
@property(strong, nonatomic)UILabel *tipsLabel;


@property(copy, nonatomic)NSString *mTitle;

@end;

@implementation STDateLayerView

-(instancetype)initWithTitle:(NSString *)title frame:(CGRect)frame{
    if(self == [super initWithFrame:frame]){
        self.frame = frame;
        _mTitle = title;
        [self initView];
    }
    return self;
}

-(void)initView{
    self.backgroundColor = [cblack colorWithAlphaComponent:0.8];
    self.hidden = YES;
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(OnClickLayerView)];
    [self addGestureRecognizer:recognizer];
    [self addSubview:[self picker]];
    [self addSubview:[self cancelBtn]];
    [self addSubview:[self confirmBtn]];
    
    if(!IS_NS_STRING_EMPTY(_mTitle)){
        [self addSubview:[self tipsLabel]];
    }

}

-(void)setDate:(NSString *)dateStr{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:MSG_DATE_FORMAT2];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    [_picker setDate:date];
}

-(UILabel *)tipsLabel{
    if(_tipsLabel == nil){
        _tipsLabel = [[UILabel alloc]initWithFont:STFont(14) text:_mTitle textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:c19 multiLine:NO];
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


-(void)OnClickLayerView{
    self.hidden = YES;
}

-(void)OnClickCancelBtn{
    self.hidden = YES;
}

-(void)OnClickConfirmBtn{
    self.hidden = YES;
    
    NSDate *date = _picker.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = MSG_DATE_FORMAT2;
    
    if(_delegate){
        [_delegate OnDateSelectResult:[dateFormatter stringFromDate:date]];
    }
}
@end
