//
//  MessageCell.m
//  framework
//
//  Created by 黄成实 on 2018/5/30.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MessageCell.h"
#import "STTimeUtil.h"
#import "AccountManager.h"

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
    
    _titleLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentLeft textColor:c11 backgroundColor:nil multiLine:YES];
    [self.contentView addSubview:_titleLabel];
    
    _subTitleLabel = [[UILabel alloc]initWithFont:STFont(14) text:@"" textAlignment:NSTextAlignmentLeft textColor:c12 backgroundColor:nil multiLine:YES];
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
    lineView.backgroundColor = cline;
    [self.contentView addSubview:lineView];
}


-(void)updateData:(MessageModel *)model{
    
    NSString *timeStr = [model.createTime substringWithRange:NSMakeRange(5, model.createTime.length-5)];
    timeStr = [timeStr substringWithRange:NSMakeRange(0, timeStr.length-3)];
    _timeLabel.text = timeStr;
    CGSize timeSize = [timeStr sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(14)]];
    _timeLabel.frame = CGRectMake(ScreenWidth - timeSize.width -  STWidth(14), STHeight(12), timeSize.width, STHeight(14));
    
    NSString *statuStr = [MessageModel translateStatu:model.applyState overdueDate:model.overdueDate];
    _statuLabel.text = statuStr;
    CGSize statuSize = [statuStr sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(14)]];
    _statuLabel.frame = CGRectMake(ScreenWidth - statuSize.width -  STWidth(14), STHeight(38), statuSize.width, STHeight(14));

    MessageType messageType = [MessageModel translateType:model.applyType];
    if(messageType == UserAuth){
        UserModel *userModel = [[AccountManager sharedAccountManager]getUserModel];
        _headImageView.image = [UIImage imageNamed:@"消息中心_icon_用户认证请求"];
        if([model.receiverUid isEqualToString:userModel.userUid]){
            _titleLabel.text = MSG_MESSAGE_USERAUTH_TITLE;
            _subTitleLabel.text = [NSString stringWithFormat:MSG_MESSAGE_USERAUTH_CONTENT,model.userName,[STPUtil getLiveAttr:model.applyType]];
        }else{
            _statuLabel.text = @"";
            if(model.applyState == 1){
                _titleLabel.text = MSG_MESSAGE_AUTH_RESULT_SUCCESS;
                _subTitleLabel.text = MSG_MESSAGE_AUTH_RESULT_SUCCESS_CONTENT;
            }else if(model.applyState == 2){
                _titleLabel.text = MSG_MESSAGE_AUTH_RESULT_FAIL;
                NSMutableAttributedString *nameStr=[[NSMutableAttributedString alloc]initWithString:MSG_MESSAGE_AUTH_RESULT_FAIL_CONTENT];
                NSRange range=[[nameStr string]rangeOfString:@"重新认证>>>"];
                [nameStr addAttribute:NSForegroundColorAttributeName value:c01 range:range];
                _subTitleLabel.attributedText = nameStr;
            }
        }

    }else if(messageType == VisitorEnter || messageType == CarEnter){
        _titleLabel.text = MSG_MESSAGE_VISITOR_TITLE;
        _headImageView.image = [UIImage imageNamed:@"消息中心_icon_访客门禁申请有效"];
        _subTitleLabel.text = [NSString stringWithFormat:MSG_MESSAGE_VISITOR_CONTENT,model.userName];
    }
    
    CGSize subTitleSize = [_subTitleLabel.text sizeWithMaxWidth:ScreenWidth - STWidth(138) font:[UIFont systemFontOfSize:STFont(14)]];
    if(subTitleSize.height > STHeight (28)){
        _titleLabel.frame = CGRectMake(STWidth(66), STHeight(12), ScreenWidth - STWidth(66), STHeight(16));
        _subTitleLabel.frame = CGRectMake(STWidth(66), STHeight(36), ScreenWidth - STWidth(138),subTitleSize.height);
    }else{
        _titleLabel.frame = CGRectMake(STWidth(66), STHeight(22), ScreenWidth - STWidth(66), STHeight(16));
        _subTitleLabel.frame = CGRectMake(STWidth(66), STHeight(46), ScreenWidth - STWidth(138),subTitleSize.height);

    }
  
    if([self isVaildDate:model.overdueDate]){
        _statuLabel.textColor = c09;
    }else{
        _statuLabel.textColor = c07;
    }
    
    MessageStatu statu = model.applyState;
    if(statu == DefaultStatu){
        _warnLabel.hidden = NO;
    }else{
        _warnLabel.hidden = YES;
    }
}


-(Boolean)isVaildDate:(NSString *)overdueDate{
    long nowTimeStamp = [[STTimeUtil getCurrentTimeStamp] longLongValue] / 1000;
    NSString *formatDateStr = overdueDate;
    long visitTimeStamp = [STTimeUtil getTimeStamp:formatDateStr format:@"yyyy-MM-dd HH:mm:ss"];
    if(visitTimeStamp - nowTimeStamp >= 0){
        return YES;
    }
    return NO;
}



+(NSString*)identify{
    return NSStringFromClass([MessageCell class]);
}

@end
