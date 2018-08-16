//
//  CarDetailCell.m
//  framework
//
//  Created by 黄成实 on 2018/5/21.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "CarDetailCell.h"

@interface CarDetailCell()

@property(strong, nonatomic)UILabel *titleLabel;
@property(strong, nonatomic)UILabel *contentLabel;

@end

@implementation CarDetailCell

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
    
    
    UIView *lineView = [[UIView alloc]init];
    lineView.frame = CGRectMake(0, STHeight(55.5), ScreenWidth, LineHeight);
    lineView.backgroundColor = cline;
    [self.contentView addSubview:lineView];
}


-(void)updateData:(TitleContentModel *)model{
    CGSize titleSize = [STPUtil textSize:model.title maxWidth:ScreenWidth font:STFont(16)];
    _titleLabel.text = model.title;
    _titleLabel.frame = CGRectMake(STWidth(15), STHeight(20.5), titleSize.width, STHeight(16));
    

    CGSize contentSize = [STPUtil textSize:model.content maxWidth:ScreenWidth font:STFont(16)];
    _contentLabel.text = model.content;
    _contentLabel.frame = CGRectMake(ScreenWidth - STWidth(15) - contentSize.width, STHeight(20.5), contentSize.width, STHeight(16));

}



+(NSString *)identify{
    return NSStringFromClass([CarDetailCell class]);
}


@end
