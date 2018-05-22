//
//  VisitorPaymentCell.m
//  framework
//
//  Created by 黄成实 on 2018/5/22.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "VisitorPaymentCell.h"
#import "STEdgeLabel.h"

@interface VisitorPaymentCell()

@property(strong, nonatomic)UILabel *carNumLabel;
@property(strong, nonatomic)UILabel *nameLabel;
@property(strong, nonatomic)UILabel *enterTimeLabel;
@property(strong, nonatomic)UILabel *exitTimeLabel;
@property(strong, nonatomic)UILabel *parkTimeLabel;
@property(strong, nonatomic)UILabel *amountLabel;

@end

@implementation VisitorPaymentCell

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
    
    STEdgeLabel *enterTitleLabel = [[STEdgeLabel alloc]initWithFont:STFont(10) text:@"进" textAlignment:NSTextAlignmentCenter textColor:c19 backgroundColor:nil multiLine:NO];
    enterTitleLabel.layer.borderColor = [c19 CGColor];
    enterTitleLabel.layer.borderWidth = STHeight(1);
    enterTitleLabel.layer.masksToBounds = YES;
    enterTitleLabel.layer.cornerRadius = STHeight(9);
    enterTitleLabel.frame = CGRectMake(STWidth(15), STHeight(69), STHeight(18), STHeight(18));
    [self.contentView addSubview:enterTitleLabel];
    
    STEdgeLabel *exitTitleLabel = [[STEdgeLabel alloc]initWithFont:STFont(10) text:@"出" textAlignment:NSTextAlignmentCenter textColor:c19 backgroundColor:nil multiLine:NO];
    exitTitleLabel.layer.borderColor = [c19 CGColor];
    exitTitleLabel.layer.borderWidth = STHeight(1);
    exitTitleLabel.layer.masksToBounds = YES;
    exitTitleLabel.layer.cornerRadius = STHeight(9);
    exitTitleLabel.frame = CGRectMake(STWidth(15), STHeight(96), STHeight(18), STHeight(18));
    [self.contentView addSubview:exitTitleLabel];
    
    _enterTimeLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentCenter textColor:c12 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_enterTimeLabel];

    _exitTimeLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentCenter textColor:c12 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_exitTimeLabel];

    UILabel *parkTitleLabel = [[UILabel alloc]initWithFont:STFont(12) text:@"停车时长" textAlignment:NSTextAlignmentLeft textColor:c09 backgroundColor:nil multiLine:NO];
    CGSize parkTitleSize = [parkTitleLabel.text sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(12)]];
    parkTitleLabel.frame = CGRectMake(ScreenWidth - STWidth(15) - parkTitleSize.width, STHeight(72), parkTitleSize.width, STHeight(12));
    [self.contentView addSubview:parkTitleLabel];

    _parkTimeLabel = [[UILabel alloc]initWithFont:STFont(14) text:@"" textAlignment:NSTextAlignmentRight textColor:c20 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_parkTimeLabel];

    
    UILabel *amountTitleLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"缴费金额" textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    CGSize amountTitleSize = [parkTitleLabel.text sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    amountTitleLabel.frame = CGRectMake(STWidth(15), STHeight(149), amountTitleSize.width, STHeight(12));
    [self.contentView addSubview:amountTitleLabel];
    
    _amountLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentRight textColor:c12 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_amountLabel];
    
    UIView *lineView1 = [[UIView alloc]init];
    lineView1.frame = CGRectMake(0, STHeight(48), ScreenWidth, STHeight(1));
    lineView1.backgroundColor = c17;
    [self.contentView addSubview:lineView1];
    
    UIView *lineView2= [[UIView alloc]init];
    lineView2.frame = CGRectMake(0, STHeight(130), ScreenWidth, STHeight(1));
    lineView2.backgroundColor = c17;
    [self.contentView addSubview:lineView2];
    
}


-(void)updateData:(VisitorPaymentModel *)model{
    _carNumLabel.text = model.carNum;
    CGSize carNumSize = [model.carNum sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _carNumLabel.frame = CGRectMake(STWidth(15), STHeight(16), carNumSize.width, STHeight(16));
    
    NSString *nameStr = [NSString stringWithFormat:@"车主：%@",model.name];
    _nameLabel.text = nameStr;
    CGSize nameSize = [nameStr sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _nameLabel.frame = CGRectMake(ScreenWidth - STWidth(15) - nameSize.width, STHeight(16), nameSize.width, STHeight(16));
    
    _enterTimeLabel.text = model.enterTime;
    CGSize enterTimeSize = [model.enterTime sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _enterTimeLabel.frame = CGRectMake(STWidth(48), STHeight(70), enterTimeSize.width, STHeight(16));

    _exitTimeLabel.text = model.exitTime;
    CGSize exitTimeSize = [model.exitTime sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _exitTimeLabel.frame = CGRectMake(STWidth(48), STHeight(97), exitTimeSize.width, STHeight(16));

    _parkTimeLabel.text = model.parkTime;
    CGSize parkTimeSize = [model.parkTime sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(14)]];
    _parkTimeLabel.frame = CGRectMake(ScreenWidth - STWidth(15) - parkTimeSize.width, STHeight(96), parkTimeSize.width, STHeight(14));

    NSString *amountStr = [NSString stringWithFormat:@"%@元",model.amount];
    _amountLabel.text = amountStr;
    CGSize amountSize = [amountStr sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _amountLabel.frame = CGRectMake(ScreenWidth - STWidth(15) - amountSize.width, STHeight(149), amountSize.width, STHeight(16));
    
}



+(NSString *)identify{
    return NSStringFromClass([VisitorPaymentCell class]);
}

@end
