//
//  HabitantCell.m
//  framework
//
//  Created by 黄成实 on 2018/5/18.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "HabitantCell.h"
#import "STEdgeLabel.h"

@interface HabitantCell()

@property(strong, nonatomic)UIImageView *headImageView;
@property(strong, nonatomic)UILabel *titleLabel;
@property(strong, nonatomic)STEdgeLabel *idetifyLabel;
@property(strong, nonatomic)UIImageView *arrowImageView;
@property(strong, nonatomic)UILabel *validDateTitleLabel;
@property(strong, nonatomic)UILabel *validDateLabel;

@end

@implementation HabitantCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}

-(void)initView{
    _headImageView = [[UIImageView alloc]init];
    _headImageView.backgroundColor = c01;
    _headImageView.frame = CGRectMake(STWidth(15), STHeight(15), STHeight(30), STHeight(30));
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = STHeight(15);
    [self.contentView addSubview:_headImageView];
    
    _titleLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentLeft textColor:c16 backgroundColor:nil multiLine:NO];
    _titleLabel.frame = CGRectMake(STWidth(55), STHeight(21), STWidth(100), STHeight(16));
    [self.contentView addSubview:_titleLabel];
    
    _idetifyLabel = [[STEdgeLabel alloc]initWithFont:STFont(10) text:@"" textAlignment:NSTextAlignmentCenter textColor:c19 backgroundColor:nil multiLine:NO];
    _idetifyLabel.layer.borderColor = [c19 CGColor];
    _idetifyLabel.layer.borderWidth = STHeight(1);
    _idetifyLabel.layer.masksToBounds = YES;
    _idetifyLabel.layer.cornerRadius = STHeight(9);
    [self.contentView addSubview:_idetifyLabel];
    
    _validDateTitleLabel = [[UILabel alloc]initWithFont:STFont(12) text:@"有效期至" textAlignment:NSTextAlignmentLeft textColor:c12 backgroundColor:nil multiLine:NO];
    _validDateTitleLabel.frame = CGRectMake(STWidth(297), STHeight(14), STWidth(60), STHeight(12));
    [self.contentView addSubview:_validDateTitleLabel];
    
    
    _validDateLabel  = [[UILabel alloc]initWithFont:STFont(12) text:@"" textAlignment:NSTextAlignmentLeft textColor:c12 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_validDateLabel];
    
    _arrowImageView = [[UIImageView alloc]init];
    _arrowImageView.backgroundColor = c01;
    _arrowImageView.frame = CGRectMake(STWidth(354), STHeight(21), STWidth(7), STHeight(11));
    [self.contentView addSubview:_arrowImageView];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.frame = CGRectMake(0, STHeight(59), ScreenWidth, STHeight(1));
    lineView.backgroundColor = c17;
    [self.contentView addSubview:lineView];
}


-(void)updateData:(HabitantModel *)model{

    _titleLabel.text = model.name;
    _validDateLabel.text = model.validDate;
    CGSize size = [STPUtil textSize:model.validDate maxWidth:ScreenWidth font:STFont(12)];
    _validDateLabel.frame = CGRectMake(ScreenWidth - STWidth(26) -size.width, STHeight(32), size.width, STHeight(12));

    if(!IS_NS_STRING_EMPTY(model.identify)){
        _idetifyLabel.hidden = NO;
        _idetifyLabel.text = model.identify;
        _idetifyLabel.frame = CGRectMake(_titleLabel.contentSize.width + STWidth(55 + 12), STHeight(21),_idetifyLabel.contentSize.width + STWidth(8), STHeight(18));
    }else{
        _idetifyLabel.hidden = YES;
    }
    
}



+(NSString *)identify{
    return NSStringFromClass([HabitantCell class]);
}
@end
