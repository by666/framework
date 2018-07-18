//
//  STDetailView.m
//  framework
//
//  Created by 黄成实 on 2018/6/8.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "STDetailView.h"

@interface STDetailView()

@property(strong, nonatomic)UILabel *titleLabel;
@property(strong, nonatomic)UIScrollView *scrollView;
@property(strong, nonatomic)UILabel *contentLabel;
@property(strong, nonatomic)UIButton *cofirmBtn;

@end

@implementation STDetailView

-(instancetype)init{
    if(self == [super init]){

        [self initView];
    }
    return self;
}



-(void)initView{
    self.frame = CGRectMake(0, 0, ScreenWidth, ContentHeight);
    self.backgroundColor = [cblack colorWithAlphaComponent:0.8];
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(OnClickLayerView)];
    [self addGestureRecognizer:recognizer];
    
    UIView *bodyView = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(125), ScreenWidth, ContentHeight - STHeight(125))];
    bodyView.backgroundColor = cwhite;
    CAShapeLayer *bodyLayer = [[CAShapeLayer alloc] init];
    bodyLayer.frame = bodyView.bounds;
    bodyLayer.path = [UIBezierPath bezierPathWithRoundedRect:bodyView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(STHeight(14), STHeight(14))].CGPath;
    bodyView.layer.mask = bodyLayer;
    bodyView.userInteractionEnabled = YES;
    [self addSubview:bodyView];
    
    _titleLabel = [[UILabel alloc]initWithFont:STFont(18) text:@"" textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    _titleLabel.frame = CGRectMake(0, STHeight(35), ScreenWidth, STHeight(18));
    [bodyView addSubview:_titleLabel];
    
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.frame = CGRectMake(STWidth(15), STHeight(69), ScreenWidth - STWidth(30), STHeight(344));
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [bodyView addSubview:_scrollView];
    
    _contentLabel = [[UILabel alloc]initWithFont:STFont(14) text:@"" textAlignment:NSTextAlignmentLeft textColor:c12 backgroundColor:nil multiLine:YES];
    [_scrollView addSubview:_contentLabel];

    
    _cofirmBtn = [[UIButton alloc]initWithFont:STHeight(18) text:MSG_KOWN textColor:cwhite backgroundColor:c19 corner:STHeight(6) borderWidth:0 borderColor:nil];
    [_cofirmBtn setBackgroundColor:c19a forState:UIControlStateHighlighted];
    _cofirmBtn.frame = CGRectMake(STWidth(139) , STHeight(424), STWidth(96), STHeight(33));
    [_cofirmBtn addTarget:self action:@selector(OnClickLayerView) forControlEvents:UIControlEventTouchUpInside];
    [bodyView addSubview:_cofirmBtn];
}


-(void)setTitle:(NSString *)title content:(NSString *)content{
    _titleLabel.text = title;
    
   
    
    NSDictionary *dic = @{NSKernAttributeName:@2.0f};
    NSMutableAttributedString * attributedString =     [[NSMutableAttributedString alloc] initWithString:content attributes:dic];
    [_contentLabel setAttributedText:attributedString];
    [_contentLabel sizeToFit];
    CGSize contentSize = [_contentLabel.text sizeWithMaxWidth:(ScreenWidth - STWidth(30)) font:[UIFont systemFontOfSize:STFont(14)]];
    _contentLabel.frame = CGRectMake(0, 0, ScreenWidth - STWidth(30), contentSize.height);
    
    _scrollView.contentSize = CGSizeMake(ScreenWidth - STWidth(30), contentSize.height);

}

-(void)OnClickLayerView{
    self.hidden = YES;
}

@end
