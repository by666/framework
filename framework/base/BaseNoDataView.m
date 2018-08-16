//
//  BaseNoDataView.m
//  framework
//
//  Created by 黄成实 on 2018/8/15.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "BaseNoDataView.h"

@interface BaseNoDataView()

@property(copy, nonatomic)NSString *mImageSrc;
@property(copy, nonatomic)NSString *mTitle;
@property(copy, nonatomic)NSString *mButtonTitle;
@property(copy,nonatomic)void(^mOnClick)(void);

@end

@implementation BaseNoDataView

-(instancetype)initWithImage:(NSString *)imageSrc title:(NSString *)title buttonTitle:(NSString *)buttonTitle onclick:(void (^)(void))onclick{
    if(self == [super init]){
        _mImageSrc = imageSrc;
        _mTitle = title;
        _mButtonTitle = buttonTitle;
        _mOnClick = onclick;
        [self initView];
    }
    return self;
}

-(void)initView{
    self.backgroundColor = c15;
    self.frame = CGRectMake(0, 0, ScreenWidth, ContentHeight);
    
    UIImageView *noDataimageView = [[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth - STWidth(100))/2, STHeight(70), STWidth(100), STWidth(100))];
    noDataimageView.image = [UIImage imageNamed:_mImageSrc];
    noDataimageView.contentMode =UIViewContentModeScaleAspectFill;
    [self addSubview:noDataimageView];
    
    UILabel *tipsLabel = [[UILabel alloc]initWithFont:STFont(16) text:_mTitle textAlignment:NSTextAlignmentCenter textColor:c12 backgroundColor:nil multiLine:NO];
    tipsLabel.frame = CGRectMake(0, STHeight(190), ScreenWidth, STHeight(16));
    [self addSubview:tipsLabel];
    
    if(!IS_NS_STRING_EMPTY(_mButtonTitle)){
        UIButton *button = [[UIButton alloc]initWithFont:STFont(16) text:_mButtonTitle textColor:c08 backgroundColor:nil corner:STHeight(25) borderWidth:LineHeight borderColor:c08];
        button.frame = CGRectMake((ScreenWidth - STWidth(150))/2, STHeight(266), STWidth(150), STHeight(50));
        [button addTarget:self action:@selector(onClickBtn) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}



-(void)onClickBtn{
    if(_mOnClick){
        _mOnClick();
    }
}

@end
