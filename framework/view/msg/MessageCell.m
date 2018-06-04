//
//  MessageCell.m
//  framework
//
//  Created by 黄成实 on 2018/5/30.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MessageCell.h"

@interface MessageCell()

@property(strong, nonatomic)UIImageView *headImageView;
@property(strong, nonatomic)UILabel *titleLabel;
@property(strong, nonatomic)UILabel *subTitleLabel;
@property(strong, nonatomic)UILabel *timeLabel;
@property(strong, nonatomic)UILabel *statuLabel;
@property(strong, nonatomic)UILabel *warnLabel;

@end

@implementation MessageCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}

-(void)initView{
    
    _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(20), STHeight(28), STWidth(26), STHeight(26))];
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_headImageView];
    
    _titleLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentLeft textColor:c11 backgroundColor:nil multiLine:NO];
    _titleLabel.frame = CGRectMake(STWidth(66), STHeight(22), ScreenWidth - STWidth(66), STHeight(16));
    [self.contentView addSubview:_titleLabel];
    
    _subTitleLabel = [[UILabel alloc]initWithFont:STFont(14) text:@"" textAlignment:NSTextAlignmentLeft textColor:c12 backgroundColor:nil multiLine:NO];
    _subTitleLabel.frame = CGRectMake(STWidth(66), STHeight(46), ScreenWidth - STWidth(66+72), STHeight(14));
    _subTitleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.contentView addSubview:_subTitleLabel];
    
    _timeLabel = [[UILabel alloc]initWithFont:STFont(14) text:@"" textAlignment:NSTextAlignmentLeft textColor:c12 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_timeLabel];
    
    _statuLabel = [[UILabel alloc]initWithFont:STFont(14) text:@"" textAlignment:NSTextAlignmentLeft textColor:c09 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_statuLabel];
    
    _warnLabel = [[UILabel alloc]initWithFont:STFont(12) text:@"!" textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:c18 multiLine:NO];
    _warnLabel.layer.masksToBounds = YES;
    _warnLabel.layer.cornerRadius = STHeight(6);
    _warnLabel.frame = CGRectMake(STWidth(35), STHeight(26), STHeight(12), STHeight(12));
    [self.contentView addSubview:_warnLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(82)-LineHeight, ScreenWidth, LineHeight)];
    lineView.backgroundColor = c17;
    [self.contentView addSubview:lineView];
}


-(void)updateData:(MessageModel *)model{
    _titleLabel.text = model.title;
    _subTitleLabel.text = model.subTitle;
    
    _timeLabel.text = model.timestamp;
    CGSize timeSize = [model.timestamp sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(14)]];
    _timeLabel.frame = CGRectMake(ScreenWidth - timeSize.width -  STWidth(14), STHeight(12), timeSize.width, STHeight(14));
    
    NSString *statuStr = [MessageModel translateStatu:model.messageStatu];
    _statuLabel.text = statuStr;
    CGSize statuSize = [statuStr sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(14)]];
    _statuLabel.frame = CGRectMake(ScreenWidth - statuSize.width -  STWidth(14), STHeight(38), statuSize.width, STHeight(14));

    if(model.messageType == UserAuth){
        _headImageView.image = [UIImage imageNamed:@"ic_authuser_msg"];
    }else if(model.messageType == VisitorEnter || model.messageType == CarEnter){
        _headImageView.image = [UIImage imageNamed:@"ic_visitor_msg"];
    }
    
    if(model.messageStatu == Reject){
        self.contentView.backgroundColor = c15;
    }else{
        self.contentView.backgroundColor = cwhite;
    }
    
    if(model.messageStatu == DefaultStatu){
        _warnLabel.hidden = NO;
    }else{
        _warnLabel.hidden = YES;
    }
}




+(NSString*)identify{
    return NSStringFromClass([MessageCell class]);
}

@end
