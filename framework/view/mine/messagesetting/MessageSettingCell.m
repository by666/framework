//
//  MessageSettingCell.m
//  framework
//
//  Created by 黄成实 on 2018/5/18.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MessageSettingCell.h"


@interface MessageSettingCell()

@property(strong, nonatomic)UILabel *titleLabel;
@property(strong, nonatomic)UISwitch *funcSwitch;
@property(strong, nonatomic)UIView *lineView;

@end

@implementation MessageSettingCell

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
    
    _funcSwitch = [[UISwitch alloc]init];
    _funcSwitch.frame = CGRectMake(STWidth(318), STHeight(15), STWidth(42), STHeight(26));
    _funcSwitch.on = YES;
    [self.contentView addSubview:_funcSwitch];
    
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = c17;
    _lineView.frame = CGRectMake(STWidth(15), STHeight(56), ScreenWidth - STWidth(30), 1);
    [self.contentView addSubview:_lineView];
}


-(void)updateData:(NSString *)title{
    _titleLabel.text = title;
    
}


+(NSString*)identify{
    return NSStringFromClass([MessageSettingCell class]);
}
@end
