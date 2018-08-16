//
//  MainCell2.m
//  framework
//
//  Created by 黄成实 on 2018/8/7.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MainCell2.h"


@interface MainCell2()

@property (strong, nonatomic) UIImageView *showImg;
@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation MainCell2

-(instancetype)initWithFrame:(CGRect)frame{
    if(self == [super initWithFrame:frame]){
        [self initView];
    }
    return self;
}


-(void)initView{
    

    _showImg = [[UIImageView alloc]initWithFrame:CGRectMake(((ScreenWidth / 3 ) - STWidth(35))/2, STHeight(30.5), STWidth(35), STWidth(35))];
    _showImg.layer.masksToBounds = YES;
    _showImg.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_showImg];
    
    

    _titleLabel = [[UILabel alloc]initWithFont:STFont(17) text:@"" textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    _titleLabel.frame = CGRectMake(0, STHeight(76.5), ScreenWidth / 3, STHeight(16));
    [self.contentView addSubview:_titleLabel];
    
    
}

-(void)setData:(TitleContentModel *)model{
    _titleLabel.text = model.title;
    _showImg.image = [UIImage imageNamed:model.content];
}

+(NSString *)identify{
    return NSStringFromClass([MainCell2 class]);
}

@end
