//
//  PropertyMsgCell.m
//  framework
//
//  Created by 黄成实 on 2018/6/1.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "PropertyMsgCell.h"


@interface PropertyMsgCell()

@property(strong, nonatomic)UILabel *titleLabel;
@property(strong, nonatomic)UILabel *timeLabel;
@property(strong, nonatomic)UIView *bodyView;
@property(strong, nonatomic)UIImageView *showImageView;

@end

@implementation PropertyMsgCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}

-(void)initView{
    self.backgroundColor = c15;
    
    
    _bodyView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(15), 0, ScreenWidth - STWidth(30), STHeight(263))];
    _bodyView.backgroundColor = cwhite;
    _bodyView.layer.masksToBounds = YES;
    _bodyView.layer.cornerRadius = 10;
    [self.contentView addSubview:_bodyView];
    
    _titleLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentLeft textColor:c11 backgroundColor:nil multiLine:YES];
    _titleLabel.frame = CGRectMake(STWidth(20), STHeight(12), ScreenWidth - STWidth(70), STHeight(16));
    _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [_bodyView addSubview:_titleLabel];
    
    _timeLabel = [[UILabel alloc]initWithFont:STFont(14) text:@"" textAlignment:NSTextAlignmentLeft textColor:c12 backgroundColor:nil multiLine:YES];
    _timeLabel.frame = CGRectMake(STWidth(20), STHeight(40), ScreenWidth - STWidth(70), STHeight(14));
    [_bodyView addSubview:_timeLabel];

    
    _showImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(23), STHeight(69), STWidth(299), STHeight(150))];
    _showImageView.image = [UIImage imageNamed:@"test"];
    _showImageView.layer.masksToBounds = YES;
    _showImageView.layer.cornerRadius = 4;
    [_bodyView addSubview:_showImageView];
    
    UILabel  *detailLabel = [[UILabel alloc]initWithFont:STFont(14) text:MSG_PROPERTYMSG_DETAIL textAlignment:NSTextAlignmentLeft textColor:c12 backgroundColor:nil multiLine:YES];
    detailLabel.frame = CGRectMake(STWidth(20), STHeight(230), ScreenWidth - STWidth(70), STHeight(14));
    [_bodyView addSubview:detailLabel];
    
    UIImageView *arrowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth - STWidth(60) , STHeight(230),STWidth(7), STHeight(11))];
    arrowImageView.image = [UIImage imageNamed:@"ic_arrow_right"];
    arrowImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_bodyView addSubview:arrowImageView];

}

-(void)updateData:(PropertyMsgModel *)model{
    _titleLabel.text = model.title;
    _timeLabel.text = model.timeStamp;
}

+(NSString *)identify{
    return NSStringFromClass([PropertyMsgCell class]);
}
@end
