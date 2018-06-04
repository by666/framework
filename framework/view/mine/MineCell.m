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
@property(strong, nonatomic)UIView *lineView;

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
    _iconImageView.frame = CGRectMake(STWidth(20), STHeight(18), STHeight(18), STHeight(18));
    [self.contentView addSubview:_iconImageView];
    
    _titleLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentLeft textColor:c16 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_titleLabel];
    
    _arrowImageView = [[UIImageView alloc]init];
    _arrowImageView.image = [UIImage imageNamed:@"ic_arrow_right"];
    _arrowImageView.frame = CGRectMake(STWidth(354), STHeight(21), STWidth(7), STHeight(11));
    [self.contentView addSubview:_arrowImageView];
    
    _lineView = [[UIView alloc]init];
    _lineView.frame = CGRectMake(STWidth(20), STHeight(54) - LineHeight, ScreenWidth-STWidth(35), LineHeight);
    _lineView.backgroundColor = c17;
    [self.contentView addSubview:_lineView];
    
}


-(void)updateData:(NSString *)title image:(UIImage *)image hidden:(Boolean)hidden{
    _titleLabel.text = title;
    CGSize titleSize = [title sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _titleLabel.frame = CGRectMake(STWidth(58), STHeight(20),titleSize.width , STHeight(16));
    
    _iconImageView.image = image;
    _lineView.hidden  = hidden;

}

+(NSString*)identify{
    return NSStringFromClass([MineCell class]);
}


@end
