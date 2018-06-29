//
//  STResultView.m
//  framework
//
//  Created by 黄成实 on 2018/5/24.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "STResultView.h"

@interface STResultView()

@property(copy, nonatomic)NSString *mTips1;
@property(copy, nonatomic)NSString *mTips2;
@property(strong, nonatomic)UILabel *tips1Label;

@end

@implementation STResultView

-(instancetype)initWithTips:(NSString *)tips1 tips2:(NSString *)tips2{
    if(self == [super init]){
        _mTips1 = tips1;
        _mTips2 = tips2;
        [self initView];
    }
    return self;
}


-(void)initView{
    self.frame = CGRectMake(0, 0, ScreenWidth, ContentHeight);
    self.backgroundColor = cwhite;

    UIImageView *succesImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(158), STHeight(54), STWidth(60), STWidth(60))];
    succesImageView.image = [UIImage imageNamed:@"ic_success"];
    [self addSubview:succesImageView];
    
    _tips1Label = [[UILabel alloc]initWithFont:STFont(18) text:_mTips1 textAlignment:NSTextAlignmentCenter textColor:c20 backgroundColor:nil multiLine:YES];
    CGSize tip1Size = [_mTips1 sizeWithMaxWidth:ScreenWidth - STWidth(60) font:[UIFont systemFontOfSize:STFont(18)]];
    _tips1Label.frame = CGRectMake(STWidth(30), STHeight(142), ScreenWidth - STWidth(60), tip1Size.height);
    [self addSubview:_tips1Label];
    
    UILabel *tips2Label = [[UILabel alloc]initWithFont:STFont(14) text:_mTips2 textAlignment:NSTextAlignmentCenter textColor:c20 backgroundColor:nil multiLine:YES];
    CGSize tip2Size = [_mTips2 sizeWithMaxWidth:ScreenWidth - STWidth(60) font:[UIFont systemFontOfSize:STFont(14)]];
    tips2Label.frame = CGRectMake(STWidth(30), STHeight(170), ScreenWidth - STWidth(60), tip2Size.height);
    [self addSubview:tips2Label];
}


-(void)setTips1Text:(NSString *)text{
    _tips1Label.text = text;
}
@end
