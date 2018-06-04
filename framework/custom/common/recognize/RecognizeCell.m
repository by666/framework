//
//  RecognizeCell.m
//  framework
//
//  Created by 黄成实 on 2018/5/29.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "RecognizeCell.h"
@interface RecognizeCell()

@property(strong, nonatomic)UIImageView *selectImageView;
@property(strong, nonatomic)UILabel *titleLabel;

@end

@implementation RecognizeCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}

-(void)initView{
    
    _selectImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(47), STHeight(12), STWidth(16), STWidth(16))];
    _selectImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_selectImageView];
    
    
    _titleLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentLeft textColor:c20 backgroundColor:nil multiLine:NO];
    _titleLabel.frame = CGRectMake(STWidth(127), STHeight(12), self.contentView.width - STWidth(127), STHeight(16));
    [self.contentView addSubview:_titleLabel];

}

-(void)updateData:(RecognizeModel *)model{
    _titleLabel.text = model.title;
    CGSize titleSize = [model.title sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _titleLabel.frame =  CGRectMake(STWidth(75), STHeight(12), titleSize.width, STHeight(16));
    
    if(model.selected){
        _selectImageView.image = [UIImage imageNamed:@"ic_verify_success"];
    }else{
        _selectImageView.image = [UIImage imageNamed:@"ic_verify_wait"];
    }
}

+(NSString *)identify{
    return NSStringFromClass([RecognizeCell class]);
}


@end
