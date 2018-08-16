//
//  AboutView.m
//  framework
//
//  Created by 黄成实 on 2018/8/13.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "AboutView.h"

@implementation AboutView


-(instancetype)initWithFrame:(CGRect)frame{
    if(self == [super initWithFrame:frame]){
        [self initView];
    }
    return self;
}


-(void)initView{
    UIImage *iconImage = [UIImage imageNamed:@"关于我们_iocn_logo"];
    UIImageView *iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth - iconImage.size.width)/2, STHeight(20),iconImage.size.width, iconImage.size.height)];
    iconImageView.image = iconImage;
    [self addSubview:iconImageView];
    
    UILabel *verisonLabel = [[UILabel alloc]initWithFont:STFont(14) text:MSG_ABOUT_VERSION textAlignment:NSTextAlignmentCenter textColor:c12 backgroundColor:nil multiLine:NO];
    verisonLabel.frame = CGRectMake(0, STHeight(128), ScreenWidth, STHeight(24));
    [self addSubview:verisonLabel];
    
    
    UILabel *contentLabel = [[UILabel alloc]initWithFont:STFont(14) text:MSG_ABOUT_CONTENT textAlignment:NSTextAlignmentCenter textColor:cblack backgroundColor:nil multiLine:YES];
    contentLabel.frame = CGRectMake(STWidth(16), STHeight(168), ScreenWidth - STWidth(32),STHeight(24) * 8);
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:MSG_ABOUT_CONTENT];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = STHeight(10);
    paragraphStyle.baseWritingDirection = NSWritingDirectionLeftToRight;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [contentLabel.text length])];
    contentLabel.attributedText = attributedString;
    [self addSubview:contentLabel];
}


@end
