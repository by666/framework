//
//  EnterAuthCell.m
//  framework
//
//  Created by 黄成实 on 2018/5/30.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "EnterAuthCell.h"

@interface EnterAuthCell()

@property(strong, nonatomic)UILabel *titleLabel;
@property(strong, nonatomic)UILabel *contentLabel;

@end

@implementation EnterAuthCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}

-(void)initView{
    
    _titleLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentLeft textColor:c20 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_titleLabel];
    
    _contentLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentRight textColor:c20 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_contentLabel];
    
  
}


-(void)updateData:(TitleContentModel *)model{
    
    _titleLabel.text = model.title;
    CGSize titleSize = [model.title sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _titleLabel.frame = CGRectMake(STWidth(28), 0, titleSize.width, STHeight(16));

    
    _contentLabel.text = model.content;
    CGSize contentSize = [model.content sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _contentLabel.frame = CGRectMake(STWidth(329) - STWidth(28) - contentSize.width, 0, contentSize.width, STHeight(16));

}



+(NSString*)identify{
    return NSStringFromClass([EnterAuthCell class]);
}

@end
