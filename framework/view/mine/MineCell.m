//
//  MineCell.m
//  framework
//
//  Created by 黄成实 on 2018/5/16.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MineCell.h"

@interface MineCell()

@property(strong, nonatomic)UIImageView *iconImageView;
@property(strong, nonatomic)UILabel *titleLabel;
@property(strong, nonatomic)UIImageView *arrowImageView;

@end

@implementation MineCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}

-(void)initView{
    _iconImageView = [[UIImageView alloc]init];
    _iconImageView.backgroundColor = c01;
    _iconImageView.frame = CGRectMake(STWidth(20), STHeight(18), STHeight(18), STHeight(18));
    [self.contentView addSubview:_iconImageView];
    
    _titleLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentLeft textColor:c16 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_titleLabel];
    
    _arrowImageView = [[UIImageView alloc]init];
    _arrowImageView.backgroundColor = c01;
    _arrowImageView.frame = CGRectMake(STWidth(354), STHeight(21), STWidth(7), STHeight(11));
    [self.contentView addSubview:_arrowImageView];
    
}


-(void)updateData:(NSString *)title{
    _titleLabel.text = title;
    CGSize titleSize = [title sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _titleLabel.frame = CGRectMake(STWidth(58), STHeight(20),titleSize.width , STHeight(16));

}

+(NSString*)identify{
    return NSStringFromClass([MineCell class]);
}


@end
