//
//  PassHistoryCell.m
//  framework
//
//  Created by 黄成实 on 2018/6/27.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "PassHistoryCell.h"

@interface PassHistoryCell()

@property(strong, nonatomic)UIImageView *headImageView;
@property(strong, nonatomic)UILabel *nameLabel;
//@property(strong, nonatomic)UILabel *carNumLabel;
@property(strong, nonatomic)UILabel *visitTimeLabel;
//@property(strong, nonatomic)UILabel *checkTimeLabel;
@property(strong, nonatomic)UIView *lineView;
@property(strong, nonatomic)UIButton *passBtn;


@end

@implementation PassHistoryCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}

-(void)initView{
    _headImageView = [[UIImageView alloc]init];
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = STHeight(22);
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_headImageView];
    
    _nameLabel = [[UILabel alloc]initWithFont:STFont(14) text:@"" textAlignment:NSTextAlignmentLeft textColor:c11 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_nameLabel];
    
//    _carNumLabel = [[UILabel alloc]initWithFont:STFont(14) text:@"" textAlignment:NSTextAlignmentLeft textColor:c12 backgroundColor:nil multiLine:NO];
//    [self.contentView addSubview:_carNumLabel];
//
    _visitTimeLabel = [[UILabel alloc]initWithFont:STFont(14) text:@"" textAlignment:NSTextAlignmentLeft textColor:c12 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_visitTimeLabel];
    
//    _checkTimeLabel = [[UILabel alloc]initWithFont:STFont(14) text:@"" textAlignment:NSTextAlignmentLeft textColor:c16 backgroundColor:nil multiLine:NO];
//    [self.contentView addSubview:_checkTimeLabel];
    
    _passBtn = [[UIButton alloc]initWithFont:STFont(12) text:MSG_PASSHISTORY_PASSBTN textColor:c08 backgroundColor:nil corner:STHeight(12.5) borderWidth:1 borderColor:c08];
    _passBtn.frame = CGRectMake(STWidth(276), STHeight(40), STWidth(84), STHeight(25));
    _passBtn.userInteractionEnabled = NO;
    [self.contentView addSubview:_passBtn];
    
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = cline;
    _lineView.frame = CGRectMake(0, STHeight(108)-LineHeight, ScreenWidth,LineHeight);
    [self.contentView addSubview:_lineView];
    
}

-(void)updateData:(PassHistoryModel *)model{
    
    NSString *nameStr = [NSString stringWithFormat:MSG_PASSHISTORY_NAME,model.userName];
    CGSize nameSize = [nameStr sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _nameLabel.text = nameStr;
    _nameLabel.frame = CGRectMake(STWidth(74), STHeight(34), nameSize.width, STHeight(16));
    
//    if(IS_NS_STRING_EMPTY(model.licenseNum)){
        _headImageView.frame = CGRectMake(STWidth(15), STHeight(32), STHeight(44), STHeight(44));
        [self setHeadUrl:model.faceUrl];
//        _carNumLabel.hidden = YES;
        [self setVisitTime:model.startTime height:STHeight(60)];
//        [self setCheckTime:model.createTime height:STHeight(66)];
//
//    }else{
//        _headImageView.frame = CGRectMake(STWidth(15), STHeight(32), STHeight(44), STHeight(44));
//        [self setHeadUrl:model.faceUrl];
//        _carNumLabel.hidden = NO;
//        [self setCarNum:model.licenseNum height:STHeight(44)];
//        [self setVisitTime:model.startTime height:STHeight(66)];
//        [self setCheckTime:model.createTime height:STHeight(88)];

//        _passBtn.frame = CGRectMake(STWidth(276), STHeight(50), STWidth(84), STHeight(25));
//        _lineView.frame = CGRectMake(0, STHeight(126)-LineHeight, ScreenWidth,LineHeight);

//    }
    
}

-(void)setHeadUrl:(NSString *)faceUrl{
    if(IS_NS_STRING_EMPTY(faceUrl)){
        [_headImageView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"ic_head"]];
    }else{
        [_headImageView sd_setImageWithURL:[[STUploadImageUtil sharedSTUploadImageUtil] getRealUrl:faceUrl] placeholderImage:[UIImage imageNamed:@"ic_head"]];
    }
}

//-(void)setCarNum:(NSString *)carNum height:(CGFloat)height{
//    NSString *carNumStr = [NSString stringWithFormat:MSG_PASSHISTORY_CARNUM,carNum];
//    CGSize carNumSize = [carNumStr sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(14)]];
//    _carNumLabel.text = carNumStr;
//    _carNumLabel.frame = CGRectMake(STWidth(90), height, carNumSize.width, STHeight(14));
//}

-(void)setVisitTime:(NSString *)visitTime height:(CGFloat)height{
    NSString *visitTimeStr = [NSString stringWithFormat:MSG_PASSHISTORY_VISITTIME,visitTime];
    visitTimeStr = [visitTimeStr stringByReplacingOccurrencesOfString:@"-" withString:@"."];
    CGSize visitTimeSize = [visitTimeStr sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _visitTimeLabel.text = visitTimeStr;
    _visitTimeLabel.frame = CGRectMake(STWidth(74), height, visitTimeSize.width, STHeight(16));
}


//-(void)setCheckTime:(NSString *)checkTime height:(CGFloat)height{
//    NSString *checkTimeStr = [NSString stringWithFormat:MSG_PASSHISTORY_CHECKTIME,checkTime];
//    checkTimeStr = [checkTimeStr stringByReplacingOccurrencesOfString:@"-" withString:@"."];
//    CGSize checkTimeSize = [checkTimeStr sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(14)]];
//    _checkTimeLabel.text = checkTimeStr;
//    _checkTimeLabel.frame = CGRectMake(STWidth(90), height, checkTimeSize.width, STHeight(14));
//}

+(NSString *)identify{
    return NSStringFromClass([PassHistoryCell class]);
}
@end
