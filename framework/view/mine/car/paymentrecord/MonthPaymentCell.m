//
//  MonthPaymentCell.m
//  framework
//
//  Created by 黄成实 on 2018/5/22.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MonthPaymentCell.h"

@interface MonthPaymentCell()

@property(strong, nonatomic)UILabel *carNumLabel;
@property(strong, nonatomic)UILabel *nameLabel;
@property(strong, nonatomic)UILabel *expiryDateLabel;
@property(strong, nonatomic)UILabel *cardTypeLabel;
@property(strong, nonatomic)UILabel *amountLabel;
@property(strong, nonatomic)UILabel *payDateLabel;

@end

@implementation MonthPaymentCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}

-(void)initView{
    _carNumLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentLeft textColor:c16 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_carNumLabel];
    
    _nameLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentRight textColor:c11 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_nameLabel];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"ic_date"];
    imageView.frame = CGRectMake(STWidth(15),STHeight(66), STWidth(18), STWidth(18));
    [self.contentView addSubview:imageView];
    
    _expiryDateLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentRight textColor:c12 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_expiryDateLabel];
    
    _cardTypeLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentRight textColor:c06 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_cardTypeLabel];
    
    UILabel *amountTitleLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"缴费金额" textAlignment:NSTextAlignmentLeft textColor:c11 backgroundColor:nil multiLine:NO];
    CGSize amountSize = [amountTitleLabel.text sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    amountTitleLabel.frame = CGRectMake(STWidth(15), STHeight(114), amountSize.width, STHeight(16));
    [self.contentView addSubview:amountTitleLabel];
    
    _amountLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentRight textColor:c12 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_amountLabel];
    
    _payDateLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentRight textColor:c12 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_payDateLabel];
    
    for(int i = 1 ; i <= 3 ; i ++) {
        UIView *line1View = [[UIView alloc]init];
        line1View.frame = CGRectMake(0, STHeight(48) * i, ScreenWidth, STHeight(1));
        line1View.backgroundColor = c17;
        [self.contentView addSubview:line1View];
    }

}


-(void)updateData:(MonthPaymentModel *)model{
    _carNumLabel.text = model.carNum;
    CGSize carNumSize = [model.carNum sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _carNumLabel.frame = CGRectMake(STWidth(15), STHeight(16), carNumSize.width, STHeight(16));

    NSString *nameStr = [NSString stringWithFormat:@"车主：%@",model.name];
    _nameLabel.text = nameStr;
    CGSize nameSize = [nameStr sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _nameLabel.frame = CGRectMake(ScreenWidth - STWidth(15) - nameSize.width, STHeight(16), nameSize.width, STHeight(16));
    
    _expiryDateLabel.text = model.expiryDate;
    CGSize expiryDateSize = [model.expiryDate sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _expiryDateLabel.frame = CGRectMake(STWidth(43), STHeight(67), expiryDateSize.width, STHeight(16));

    _cardTypeLabel.text = model.cardType;
    CGSize cardTypeSize = [model.cardType sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _cardTypeLabel.frame = CGRectMake(ScreenWidth - STWidth(15) - cardTypeSize.width, STHeight(67), cardTypeSize.width, STHeight(16));
    
    NSString *amountStr = [NSString stringWithFormat:@"%@元",model.amount];
    _amountLabel.text = amountStr;
    CGSize amoutSize = [amountStr sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _amountLabel.frame = CGRectMake(ScreenWidth - STWidth(15) - amoutSize.width, STHeight(114), amoutSize.width, STHeight(16));
    
    NSString *payDateStr = [NSString stringWithFormat:@"支付时间：%@",model.payDate];
    _payDateLabel.text = payDateStr;
    CGSize payDateSize = [payDateStr sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _payDateLabel.frame = CGRectMake(ScreenWidth - STWidth(15) - payDateSize.width, STHeight(163), payDateSize.width, STHeight(16));
    
}



+(NSString *)identify{
    return NSStringFromClass([MonthPaymentCell class]);
}

@end
