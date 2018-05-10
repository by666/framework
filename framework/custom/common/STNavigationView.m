//
//  STNavigationView.m
//  framework
//
//  Created by 黄成实 on 2018/5/10.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "STNavigationView.h"

@interface STNavigationView()


@property(strong,nonatomic)UILabel *titleLabel;
@property(strong,nonatomic)UIButton *backBtn;

@end

@implementation STNavigationView{
    NSString *mTitle;
    Boolean mNeedBack;
}

-(instancetype)initWithTitle:(NSString *)title needBack:(Boolean)needBack{
    if(self == [super init]){
        mTitle = title;
        mNeedBack = needBack;
        [self initView];
    }
    return self;
}

-(void)initView{
    self.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:1.0];
    self.frame = CGRectMake(0, StatuBarHeight, ScreenWidth, NavigationBarHeight);
    
    _titleLabel = [[UILabel alloc]initWithFont:STFont(36) text:mTitle textAlignment:NSTextAlignmentCenter textColor:[UIColor blackColor] backgroundColor:nil multiLine:NO];
    _titleLabel.frame = CGRectMake(0, 0, ScreenWidth, NavigationBarHeight);
    [self addSubview:_titleLabel];
    

    if(mNeedBack){
        _backBtn = [[UIButton alloc]init];
        UIImage *image = [UIImage imageNamed:@"ic_back"];
        [_backBtn setImage:image forState:UIControlStateNormal];
        _backBtn.frame = CGRectMake(STWidth(24), (NavigationBarHeight - image.size.height)/2, image.size.width, image.size.height);
        [_backBtn addTarget:self action:@selector(OnBackBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_backBtn];
    }
}


-(void)setTitle:(NSString *)title{
    _titleLabel.text = title;
}

-(void)OnBackBtnClick{
    if(_delegate && [_delegate respondsToSelector:@selector(OnBackBtnClicked)]){
        [_delegate OnBackBtnClicked];
    }
}

@end
