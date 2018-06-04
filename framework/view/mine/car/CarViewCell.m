//
//  CarViewCell.m
//  framework
//
//  Created by 黄成实 on 2018/5/19.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "CarViewCell.h"
#import "STEdgeLabel.h"


@interface CarViewCell()

@property(strong, nonatomic)UILabel *titleLabel;
@property(strong, nonatomic)STEdgeLabel *idetifyLabel;
@property(strong, nonatomic)UILabel *nameLabel;

@end

@implementation CarViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}

-(void)initView{
    _titleLabel = [[UILabel alloc]initWithFont:STFont(18) text:@"" textAlignment:NSTextAlignmentLeft textColor:c16 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_titleLabel];
    
    _idetifyLabel = [[STEdgeLabel alloc]initWithFont:STFont(10) text:@"" textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    _idetifyLabel.layer.masksToBounds = YES;
    _idetifyLabel.layer.cornerRadius = STHeight(9);
    [self.contentView addSubview:_idetifyLabel];
    
    _nameLabel = [[UILabel alloc]initWithFont:STFont(14) text:@"" textAlignment:NSTextAlignmentLeft textColor:c12 backgroundColor:nil multiLine:NO];
    _nameLabel.frame = CGRectMake(STWidth(15), STHeight(35), ScreenWidth - STWidth(30), STHeight(14));
    _nameLabel.hidden = YES;
    [self.contentView addSubview:_nameLabel];
    
    _paymentBtn = [[UIButton alloc]initWithFont:STFont(14) text:@"" textColor:c19 backgroundColor:nil corner:STHeight(12) borderWidth:1 borderColor:c19];
    [self.contentView addSubview:_paymentBtn];
    
    
    UIView *lineView = [[UIView alloc]init];
    lineView.frame = CGRectMake(0, STHeight(60) - LineHeight, ScreenWidth, LineHeight);
    lineView.backgroundColor = c17;
    [self.contentView addSubview:lineView];
}


-(void)updateData:(CarModel *)model{
    
    _idetifyLabel.text = model.carType;
    _idetifyLabel.frame = CGRectMake(STWidth(15), STHeight(20), STHeight(18), STHeight(18));

    if([model.carType isEqualToString:@"月"]){
        _idetifyLabel.backgroundColor = c19;
    }else{
        _idetifyLabel.backgroundColor = c32;
    }
    
    NSString *title = [NSString stringWithFormat:@"%@ %@",model.carHead,model.carNum];
    CGSize titleSize = [STPUtil textSize:title maxWidth:ScreenWidth font:STFont(18)];
    _titleLabel.text = title;
    _titleLabel.frame = CGRectMake(STWidth(40), STHeight(20), titleSize.width, STHeight(18));
    
    _nameLabel.hidden = YES;
    if(model.carIdentify == 1){
        [_paymentBtn setTitle:MSG_CAR_PAY forState:UIControlStateNormal];
        _paymentBtn.frame = CGRectMake(STWidth(312), STHeight(18), STWidth(51), STHeight(24));
    }
    else{
        [_paymentBtn setTitle:MSG_CAR_FAMILY_PAY forState:UIControlStateNormal];
        _paymentBtn.frame = CGRectMake(STWidth(265), STHeight(18), STWidth(97), STHeight(24));
        
        if([model.carType isEqualToString:@"月"]){
            _idetifyLabel.frame = CGRectMake(STWidth(15), STHeight(10), STHeight(18), STHeight(18));
            _titleLabel.frame = CGRectMake(STWidth(40), STHeight(10), titleSize.width, STHeight(18));
            _nameLabel.text = [NSString stringWithFormat:MSG_CAR_BIND,model.name];
            _nameLabel.hidden = NO;
        }

    }
}



+(NSString *)identify{
   return NSStringFromClass([CarViewCell class]);
}


@end
