//
//  FixHistoryCell.m
//  framework
//
//  Created by 黄成实 on 2018/6/8.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "FixHistoryCell.h"

@interface FixHistoryCell()

@property(strong, nonatomic)UILabel *orderTimeLabel;
@property(strong, nonatomic)UILabel *reportTimeLabel;
@property(strong, nonatomic)UILabel *categoryLabel;
@property(strong, nonatomic)UILabel *detailLabel;


@end

@implementation FixHistoryCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}

-(void)initView{
    
    NSArray *titles = [MSG_FIXHISTORY_TITLE_ARRAY componentsSeparatedByString:@"|"];
    for(int i = 0 ; i < titles.count ; i ++){
        UILabel *titleLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentLeft textColor:c11 backgroundColor:nil multiLine:NO];
        NSString *title = titles[i];
        titleLabel.text = title;
        CGSize titleSize = [title sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
        titleLabel.frame = CGRectMake(STWidth(15), STHeight(18) + STHeight(54) * i, titleSize.width, STHeight(16));
        [self.contentView addSubview:titleLabel];
        
        if(i != (titles.count - 1)){
            UIView *lineView = [[UIView alloc]init];
            lineView.frame = CGRectMake(0, STHeight(54) * (i + 1)-LineHeight, ScreenWidth, LineHeight);
            lineView.backgroundColor = cline;
            [self.contentView addSubview:lineView];
        }
      
    }

    
    _orderTimeLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentRight textColor:c12 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_orderTimeLabel];
    
    _reportTimeLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentRight textColor:c12 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_reportTimeLabel];
    
    _categoryLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentRight textColor:c12 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_categoryLabel];
    
    _detailLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentLeft textColor:c12 backgroundColor:nil multiLine:NO];
    _detailLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.contentView addSubview:_detailLabel];
    
    _expandBtn = [[UIButton alloc]initWithFrame: CGRectMake(ScreenWidth - STWidth(45), STHeight(170), STWidth(30), STHeight(32))];
    _expandBtn.backgroundColor = cclear;
    [_expandBtn setImage:[UIImage imageNamed:@"ic_arrow_bottom"] forState:UIControlStateNormal];
    [self.contentView addSubview:_expandBtn];
    
}


-(void)updateData:(FixModel *)model{
    
    _reportTimeLabel.text = model.reportTime;
    CGSize reportTimeSize = [_reportTimeLabel.text sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _reportTimeLabel.frame = CGRectMake(ScreenWidth - reportTimeSize.width - STWidth(15), STHeight(18), reportTimeSize.width, STHeight(16));
    
    
    _categoryLabel.text = model.category;
    CGSize categorySize = [_categoryLabel.text sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _categoryLabel.frame = CGRectMake(ScreenWidth - categorySize.width - STWidth(15), STHeight(72), categorySize.width, STHeight(16));
    
    
    _orderTimeLabel.text = model.orderTime;
    CGSize OrderTimeSize = [_orderTimeLabel.text sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _orderTimeLabel.frame =  CGRectMake(ScreenWidth - OrderTimeSize.width - STWidth(15), STHeight(126), OrderTimeSize.width, STHeight(16));

    _detailLabel.text = model.detail;
    if(!model.expand){
        [_expandBtn setImage:[UIImage imageNamed:@"ic_arrow_bottom"] forState:UIControlStateNormal];
        _detailLabel.frame = CGRectMake(STWidth(15), STHeight(216), ScreenWidth - STWidth(30), STHeight(16));
    }else{
        [_expandBtn setImage:[UIImage imageNamed:@"ic_arrow_up"] forState:UIControlStateNormal];
        CGSize detailSize = [_detailLabel.text sizeWithMaxWidth:(ScreenWidth - STWidth(30)) font:[UIFont systemFontOfSize:STFont(16)]];
        _detailLabel.numberOfLines = 0;
        _detailLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _detailLabel.frame = CGRectMake(STWidth(15), STHeight(216), detailSize.width, detailSize.height);
    }


}


+(NSString *)identify{
    return NSStringFromClass([FixHistoryCell class]);
}

@end
