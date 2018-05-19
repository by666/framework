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
@property(strong, nonatomic)UIButton *paymentBtn;

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
    
    _idetifyLabel = [[STEdgeLabel alloc]initWithFont:STFont(10) text:@"" textAlignment:NSTextAlignmentCenter textColor:c19 backgroundColor:nil multiLine:NO];
    _idetifyLabel.layer.borderColor = [c19 CGColor];
    _idetifyLabel.layer.borderWidth = STHeight(1);
    _idetifyLabel.layer.masksToBounds = YES;
    _idetifyLabel.layer.cornerRadius = STHeight(9);
    [self.contentView addSubview:_idetifyLabel];
    
    
    _paymentBtn = [[UIButton alloc]initWithFont:STFont(14) text:@"" textColor:cwhite backgroundColor:c23 corner:STHeight(4) borderWidth:0 borderColor:nil];
    [self.contentView addSubview:_paymentBtn];
    
    
    UIView *lineView = [[UIView alloc]init];
    lineView.frame = CGRectMake(0, STHeight(59), ScreenWidth, STHeight(1));
    lineView.backgroundColor = c17;
    [self.contentView addSubview:lineView];
}


-(void)updateData:(CarModel *)model{
    NSString *title = [NSString stringWithFormat:@"%@ %@",model.carHead,model.carNum];
    CGSize titleSize = [STPUtil textSize:title maxWidth:ScreenWidth font:STFont(18)];
    _titleLabel.text = title;
    _titleLabel.frame = CGRectMake(STWidth(15), STHeight(20), titleSize.width, STHeight(18));
    
    _idetifyLabel.text = model.carType;
    _idetifyLabel.frame = CGRectMake(STWidth(30)+titleSize.width, STHeight(20), STHeight(18), STHeight(18));

    if([model.carType isEqualToString:@"月"]){
        _idetifyLabel.layer.borderColor = [c19 CGColor];
        _idetifyLabel.textColor = c19;
    }else{
        _idetifyLabel.layer.borderColor = [c13 CGColor];
        _idetifyLabel.textColor = c13;
    }
    

    if(model.carIdentify == 1){
        [_paymentBtn setTitle:MSG_CAR_PAY forState:UIControlStateNormal];
        _paymentBtn.frame = CGRectMake(STWidth(312), STHeight(18), STWidth(51), STHeight(24));
    }
    else{
        [_paymentBtn setTitle:MSG_CAR_FAMILY_PAY forState:UIControlStateNormal];
        _paymentBtn.frame = CGRectMake(STWidth(265), STHeight(18), STWidth(97), STHeight(24));
    }
}



+(NSString *)identify{
   return NSStringFromClass([CarViewCell class]);
}


@end
