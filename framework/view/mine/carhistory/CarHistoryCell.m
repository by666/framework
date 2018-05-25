//
//  CarHistoryCell.m
//  framework
//
//  Created by 黄成实 on 2018/5/22.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "CarHistoryCell.h"
#import "STEdgeLabel.h"

@interface CarHistoryCell()

@property(strong, nonatomic)UILabel *carNumLabel;
@property(strong, nonatomic)UILabel *nameLabel;
@property(strong, nonatomic)UILabel *enterTimeLabel;
@property(strong, nonatomic)UILabel *exitTimeLabel;
@property(strong, nonatomic)UILabel *parkTimeLabel;
@property(strong, nonatomic)UILabel *amountLabel;
@property(strong, nonatomic)UIButton *payBtn;

@end

@implementation CarHistoryCell

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
    enterTitleLabel.layer.borderWidth = 1;
    enterTitleLabel.layer.masksToBounds = YES;
    enterTitleLabel.layer.cornerRadius = STHeight(9);
    enterTitleLabel.frame = CGRectMake(STWidth(15), STHeight(69), STHeight(18), STHeight(18));
    [self.contentView addSubview:enterTitleLabel];
    
    STEdgeLabel *exitTitleLabel = [[STEdgeLabel alloc]initWithFont:STFont(10) text:@"出" textAlignment:NSTextAlignmentCenter textColor:c19 backgroundColor:nil multiLine:NO];
    exitTitleLabel.layer.borderColor = [c19 CGColor];
    exitTitleLabel.layer.borderWidth = 1;
    exitTitleLabel.layer.masksToBounds = YES;
    exitTitleLabel.layer.cornerRadius = STHeight(9);
    exitTitleLabel.frame = CGRectMake(STWidth(15), STHeight(96), STHeight(18), STHeight(18));
    [self.contentView addSubview:exitTitleLabel];
    
    _enterTimeLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentCenter textColor:c12 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_enterTimeLabel];
    
    _exitTimeLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentCenter textColor:c12 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_exitTimeLabel];
    

    _payBtn = [[UIButton alloc]initWithFont:STFont(12) text:@"" textColor:c19 backgroundColor:nil corner:STHeight(12.5) borderWidth:1 borderColor:c19];
    _payBtn.frame = CGRectMake(STWidth(261), STHeight(78), STWidth(95), 25);
    _payBtn.userInteractionEnabled = NO;
    [self.contentView addSubview:_payBtn];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.frame = CGRectMake(0, STHeight(48), ScreenWidth, 1);
    lineView.backgroundColor = c17;
    [self.contentView addSubview:lineView];

    
}


-(void)updateData:(CarHistoryModel *)model{
    _carNumLabel.text = model.carNum;
    CGSize carNumSize = [model.carNum sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _carNumLabel.frame = CGRectMake(STWidth(15), STHeight(16), carNumSize.width, STHeight(16));
    
    NSString *nameStr = [NSString stringWithFormat:@"访客：%@",model.name];
    _nameLabel.text = nameStr;
    CGSize nameSize = [nameStr sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _nameLabel.frame = CGRectMake(ScreenWidth - STWidth(15) - nameSize.width, STHeight(16), nameSize.width, STHeight(16));
    
    _enterTimeLabel.text = model.enterTime;
    CGSize enterTimeSize = [model.enterTime sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _enterTimeLabel.frame = CGRectMake(STWidth(48), STHeight(70), enterTimeSize.width, STHeight(16));
    
    _exitTimeLabel.text = model.exitTime;
    CGSize exitTimeSize = [model.exitTime sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _exitTimeLabel.frame = CGRectMake(STWidth(48), STHeight(97), exitTimeSize.width, STHeight(16));
    
    if(model.hasPaid){
        [_payBtn setTitle:@"已缴费" forState:UIControlStateNormal];
        _payBtn.enabled = NO;
        [_payBtn setTitleColor:c09 forState:UIControlStateNormal];
        _payBtn.layer.borderColor = [c09 CGColor];
    }
    else{
        [_payBtn setTitle:@"帮他/她缴费" forState:UIControlStateNormal];
        _payBtn.enabled = YES;
        [_payBtn setTitleColor:c19 forState:UIControlStateNormal];
        _payBtn.layer.borderColor = [c19 CGColor];
    }
  
}



+(NSString *)identify{
    return NSStringFromClass([CarHistoryCell class]);
}

@end
