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
@property(strong, nonatomic)UILabel *orderTimeLabel;
@property(strong, nonatomic)UIImageView *showImageView;
@property(strong, nonatomic)UILabel *nameLabel;
@property(strong, nonatomic)UILabel *priceLabel;
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
    
    _orderNumLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentLeft textColor:c11 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_orderNumLabel];
    
    _orderTimeLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentRight textColor:c12 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_orderTimeLabel];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.frame = CGRectMake(0, STHeight(50)-LineHeight, ScreenWidth, LineHeight);
    lineView.backgroundColor = cline;
    [self.contentView addSubview:lineView];
    
    _showImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(60), STWidth(44), STHeight(44))];
    _showImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_showImageView];
    
    _nameLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentLeft textColor:c11 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_nameLabel];
    
    _priceLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentLeft textColor:c12 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_priceLabel];

    
    _daysLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentLeft textColor:c12 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_daysLabel];
    
}


-(void)updateData:(DeviceShareHistoryModel *)model{

    NSString *orderNumStr = [NSString stringWithFormat:@"%@：%@",MSG_DEVICESHAREHISTORY_ORDERTITLE,model.orderNum];
    _orderNumLabel.text = orderNumStr;
    CGSize orderNumSize = [orderNumStr sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _orderNumLabel.frame = CGRectMake(STWidth(15), STHeight(16), orderNumSize.width, STHeight(16));
    
    
    _orderTimeLabel.text = model.orderTime;
    CGSize orderTimeSize = [model.orderTime sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _orderTimeLabel.frame = CGRectMake(ScreenWidth - STWidth(15) - orderTimeSize.width, STHeight(16), orderTimeSize.width, STHeight(16));
    
    _showImageView.image = [UIImage imageNamed:model.imageSrc];
    
    
    _nameLabel.text = model.name;
    CGSize nameSize = [model.name sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _nameLabel.frame = CGRectMake(STWidth(74), STHeight(58), nameSize.width, STHeight(16));
    
    NSString *priceStr = [NSString stringWithFormat:@"金额：%@元",model.total];
    _priceLabel.text = priceStr;
    CGSize priceSize = [priceStr sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _priceLabel.frame = CGRectMake(STWidth(74), STHeight(87), priceSize.width, STHeight(16));
    
    NSString *daysStr = [NSString stringWithFormat:@"使用天数：%@天",model.days];
    _daysLabel.text = daysStr;
    CGSize daysSize = [daysStr sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _daysLabel.frame = CGRectMake(ScreenWidth - STWidth(15) - daysSize.width, STHeight(87), daysSize.width, STHeight(16));
}



+(NSString *)identify{
    return NSStringFromClass([DeviceShareHistotyViewCell class]);
}



@end
