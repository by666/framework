//
//  MemberCell.m
//  framework
//
//  Created by 黄成实 on 2018/5/17.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MemberCell.h"
#import "STEdgeLabel.h"
@interface MemberCell()

@property(strong, nonatomic)UIImageView *headImageView;
@property(strong, nonatomic)UILabel *titleLabel;
@property(strong, nonatomic)STEdgeLabel *idetifyLabel;
@property(strong, nonatomic)UIImageView *arrowImageView;

@end

@implementation MemberCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}

-(void)initView{
    _headImageView = [[UIImageView alloc]init];
    _headImageView.backgroundColor = c01;
    _headImageView.frame = CGRectMake(STWidth(15), STHeight(14.5), STHeight(30), STHeight(30));
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = STHeight(15);
    _headImageView.image = [UIImage imageNamed:@"ic_test1"];
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_headImageView];
    
    _titleLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentLeft textColor:c16 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_titleLabel];
    
    _idetifyLabel = [[STEdgeLabel alloc]initWithFont:STFont(10) text:@"" textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:c19 multiLine:NO];
    _idetifyLabel.layer.masksToBounds = YES;
    _idetifyLabel.layer.cornerRadius = STHeight(9);
    [self.contentView addSubview:_idetifyLabel];
    
    _arrowImageView = [[UIImageView alloc]init];
    [_arrowImageView setImage:[UIImage imageNamed:@"ic_arrow_right"]];
    _arrowImageView.frame = CGRectMake(STWidth(350), STHeight(21), STWidth(11), STHeight(11));
    [self.contentView addSubview:_arrowImageView];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.frame = CGRectMake(0, STHeight(58.5), ScreenWidth,LineHeight);
    lineView.backgroundColor = c17;
    [self.contentView addSubview:lineView];
}


-(void)updateData:(MemberModel *)model{
    
    _titleLabel.text = model.nickname;
    _titleLabel.frame = CGRectMake(STWidth(60), STHeight(21.5),[STPUtil textSize:model.nickname maxWidth:ScreenWidth font:STFont(16)].width , STHeight(16));

    if(!IS_NS_STRING_EMPTY(model.identify)){
        _idetifyLabel.hidden = NO;
        _idetifyLabel.text = model.identify;
        _idetifyLabel.frame = CGRectMake(STWidth(120), STHeight(20.5),_idetifyLabel.contentSize.width + STWidth(8), STHeight(18));
        _arrowImageView.hidden = YES;
    }else{
        _idetifyLabel.hidden = YES;
        _arrowImageView.hidden = NO;
    }
 
}

+(NSString*)identify{
    return NSStringFromClass([MemberCell class]);
}


@end
