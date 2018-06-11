//
//  DeviceShareCell.m
//  framework
//
//  Created by 黄成实 on 2018/6/8.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "DeviceShareCell.h"

@interface DeviceShareCell()

@property(strong, nonatomic)UILabel *nameLabel;
@property(strong, nonatomic)UILabel *priceLabel;
@property(strong, nonatomic)UILabel *briefLabel;
@property(strong, nonatomic)UIImageView *showImageView;


@end

@implementation DeviceShareCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}

-(void)initView{
    
    _showImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(26), STHeight(30),  STHeight(40), STHeight(40))];
    _showImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_showImageView];
    
    _nameLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentLeft textColor:c11 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_nameLabel];
    
    _priceLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentLeft textColor:c20 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_priceLabel];
    
    _briefLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentLeft textColor:c12 backgroundColor:nil multiLine:NO];
    _briefLabel.frame = CGRectMake(STWidth(97), STHeight(59),ScreenWidth - STWidth(164), STHeight(16));
    _briefLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.contentView addSubview:_briefLabel];
    
    UIImageView *arrowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(351), STHeight(64), STWidth(7), STHeight(11))];
    arrowImageView.image = [UIImage imageNamed:@"ic_arrow_right"];
    [self.contentView addSubview:arrowImageView];
    
    _rentBtn = [[UIButton alloc]initWithFont:STFont(16) text:MSG_DEVICESHARE_RENT textColor:c13 backgroundColor:nil corner:STHeight(14) borderWidth:1 borderColor:c13];
    _rentBtn.frame = CGRectMake(STWidth(309), STHeight(10), STWidth(51), STHeight(28));
    [self.contentView addSubview:_rentBtn];
}


-(void)updateData:(DeviceShareModel *)model{
    _showImageView.image = [UIImage imageNamed:model.imageSrc];
    
    CGSize nameSize = [model.name sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _nameLabel.frame = CGRectMake(STWidth(97), STHeight(28), nameSize.width, STHeight(16));
    _nameLabel.text = model.name;
    
    CGSize priceSize = [model.price sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _priceLabel.frame = CGRectMake(STWidth(107) + nameSize.width, STHeight(28), priceSize.width, STHeight(16));
    _priceLabel.text = model.price;
    
    _briefLabel.text = model.brief;
    
    
}


+(NSString *)identify{
    return NSStringFromClass([DeviceShareCell class]);
}
@end
