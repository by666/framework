//
//  SettingCell.m
//  framework
//
//  Created by 黄成实 on 2018/5/16.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "SettingCell.h"
#import "STSwitchView.h"

#define LAST_POSITION 3
@interface SettingCell()

@property(strong, nonatomic)UILabel *titleLabel;
@property(strong, nonatomic)UILabel *contentLabel;
@property(strong, nonatomic)UIImageView *arrowImageView;
@property(strong, nonatomic)STSwitchView *funcSwitch;
@property(strong, nonatomic)UIView *lineView;

@end

@implementation SettingCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}

-(void)initView{
 
    _titleLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentLeft textColor:c16 backgroundColor:nil multiLine:NO];
    _titleLabel.frame = CGRectMake(STWidth(15), STHeight(20),STWidth(100) , STHeight(16));
    [self.contentView addSubview:_titleLabel];
    
    _contentLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentRight textColor:c12 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_contentLabel];
    
    _arrowImageView = [[UIImageView alloc]init];
    _arrowImageView.image = [UIImage imageNamed:@"ic_arrow_right"];
    _arrowImageView.frame = CGRectMake(STWidth(354), STHeight(21), STWidth(7), STHeight(11));
    [self.contentView addSubview:_arrowImageView];
    
    _funcSwitch = [[STSwitchView alloc]init];
    _funcSwitch.frame = CGRectMake(STWidth(318), STHeight(15), STWidth(42), STHeight(26));
    _funcSwitch.on = YES;
    [self.contentView addSubview:_funcSwitch];
    
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = cline;
    _lineView.frame = CGRectMake(STWidth(15), STHeight(54) - LineHeight, ScreenWidth - STWidth(30), LineHeight);
    [self.contentView addSubview:_lineView];
}


-(void)updateData:(TitleContentModel *)model position:(NSInteger)position{
    
    _titleLabel.text = model.title;
    if(IS_NS_STRING_EMPTY(model.content)){
        _funcSwitch.hidden = NO;
        _arrowImageView.hidden = YES;
        _contentLabel.hidden = YES;
        _funcSwitch.on = model.isSwitch;
    }else{
        _funcSwitch.hidden = YES;
        _arrowImageView.hidden = NO;
        _contentLabel.hidden = NO;
        _contentLabel.text = model.content;
        _contentLabel.frame = CGRectMake(ScreenWidth - STWidth(30)-_contentLabel.contentSize.width, STHeight(19),_contentLabel.contentSize.width , STHeight(16));
    }
    
    if(position == LAST_POSITION){
        _lineView.hidden = YES;
    }else{
        _lineView.hidden = NO;
    }
    

}


+(NSString*)identify{
    return NSStringFromClass([SettingCell class]);
}

@end
