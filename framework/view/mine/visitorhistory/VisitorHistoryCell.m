//
//  VisitorHistoryCell.m
//  framework
//
//  Created by by.huang on 2018/5/23.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "VisitorHistoryCell.h"

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
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(STWidth(15), 0, ScreenWidth - STWidth(30), STHeight(100))];
    view.backgroundColor = cwhite;
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = STHeight(6);
    [self.contentView addSubview:view];
    
    _avatarImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(15), (STHeight(100) - STWidth(60))/2, STWidth(60), STWidth(60))];
    _avatarImageView.backgroundColor = cblack;
    _avatarImageView.layer.masksToBounds =YES;
    _avatarImageView.layer.cornerRadius = STWidth(30);
    _avatarImageView.image = [UIImage imageNamed:@"ic_test1"];
    _avatarImageView.contentMode =UIViewContentModeScaleAspectFill;
    [view addSubview:_avatarImageView];
    
    
    _nameLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentRight textColor:c16 backgroundColor:nil multiLine:NO];
    [view addSubview:_nameLabel];
    

    _enterTimeLabel = [[UILabel alloc]initWithFont:STFont(12) text:@"" textAlignment:NSTextAlignmentCenter textColor:c12 backgroundColor:nil multiLine:NO];
    [view addSubview:_enterTimeLabel];
    
    _exitTimeLabel = [[UILabel alloc]initWithFont:STFont(12) text:@"" textAlignment:NSTextAlignmentCenter textColor:c12 backgroundColor:nil multiLine:NO];
    [view addSubview:_exitTimeLabel];
    
    
    _authBtn = [[UIButton alloc]initWithFont:STFont(12) text:MSG_VISITORHISTORY_AUTH textColor:c13 backgroundColor:nil corner:STHeight(5) borderWidth:1 borderColor:c13];
    _authBtn.frame = CGRectMake(STWidth(265), STHeight(15), STWidth(65), STHeight(20));
    _authBtn.userInteractionEnabled = NO;
    [view addSubview:_authBtn];

    
    
}


-(void)updateData:(VisitorHistoryModel *)model{

    _nameLabel.text = model.name;
    CGSize nameSize = [model.name sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _nameLabel.frame = CGRectMake(STWidth(89), STHeight(20), nameSize.width, STHeight(16));
    
    NSString *enterStr = [NSString stringWithFormat:MSG_VISITORHOME_ENTER_TIME,model.enterTime];
    _enterTimeLabel.text = enterStr;
    CGSize enterTimeSize = [enterStr sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(12)]];
    _enterTimeLabel.frame = CGRectMake(STWidth(89), STHeight(44), enterTimeSize.width, STHeight(12));
    
    NSString *exitStr = [NSString stringWithFormat:MSG_VISITORHOME_EXIT_TIME,model.exitTime];
    _exitTimeLabel.text = exitStr;
    CGSize exitTimeSize = [exitStr sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(12)]];
    _exitTimeLabel.frame = CGRectMake(STWidth(89), STHeight(63), exitTimeSize.width, STHeight(12));
    
    
}



+(NSString *)identify{
    return NSStringFromClass([VisitorHistoryCell class]);
}


@end
