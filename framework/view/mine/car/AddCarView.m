//
//  AddCarView.m
//  framework
//
//  Created by 黄成实 on 2018/5/19.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "AddCarView.h"
#import "STCarNumLayerView.h"
@interface AddCarView()<STCarNumLayerViewDelegate>

@property(strong, nonatomic)AddCarViewModel *mViewModel;
@property(strong, nonatomic)UIButton *headBtn;


@property(strong, nonatomic)STCarNumLayerView *carNumLayerView;
@property(strong, nonatomic)UITextField *numTextField;
@property(strong, nonatomic)UILabel *headLabel;


@end

@implementation AddCarView{
    NSArray *shortHeadArray;
    NSArray *alphabetArray;
    NSInteger row1;
    NSInteger row2;
}

-(instancetype)initWithViewModel:(AddCarViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    
    shortHeadArray = [_mViewModel getCarShortHead];
    alphabetArray =  [_mViewModel getCarAlphabet];
    
    
    UIView *contentView = [[UIView alloc]init];
    contentView.backgroundColor = cwhite;
    contentView.frame = CGRectMake(0, STHeight(10), ScreenWidth, ContentHeight - STHeight(10));
    [self addSubview:contentView];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = c17;
    lineView.frame = CGRectMake(0, STHeight(60),STWidth(ScreenWidth), LineHeight);
    [contentView addSubview:lineView];
    
    UILabel *carNumLabel = [[UILabel alloc]initWithFont:STFont(18) text:MSG_ADDCAR_CARNUM textAlignment:NSTextAlignmentLeft textColor:c20 backgroundColor:nil multiLine:NO];
    carNumLabel.frame = CGRectMake(STWidth(15), STHeight(21), STWidth(80), STHeight(18));
    [contentView addSubview:carNumLabel];
    


    _headBtn = [[UIButton alloc]initWithFont:STFont(18) text:@"" textColor:c16 backgroundColor:[UIColor clearColor] corner:0 borderWidth:0 borderColor:nil];
    CGSize headSize = [MSG_ADDCAR_DEFAULT_HEAD sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(18)]];
    _headBtn.frame = CGRectMake(ScreenWidth - STWidth(127) - headSize.width - STWidth(23.5),0, headSize.width + STWidth(23.5), STHeight(60));
    [_headBtn addTarget:self action:@selector(OnClickHeadBtn) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:_headBtn];
    
    _headLabel = [[UILabel alloc]initWithFont:STFont(18) text:MSG_ADDCAR_DEFAULT_HEAD textAlignment:NSTextAlignmentLeft textColor:c16 backgroundColor:nil multiLine:NO];
    _headLabel.frame = CGRectMake(0, 0, headSize.width, STHeight(60));
    [_headBtn addSubview:_headLabel];
    
    UIImageView *headImageView = [[UIImageView alloc]init];
    headImageView.image = [UIImage imageNamed:@"ic_arrow_bottom"];
    headImageView.contentMode = UIViewContentModeScaleAspectFill;
    headImageView.frame = CGRectMake(headSize.width + STHeight(12.5), STHeight(29), STWidth(11), STHeight(7));
    [_headBtn addSubview:headImageView];
    
    
    _numTextField = [[UITextField alloc]initWithFont:STFont(18) textColor:c12 backgroundColor:nil corner:0 borderWidth:0 borderColor:nil padding:STWidth(10)];
    _numTextField.frame = CGRectMake(ScreenWidth - STWidth(117), 0, STWidth(107), STHeight(60));
    _numTextField.textAlignment = NSTextAlignmentLeft;
    _numTextField.placeholder = MSG_ADDCAR_HINT;
    [_numTextField setMaxLength:@"6"];
    [_numTextField becomeFirstResponder];
    [contentView addSubview:_numTextField];
    
    
    
    _carNumLayerView = [[STCarNumLayerView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ContentHeight)];
    _carNumLayerView.delegate = self;
    _carNumLayerView.hidden = YES;
    [_carNumLayerView setCarNum:MSG_ADDCAR_DEFAULT_HEAD];
    [self addSubview:_carNumLayerView];
    
    
}




-(void)OnClickHeadBtn{
    
    [_numTextField resignFirstResponder];
    _carNumLayerView.hidden = NO;

}


-(void)OnCarNumSelectResult:(NSString *)carNumStr{
    
    CGSize headSize = [carNumStr sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(18)]];
    _headBtn.frame = CGRectMake(ScreenWidth - STWidth(127) - headSize.width - STWidth(23.5),0, headSize.width + STWidth(23.5), STHeight(60));
    _headLabel.frame = CGRectMake(0, 0, headSize.width, STHeight(60));
    _headLabel.text = carNumStr;

}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_numTextField resignFirstResponder];
}


-(void)addCarData{
    if(_mViewModel){
        NSString *resultStr = @"";
        resultStr = [resultStr stringByAppendingString:[shortHeadArray objectAtIndex:row1]];
        resultStr = [resultStr stringByAppendingString:[alphabetArray objectAtIndex:row2]];
        _mViewModel.data.carNum = _numTextField.text;
        _mViewModel.data.carHead = resultStr;
        [_mViewModel addCarData];
    }
}


@end
