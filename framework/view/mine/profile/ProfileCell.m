//
//  ProfileCell.m
//  framework
//
//  Created by 黄成实 on 2018/5/16.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "ProfileCell.h"
#import "AccountManager.h"
@interface ProfileCell()

@property(strong, nonatomic)UILabel *titleLabel;
@property(strong, nonatomic)UILabel *contentLabel;
@property(strong, nonatomic)UIView  *lineView;
@property(strong, nonatomic)UIImageView *headImageView;
@property(strong, nonatomic)UIImageView *arrowImageView;

@end

@implementation ProfileCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}

-(void)initView{

    _titleLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentLeft textColor:c16 backgroundColor:nil multiLine:NO];
    _titleLabel.frame = CGRectMake(STWidth(15), STHeight(19),STWidth(100) , STHeight(16));
    [self.contentView addSubview:_titleLabel];
    
    _contentLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentRight textColor:c12 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_contentLabel];
    
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = c17;
    [self.contentView addSubview:_lineView];
    
    _headImageView = [[UIImageView alloc]init];
    _headImageView.frame = CGRectMake(STWidth(285), STHeight(20), STHeight(50), STHeight(50));
    _headImageView.backgroundColor = cblack;
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = STHeight(25);
    _headImageView.hidden = YES;
    _headImageView.image = [UIImage imageNamed:@"ic_test1"];
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_headImageView];
    
    _arrowImageView = [[UIImageView alloc]init];
    _arrowImageView.frame = CGRectMake(STWidth(350), STHeight(41), STHeight(11), STHeight(11));
    _arrowImageView.image = [UIImage imageNamed:@"ic_arrow_right"];
    _arrowImageView.hidden = YES;
    [self.contentView addSubview:_arrowImageView];
    
}


-(void)updateData:(TitleContentModel *)model position:(NSInteger)position{
    _titleLabel.text = model.title;
    _contentLabel.text = model.content;
    _contentLabel.frame = CGRectMake(ScreenWidth - STWidth(14) - _contentLabel.contentSize.width, STHeight(19),_contentLabel.contentSize.width , STHeight(16));

    if(position == 0){
        _lineView.frame = CGRectMake(STWidth(15), STHeight(89), ScreenWidth - STWidth(30), LineHeight);
        _titleLabel.frame = CGRectMake(STWidth(15), STHeight(37),STWidth(100) , STHeight(16));
        _headImageView.hidden = NO;
        _arrowImageView.hidden = NO;
        if(!IS_NS_STRING_EMPTY(model.content)){
            UserModel *userModel = [[AccountManager sharedAccountManager]getUserModel];
            NSURL *url = [[STUploadImageUtil sharedSTUploadImageUtil] getRealUrl:userModel.headUrl];
            [_headImageView sd_setImageWithURL:url];
        }
        _contentLabel.hidden = YES;

    }else{
        _lineView.frame = CGRectMake(STWidth(15), STHeight(53), ScreenWidth - STWidth(30), LineHeight);
        _titleLabel.frame = CGRectMake(STWidth(15), STHeight(19),STWidth(100) , STHeight(16));
        _headImageView.hidden = YES;
        _arrowImageView.hidden = YES;
        _contentLabel.hidden = NO;
    }
    
    if(position == 4 || position == 7){
        [_lineView setHidden:YES];
    }else{
        [_lineView setHidden:NO];
    }
}

+(NSString*)identify{
    return NSStringFromClass([ProfileCell class]);
}

@end
