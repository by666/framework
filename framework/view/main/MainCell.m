//
//  MainCell.m
//  framework
//
//  Created by 黄成实 on 2018/6/7.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MainCell.h"

@interface MainCell()

@property (strong, nonatomic) UIImageView *showImg;
@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation MainCell

-(instancetype)initWithFrame:(CGRect)frame{
    if(self == [super initWithFrame:frame]){
        [self initView];
    }
    return self;
}


-(void)initView{
    
    _showImg = [[UIImageView alloc]initWithFrame:CGRectMake(((ScreenWidth / 3 ) - STWidth(35))/2, STHeight(25), STWidth(35), STWidth(35))];
    _showImg.layer.masksToBounds = YES;
    _showImg.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_showImg];
    

    _titleLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentCenter textColor:c16 backgroundColor:nil multiLine:NO];
    _titleLabel.frame = CGRectMake(0, STHeight(75), ScreenWidth / 3, STHeight(16));
    [self.contentView addSubview:_titleLabel];
    
   
}

-(void)setData:(NSString *)title imageStr:(NSString *)imageStr{
    _titleLabel.text = title;
    _showImg.image = [UIImage imageNamed:imageStr];
}

+(NSString *)identify{
    return NSStringFromClass([MainCell class]);
}

@end
