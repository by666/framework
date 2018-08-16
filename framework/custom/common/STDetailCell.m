//
//  STDetailCell.m
//  framework
//
//  Created by 黄成实 on 2018/8/13.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "STDetailCell.h"

@interface STDetailCell()

@property(strong, nonatomic)UILabel *titleLabel;
@property(strong, nonatomic)UILabel *contentLabel;

@end

@implementation STDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}

-(void)initView{

    _titleLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_titleLabel];
    
    _contentLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentCenter textColor:c12 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_contentLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(56.5) - LineHeight, ScreenWidth, LineHeight)];
    lineView.backgroundColor = cline;
    [self.contentView addSubview:lineView];

}


-(void)updateData:(TitleContentModel *)model{

    NSString *titleStr = model.title;
    CGSize titleSize = [titleStr sizeWithMaxWidth:STWidth(100) font:[UIFont systemFontOfSize:STFont(16)]];
    _titleLabel.text = titleStr;
    _titleLabel.frame = CGRectMake(STWidth(15), 0, titleSize.width, STHeight(56.5));

    
    NSString *contentStr = model.content;
    CGSize contentSize = [contentStr sizeWithMaxWidth:STWidth(200) font:[UIFont systemFontOfSize:STFont(16)]];
    _contentLabel.text = contentStr;
    _contentLabel.frame = CGRectMake(ScreenWidth -  STWidth(15) - contentSize.width
                                   , 0, contentSize.width, STHeight(56.5));

    
    
    
}


+(NSString *)identify{
    return NSStringFromClass([STDetailCell class]);
}
@end


