
//
//  ReportFixView.m
//  framework
//
//  Created by 黄成实 on 2018/6/6.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "ReportFixView.h"
#import "UITextView+Placeholder.h"
#import "STSinglePickerLayerView.h"
#import "STSelectLayerButton.h"
#import "STResultView.h"
#import "STTimeUtil.h"
#import "STOrderTimeLayerView.h"
#import "FixHistroyPage.h"

@interface ReportFixView()<STSinglePickerLayerViewDelegate,STOrderTimeLayerViewDelegate,UITextViewDelegate>

@property(strong, nonatomic)ReportFixViewModel *mViewModel;
@property(strong, nonatomic)UITextView *textView;
@property(strong, nonatomic)UIButton *confirmBtn;
@property(strong, nonatomic)STSinglePickerLayerView *categoryLayerView;
@property(strong, nonatomic)STSelectLayerButton *categorySelectBtn;
@property(strong, nonatomic)STSelectLayerButton *dateSelectBtn;
@property(strong, nonatomic)STResultView *resultView;
@property(strong, nonatomic)STOrderTimeLayerView *orderTimeLayerView;

@end


@implementation ReportFixView{
    NSString *orderTimeStr;
    NSString *categoryStr;
}

-(instancetype)initWithViewModel:(ReportFixViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}


