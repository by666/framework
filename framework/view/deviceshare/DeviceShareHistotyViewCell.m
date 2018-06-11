//
//  DeviceShareHistotyViewCell.m
//  framework
//
//  Created by 黄成实 on 2018/6/11.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "DeviceShareHistotyViewCell.h"

@interface DeviceShareHistotyViewCell()

@property(strong, nonatomic)UILabel *orderNumLabel;
@property(strong, nonatomic)UILabel *orderStatuLabel;
@property(strong, nonatomic)UIImageView *showImageView;
@property(strong, nonatomic)UILabel *nameLabel;
@property(strong, nonatomic)UILabel *priceLabel;
@property(strong, nonatomic)UILabel *totalLabel;
@property(strong, nonatomic)UILabel *daysLabel;

@end

@implementation DeviceShareHistotyViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}

-(void)initView{
    
    UILabel *orderTitleLabel = [[UILabel alloc]initWithFont:STFont(16) text:MSG_DEVICESHAREHISTORY_ORDERTITLE textAlignment:NSTextAlignmentLeft textColor:c16 backgroundColor:nil multiLine:NO];
    CGSize orderTitleSize = [MSG_DEVICESHAREHISTORY_ORDERTITLE sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    orderTitleLabel.frame = CGRectMake(STWidth(15), STHeight(12), orderTitleSize.width, STHeight(16));
    [self.contentView addSubview:orderTitleLabel];
    
    _orderNumLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentLeft textColor:c12 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_orderNumLabel];
    
    _orderStatuLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentRight textColor:c12 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_orderStatuLabel];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.frame = CGRectMake(0, STHeight(40), ScreenWidth, LineHeight);
    lineView.backgroundColor = c17;
    [self.contentView addSubview:lineView];
    
    _showImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(26), STHeight(60), STWidth(40), STHeight(40))];
    _showImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_showImageView];
    
    _nameLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentLeft textColor:c11 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_nameLabel];
    
    _priceLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentLeft textColor:c12 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_priceLabel];
    
    _totalLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentLeft textColor:c12 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_totalLabel];
    
    _daysLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentLeft textColor:c12 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_daysLabel];
    
}


-(void)updateData:(DeviceShareHistoryModel *)model{

    _orderNumLabel.text = model.orderNum;
    CGSize orderNumSize = [model.orderNum sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _orderNumLabel.frame = CGRectMake(STWidth(85), STHeight(12), orderNumSize.width, STHeight(16));
    
    _orderStatuLabel.text = model.orderStatu;
    CGSize orderStatuSize = [model.orderNum sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _orderStatuLabel.frame = CGRectMake(ScreenWidth - STWidth(15) - orderStatuSize.width, STHeight(12), orderStatuSize.width, STHeight(16));
    
    _showImageView.image = [UIImage imageNamed:model.imageSrc];
    
    
    _nameLabel.text = model.name;
    CGSize nameSize = [model.name sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _nameLabel.frame = CGRectMake(STWidth(96), STHeight(58), nameSize.width, STHeight(16));
    
    NSString *priceStr = [NSString stringWithFormat:@"%@元/天",model.price];
    _priceLabel.text = priceStr;
    CGSize priceSize = [priceStr sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _priceLabel.frame = CGRectMake(STWidth(159), STHeight(58), priceSize.width, STHeight(16));
    
    
    NSString *totalStr = [NSString stringWithFormat:@"金额：%@",model.total];
    _totalLabel.text = totalStr;
    CGSize totalSize = [totalStr sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _totalLabel.frame = CGRectMake(STWidth(97), STHeight(87), totalSize.width, STHeight(16));
    
    NSString *daysStr = [NSString stringWithFormat:@"使用天数：%@天",model.days];
    _daysLabel.text = daysStr;
    CGSize daysSize = [daysStr sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _daysLabel.frame = CGRectMake(STWidth(211), STHeight(87), daysSize.width, STHeight(16));
}



+(NSString *)identify{
    return NSStringFromClass([DeviceShareHistotyViewCell class]);
}



@end
