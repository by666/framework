//
//  VerificateViewCell.m
//  framework
//
//  Created by 黄成实 on 2018/5/31.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "VerificateViewCell.h"
@interface VerificateViewCell()

@property(strong, nonatomic)UILabel *titleLabel;
@property(strong, nonatomic)UILabel *contentLabel;
@property(strong, nonatomic)UIView  *lineView;
@property(strong, nonatomic)UIImageView *headImageView;

@end

@implementation VerificateViewCell

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
    _lineView.backgroundColor = c17;
    [self.contentView addSubview:_lineView];
    
    _headImageView = [[UIImageView alloc]init];
    _headImageView.frame = CGRectMake(ScreenWidth - STWidth(75), STHeight(17), STHeight(60), STHeight(60));
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = STHeight(30);
    _headImageView.hidden = YES;
    _headImageView.image = [UIImage imageNamed:@"ic_test1"];
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_headImageView];
    

    
}


-(void)updateData:(TitleContentModel *)model position:(NSInteger)position{
    _titleLabel.text = model.title;
    _contentLabel.text = model.content;
    _contentLabel.frame = CGRectMake(ScreenWidth - STWidth(14) - _contentLabel.contentSize.width, STHeight(22),_contentLabel.contentSize.width , STHeight(16));
    
    if(position == 0){
        _lineView.frame = CGRectMake(0, STHeight(95)- LineHeight, ScreenWidth, LineHeight);
        _titleLabel.frame = CGRectMake(STWidth(15), STHeight(39),STWidth(100) , STHeight(16));
        _headImageView.hidden = NO;
        if(!IS_NS_STRING_EMPTY(model.content)){
            UIImage *image=[[UIImage alloc]initWithContentsOfFile:model.content];
            _headImageView.image = image;
        }
        _contentLabel.hidden = YES;
        
    }else{
        _lineView.frame = CGRectMake(0, STHeight(60)-LineHeight, ScreenWidth, LineHeight);
        _titleLabel.frame = CGRectMake(STWidth(15), STHeight(19),STWidth(100) , STHeight(16));
        _headImageView.hidden = YES;
        _contentLabel.hidden = NO;
    }
    
}

+(NSString*)identify{
    return NSStringFromClass([VerificateViewCell class]);
}

@end
