//
//  DeviceShareOrderViewCell.m
//  framework
//
//  Created by 黄成实 on 2018/6/8.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "DeviceShareOrderViewCell.h"
#import "STTimeUtil.h"

@interface DeviceShareOrderViewCell()

@property(strong, nonatomic)UILabel *titleLabel;
@property(strong, nonatomic)UILabel *contentLabel;
@property(strong, nonatomic)UIImageView *arrowImageView;
@property(strong, nonatomic)UILabel *selectLabel;

@end

@implementation DeviceShareOrderViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}

-(void)initView{
    _titleLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentLeft textColor:c16 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_titleLabel];
    
    _contentLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentRight textColor:c12 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_contentLabel];
    
    
    _selectBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - STWidth(200), 0, STWidth(200), STHeight(60))];
    _selectBtn.backgroundColor = cclear;
    _selectBtn.hidden = YES;
    [self.contentView addSubview:_selectBtn];
    
    _arrowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(200) - STWidth(26), STHeight(26), STWidth(11), STHeight(11))];
    _arrowImageView.image = [UIImage imageNamed:@"ic_arrow_bottom"];
    _arrowImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_selectBtn addSubview:_arrowImageView];
    
    _selectLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentRight textColor:c12 backgroundColor:nil multiLine:YES];
    _selectLabel.frame = CGRectMake(0, 0, STWidth(200) - STWidth(36), STHeight(60));
    [_selectBtn addSubview:_selectLabel];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.frame = CGRectMake(0, STHeight(60)-LineHeight, ScreenWidth, LineHeight);
    lineView.backgroundColor = c17;
    [self.contentView addSubview:lineView];
}


-(void)updateData:(TitleContentModel *)model{
    CGSize titleSize = [STPUtil textSize:model.title maxWidth:ScreenWidth font:STFont(16)];
    _titleLabel.text = model.title;
    _titleLabel.frame = CGRectMake(STWidth(15), STHeight(22), titleSize.width, STHeight(16));
    
    if([model.title isEqualToString:MSG_DEVICESHAREORDER_DAYS]){
        NSString *start = [STTimeUtil generateDate2:[STTimeUtil getCurrentTimeStamp]];
        NSString *end = [STTimeUtil generateDate2:[STTimeUtil getTimeStampWithDays:[model.content intValue]]];
        NSString *result = [NSString stringWithFormat:@"%@天\n%@-%@",model.content,start,end];
        _selectLabel.text = result;
        _selectBtn.hidden = NO;
    }else{
        _selectBtn.hidden = YES;
        CGSize contentSize = [STPUtil textSize:model.content maxWidth:ScreenWidth font:STFont(16)];
        _contentLabel.text = model.content;
        _contentLabel.frame = CGRectMake(ScreenWidth - STWidth(15) - contentSize.width, STHeight(22), contentSize.width, STHeight(16));
    }
}



+(NSString *)identify{
    return NSStringFromClass([DeviceShareOrderViewCell class]);
}


@end
