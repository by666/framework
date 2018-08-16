//
//  MemberCell.m
//  framework
//
//  Created by 黄成实 on 2018/5/17.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MemberCell.h"
#import "STEdgeLabel.h"
@interface MemberCell()

@property(strong, nonatomic)UIImageView *headImageView;
@property(strong, nonatomic)UILabel *titleLabel;
@property(strong, nonatomic)STEdgeLabel *idetifyLabel;
@property(strong, nonatomic)UIImageView *arrowImageView;

@end

@implementation MemberCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}

-(void)initView{
    _headImageView = [[UIImageView alloc]init];
    _headImageView.frame = CGRectMake(STWidth(15), (STHeight(84) - STWidth(44))/2, STWidth(44), STWidth(44));
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = STWidth(22);
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_headImageView];
    
    _titleLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentCenter textColor:c16 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_titleLabel];
    
    _idetifyLabel = [[STEdgeLabel alloc]initWithFont:STFont(10) text:@"" textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:c19 multiLine:NO];
    _idetifyLabel.layer.masksToBounds = YES;
    _idetifyLabel.layer.cornerRadius = STWidth(10);
    _idetifyLabel.clipsToBounds = YES;
    [self.contentView addSubview:_idetifyLabel];
    
    _arrowImageView = [[UIImageView alloc]init];
    [_arrowImageView setImage:[UIImage imageNamed:@"ic_arrow_right"]];
    _arrowImageView.frame = CGRectMake(ScreenWidth - STWidth(33), STHeight(35.5), STWidth(13), STHeight(13));
    [self.contentView addSubview:_arrowImageView];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.frame = CGRectMake(0, STHeight(84) - LineHeight, ScreenWidth,LineHeight);
    lineView.backgroundColor = cline;
    [self.contentView addSubview:lineView];
}


-(void)updateData:(MemberModel *)model{
    
    _titleLabel.text = model.nickname;
    CGSize titleSize = [STPUtil textSize:model.nickname maxWidth:ScreenWidth font:STFont(16)];

    if(!IS_NS_STRING_EMPTY(model.identify)){
        _idetifyLabel.hidden = NO;
        _idetifyLabel.text = model.identify;
        _titleLabel.frame = CGRectMake(STWidth(75), STHeight(19),titleSize.width , STHeight(16));
        _idetifyLabel.frame = CGRectMake(STWidth(75), STHeight(45),STWidth(54), STWidth(20));
        _arrowImageView.hidden = YES;
    }else{
        _idetifyLabel.hidden = YES;
        _arrowImageView.hidden = NO;
        _titleLabel.frame = CGRectMake(STWidth(75), STHeight(34.5),titleSize.width , STHeight(16));
    }
    
    [_headImageView sd_setImageWithURL:[[STUploadImageUtil sharedSTUploadImageUtil]getRealUrl:model.faceUrl] placeholderImage:[UIImage imageNamed:@"ic_default"]];
 
}

+(NSString*)identify{
    return NSStringFromClass([MemberCell class]);
}


@end
