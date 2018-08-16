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
    _iconImageView.frame = CGRectMake(STWidth(15), STHeight(18), STHeight(18), STHeight(18));
    [self.contentView addSubview:_iconImageView];
    
    _titleLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_titleLabel];
    
    _arrowImageView = [[UIImageView alloc]init];
    _arrowImageView.image = [UIImage imageNamed:@"ic_arrow_right"];
    _arrowImageView.frame = CGRectMake(ScreenWidth - STWidth(33), STHeight(21.5), STWidth(13), STHeight(13));
    [self.contentView addSubview:_arrowImageView];
    
    _lineView = [[UIView alloc]init];
    _lineView.frame = CGRectMake(0, STHeight(56) - LineHeight, ScreenWidth, LineHeight);
    _lineView.backgroundColor = cline;
    [self.contentView addSubview:_lineView];
    
}


-(void)updateData:(NSString *)title image:(UIImage *)image hidden:(Boolean)hidden{
    _titleLabel.text = title;
    
    _iconImageView.image = image;
    _lineView.hidden  = hidden;
    
    if(image == nil){
        _iconImageView.hidden = YES;
        _arrowImageView.hidden = YES;
        _titleLabel.frame = CGRectMake(0, 0, ScreenWidth, STHeight(56));
        _titleLabel.textColor = c12;
        
    }else{
        CGSize titleSize = [title sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
        _titleLabel.frame = CGRectMake(STWidth(50), 0,titleSize.width , STHeight(56));
        _iconImageView.hidden = NO;
        _titleLabel.textColor = c11;
        _arrowImageView.hidden = NO;
    }
}

+(NSString*)identify{
    return NSStringFromClass([MineCell class]);
}


@end
