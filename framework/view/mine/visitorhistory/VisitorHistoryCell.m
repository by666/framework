//
//  VisitorHistoryCell.m
//  framework
//
//  Created by by.huang on 2018/5/23.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "VisitorHistoryCell.h"
#import "STEdgeLabel.h"

@interface VisitorHistoryCell()

@property(strong, nonatomic)UIImageView *avatarImageView;
@property(strong, nonatomic)UILabel *nameLabel;
@property(strong, nonatomic)UILabel *enterTimeLabel;
@property(strong, nonatomic)UILabel *exitTimeLabel;
@property(strong, nonatomic)UIButton *authBtn;

@end

@implementation VisitorHistoryCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}

-(void)initView{
    
    
    self.contentView.backgroundColor = cwhite;
    
    _avatarImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(15), (STHeight(108) - STWidth(44))/2, STWidth(44), STWidth(44))];
    _avatarImageView.layer.masksToBounds =YES;
    _avatarImageView.layer.cornerRadius = STWidth(22);
    _avatarImageView.image = [UIImage imageNamed:@"ic_head"];
    _avatarImageView.contentMode =UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_avatarImageView];
    
    
    _nameLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentRight textColor:c11 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_nameLabel];
    

    STEdgeLabel *enterTitleLabel = [[STEdgeLabel alloc]initWithFont:STFont(10) text:MSG_VISITORHISTORY_ENTER textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:c32 multiLine:NO];
    enterTitleLabel.layer.masksToBounds = YES;
    enterTitleLabel.layer.cornerRadius = STWidth(8);
    enterTitleLabel.frame = CGRectMake(STWidth(76), STHeight(46), STWidth(16), STWidth(16));
    [self.contentView addSubview:enterTitleLabel];
    
    _enterTimeLabel = [[UILabel alloc]initWithFont:STFont(14) text:@"" textAlignment:NSTextAlignmentCenter textColor:c12 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_enterTimeLabel];
    
    
    STEdgeLabel *exitTitleLabel = [[STEdgeLabel alloc]initWithFont:STFont(10) text:MSG_VISITORHISTORY_EXIT textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:c19 multiLine:NO];
    exitTitleLabel.layer.masksToBounds = YES;
    exitTitleLabel.layer.cornerRadius = STWidth(8);
    exitTitleLabel.frame = CGRectMake(STWidth(76), STHeight(72), STWidth(16), STWidth(16));
    [self.contentView addSubview:exitTitleLabel];
    
    _exitTimeLabel = [[UILabel alloc]initWithFont:STFont(14) text:@"" textAlignment:NSTextAlignmentCenter textColor:c12 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_exitTimeLabel];
    
    
    
    
    _authBtn = [[UIButton alloc]initWithFont:STFont(12) text:MSG_VISITORHISTORY_AUTH textColor:c13 backgroundColor:nil corner:STHeight(5) borderWidth:1 borderColor:c13];
    _authBtn.frame = CGRectMake(ScreenWidth - STWidth(82), STHeight(43), STWidth(66), STHeight(22));
    _authBtn.userInteractionEnabled = NO;
    [self.contentView addSubview:_authBtn];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.frame = CGRectMake(0, STHeight(108)-LineHeight, ScreenWidth, LineHeight);
    lineView.backgroundColor = cline;
    [self.contentView addSubview:lineView];

    
    
}


-(void)updateData:(VisitorHistoryModel *)model{

    _nameLabel.text = model.userName;
    CGSize nameSize = [model.userName sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _nameLabel.frame = CGRectMake(STWidth(76), STHeight(20), nameSize.width, STHeight(16));
    
    NSString *enterStr = [model.occurTime stringByReplacingOccurrencesOfString:@"-" withString:@"."];
    _enterTimeLabel.text = enterStr;
    CGSize enterTimeSize = [enterStr sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(14)]];
    _enterTimeLabel.frame = CGRectMake(STWidth(100), STHeight(46), enterTimeSize.width, STHeight(14));
    
    NSString *exitStr = [model.lastOccurTime stringByReplacingOccurrencesOfString:@"-" withString:@"."];
    if(IS_NS_STRING_EMPTY(exitStr)){
        exitStr = MSG_VISITORHISTORY_UNKNOW;
    }
    _exitTimeLabel.text = exitStr;
    CGSize exitTimeSize = [exitStr sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(14)]];
    _exitTimeLabel.frame = CGRectMake(STWidth(100), STHeight(72), exitTimeSize.width, STHeight(14));
    
    if(!IS_NS_STRING_EMPTY(model.faceUrl)){
        WS(weakSelf)
        [_avatarImageView sd_setImageWithURL:[[STUploadImageUtil sharedSTUploadImageUtil]getRealUrl:model.faceUrl] placeholderImage:[UIImage imageNamed:@"ic_head"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if(error){
                weakSelf.avatarImageView.image = [UIImage imageNamed:@"ic_head"];
            }
        }];
    }
    
    
}



+(NSString *)identify{
    return NSStringFromClass([VisitorHistoryCell class]);
}


@end