-(void)initView{
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(10), ScreenWidth, ContentHeight - STHeight(10))];
    bgView.backgroundColor = cwhite;
    [self addSubview:bgView];
    
    NSArray *titleArray = @[MSG_REPORTFIX_CATEGORY,MSG_REPORTFIX_SERVETIME,MSG_REPORTFIX_DETAIL];
    
    for(int i = 0 ; i < [titleArray count] ; i++){
        NSString *textStr = titleArray[i];
        UILabel *label = [[UILabel alloc]initWithFont:STFont(16) text:textStr textAlignment:NSTextAlignmentLeft textColor:c16 backgroundColor:nil multiLine:NO];
        CGSize labelSize = [textStr sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
        label.frame = CGRectMake(STWidth(15), STHeight(32) + STHeight(60) * i, labelSize.width, STHeight(16));
        [self addSubview:label];
        
        if(i + 1  != [titleArray count]){
            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(10) + STHeight(60) * (i+1), ScreenWidth, LineHeight)];
            lineView.backgroundColor = cline;
            [self addSubview:lineView];
        }
    }
    
    
    categoryStr = [MSG_REPORTFIX_CATEGORY_ARRAY componentsSeparatedByString:@"|"][0];
    CGSize categorySize = [categoryStr sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _categorySelectBtn = [[STSelectLayerButton alloc]initWithFrame:CGRectMake(ScreenWidth - STWidth(36) - categorySize.width, STHeight(10), STWidth(36) + categorySize.width, STHeight(60))];
    [_categorySelectBtn setSelectText:categoryStr];
    [_categorySelectBtn addTarget:self action:@selector(onClickCategorySelectBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_categorySelectBtn];
    
    CGSize dateSize = [MSG_CHOOSE sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _dateSelectBtn = [[STSelectLayerButton alloc]initWithFrame:CGRectMake(ScreenWidth - STWidth(36) - dateSize.width, STHeight(70), STWidth(36) + dateSize.width, STHeight(60))];
    [_dateSelectBtn setSelectText:MSG_CHOOSE];
    [_dateSelectBtn addTarget:self action:@selector(onClickDateSelectBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_dateSelectBtn];
    
    _textView = [[UITextView alloc]init];
    _textView.frame = CGRectMake(STWidth(15), STHeight(182), ScreenWidth - STWidth(30), STHeight(140));
//    _textView.backgroundColor = c15;
    _textView.font = [UIFont systemFontOfSize:STFont(16)];
    _textView.delegate = self;
    _textView.textColor = c12;
    [_textView setPlaceholder:MSG_REPORTFIX_DETAIL_TIPS placeholdColor:c17];
//    _textView.textContainerInset = UIEdgeInsetsMake(0,0, 0, 0);
//    _textView.contentInset = UIEdgeInsetsMake(0, 0, STHeight(10), 0);
//    _textView.layoutManager.allowsNonContiguousLayout=NO;
    
    [self addSubview:_textView];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.frame = CGRectMake(0, STHeight(320)-LineHeight, ScreenWidth, LineHeight);
    lineView.backgroundColor = cline;
    [self addSubview:lineView];
    
    _confirmBtn = [[UIButton alloc]initWithFont:STFont(16) text:MSG_COMMIT textColor:c09 backgroundColor:c15 corner:STHeight(25) borderWidth:0 borderColor:nil];
    _confirmBtn.frame = CGRectMake(STWidth(50), ContentHeight - STHeight(90), STWidth(276), STHeight(50));
    [_confirmBtn setBackgroundColor:c08a forState:UIControlStateHighlighted];
    [_confirmBtn addTarget:self action:@selector(onClickConfirmBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_confirmBtn];
    
    _confirmBtn.enabled = NO;
    
    
    [self addSubview:[self categoryLayerView]];
    [self addSubview:[self orderTimeLayerView]];
    
}


-(STSinglePickerLayerView *)categoryLayerView{
    if(_categoryLayerView == nil){
        NSMutableArray *datas = [[MSG_REPORTFIX_CATEGORY_ARRAY componentsSeparatedByString:@"|"] mutableCopy];
        _categoryLayerView = [[STSinglePickerLayerView alloc]initWithDatas:datas];
        _categoryLayerView.delegate = self;
        _categoryLayerView.hidden = YES;
    }
    return _categoryLayerView;
}


-(STOrderTimeLayerView *)orderTimeLayerView{
    if(_orderTimeLayerView == nil){
        _orderTimeLayerView = [[STOrderTimeLayerView alloc]init];
        _orderTimeLayerView.delegate = self;
        _orderTimeLayerView.hidden = YES;
    }
    return _orderTimeLayerView;
}

-(void)onClickConfirmBtn{
    if(_mViewModel){
        [_mViewModel doReprotFix:orderTimeStr category:categoryStr detail:_textView.text];
    }
}

-(void)onReportFixSuccess{
//    _resultView = [[STResultView alloc]initWithTips:MSG_REPORTFIX_RESULT_TIPS tips2:MSG_REPORTFIX_RESULT_TIPS2];
//    [self addSubview:_resultView];
    
}

-(void)onClickCategorySelectBtn{
    [_textView resignFirstResponder];
    _categoryLayerView.hidden = NO;
}

-(void)onClickDateSelectBtn{
    [_textView resignFirstResponder];
    _orderTimeLayerView.hidden = NO;
}

-(void)onSelectResult:(NSString *)result{
    categoryStr = result;
    [_categorySelectBtn setSelectText:result];
    [self changeBtnStatu];
}

-(void)OnOrderTimeSelectResult:(NSString *)orderTime{
    orderTimeStr = [[orderTime stringByReplacingOccurrencesOfString:@"月" withString:@"."] stringByReplacingOccurrencesOfString:@"日" withString:@""];
    [_dateSelectBtn setSelectText:orderTimeStr];
    [self changeBtnStatu];
}

-(void)textViewDidChange:(UITextView *)textView{
    [self changeBtnStatu];
}


-(void)changeBtnStatu{
    if(IS_NS_STRING_EMPTY(_textView.text)){
        _confirmBtn.enabled = NO;
        _confirmBtn.backgroundColor = c15;
        [_confirmBtn setTitleColor:c09 forState:UIControlStateNormal];
        return;
    }
    
    if([[_dateSelectBtn getSelectText] isEqualToString:MSG_CHOOSE]){
        _confirmBtn.enabled = NO;
        _confirmBtn.backgroundColor = c15;
        [_confirmBtn setTitleColor:c09 forState:UIControlStateNormal];
        return;
    }
    _confirmBtn.enabled = YES;
    _confirmBtn.backgroundColor = c08;
    [_confirmBtn setTitleColor:cwhite forState:UIControlStateNormal];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_textView resignFirstResponder];
}




@end
