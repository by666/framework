//
//  SystemMsgCell.m
//  framework
//
//  Created by 黄成实 on 2018/6/1.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "SystemMsgCell.h"
@interface SystemMsgCell()

@property(strong, nonatomic)UILabel *timeLabel;
@property(strong, nonatomic)UILabel *titleLabel;
@property(strong, nonatomic)UILabel *contentLabel;
@property(strong, nonatomic)UIView *bodyView;

@end

@implementation SystemMsgCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}

-(void)initView{
    self.backgroundColor = c15;
    
    _timeLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentCenter textColor:c12 backgroundColor:nil multiLine:NO];
    _timeLabel.frame = CGRectMake(0, 0, ScreenWidth, STHeight(38));
    _timeLabel.backgroundColor = c15;
    [self.contentView addSubview:_timeLabel];
    
    _bodyView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(38), ScreenWidth - STWidth(30), STHeight(70))];
    _bodyView.backgroundColor = cwhite;
    _bodyView.layer.masksToBounds = YES;
    _bodyView.layer.cornerRadius = 10;
    [self.contentView addSubview:_bodyView];
    
    _titleLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentLeft textColor:c11 backgroundColor:nil multiLine:YES];
    [_bodyView addSubview:_titleLabel];
    
    _contentLabel = [[UILabel alloc]initWithFont:STFont(14) text:@"" textAlignment:NSTextAlignmentLeft textColor:c12 backgroundColor:nil multiLine:YES];
    [_bodyView addSubview:_contentLabel];
}

-(void)updateData:(SystemMsgModel *)model{
    _timeLabel.text = model.timeStamp;
    
    CGSize titleSize = [model.title sizeWithMaxWidth:ScreenWidth - STWidth(70) font:[UIFont systemFontOfSize:STFont(16)]];
    _titleLabel.frame = CGRectMake(STWidth(20), STHeight(12), ScreenWidth - STWidth(70), titleSize.height);
    _titleLabel.text = model.title;
    
    
    CGSize contentSize = [model.content sizeWithMaxWidth:ScreenWidth - STWidth(70) font:[UIFont systemFontOfSize:STFont(14)]];
    _contentLabel.frame = CGRectMake(STWidth(20), STHeight(22) + titleSize.height, ScreenWidth - STWidth(70), contentSize.height);
    _contentLabel.text = model.content;
    
    _bodyView.frame =CGRectMake(STWidth(15), STHeight(38), ScreenWidth - STWidth(30), model.height - STHeight(38));

}

+(NSString *)identify{
    return NSStringFromClass([SystemMsgCell class]);
}
@end
