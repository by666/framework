//
//  UserInfoCell.m
//  framework
//
//  Created by 黄成实 on 2018/8/14.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "UserInfoCell.h"

@interface UserInfoCell()
@property(strong, nonatomic)UILabel *titleLabel;
@property(strong, nonatomic)UILabel *contentLabel;
@property(strong, nonatomic)UIView  *lineView;
@property(strong, nonatomic)UIImageView *headImageView;

@end

@implementation UserInfoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}

-(void)initView{
    
    _titleLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentLeft textColor:c16 backgroundColor:nil multiLine:NO];
    _titleLabel.frame = CGRectMake(STWidth(15), STHeight(22),STWidth(100) , STHeight(16));
    [self.contentView addSubview:_titleLabel];
    
    _contentLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentRight textColor:c12 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_contentLabel];
    
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = cline;
    [self.contentView addSubview:_lineView];
    
    _headImageView = [[UIImageView alloc]init];
    _headImageView.frame = CGRectMake(ScreenWidth - STWidth(90), (STHeight(96) - STWidth(75))/2, STWidth(75), STWidth(75));
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = STHeight(37.5);
    _headImageView.hidden = YES;
    _headImageView.image = [UIImage imageNamed:@"ic_head"];
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_headImageView];
    
    
    
}


-(void)updateData:(TitleContentModel *)model position:(NSInteger)position{
    _titleLabel.text = model.title;
    if(!IS_NS_STRING_EMPTY(model.content)){
        _contentLabel.text = model.content;
    }
    _contentLabel.frame = CGRectMake(ScreenWidth - STWidth(14) - _contentLabel.contentSize.width, STHeight(22),_contentLabel.contentSize.width , STHeight(16));
    
    if(position == 0){
        _lineView.frame = CGRectMake(0, STHeight(96)- LineHeight, ScreenWidth, LineHeight);
        _titleLabel.frame = CGRectMake(STWidth(15), STHeight(40),STWidth(100) , STHeight(16));
        _headImageView.hidden = NO;
        if(!IS_NS_STRING_EMPTY(model.content)){
            [_headImageView sd_setImageWithURL:[[STUploadImageUtil sharedSTUploadImageUtil]getRealUrl:model.content] placeholderImage:[UIImage imageNamed:@"ic_head"]];
        }
        _contentLabel.hidden = YES;
        
    }else{
        _lineView.frame = CGRectMake(0, STHeight(60)-LineHeight, ScreenWidth, LineHeight);
        _titleLabel.frame = CGRectMake(STWidth(15), STHeight(20),STWidth(100) , STHeight(16));
        _headImageView.hidden = YES;
        _contentLabel.hidden = NO;
    }
    
    if(position == 4){
        _lineView.hidden = YES;
    }else{
        _lineView.hidden = NO;
    }
    
}

+(NSString*)identify{
    return NSStringFromClass([UserInfoCell class]);
}

@end
