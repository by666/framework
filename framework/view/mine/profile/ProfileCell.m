//
//  ProfileCell.m
//  framework
//
//  Created by 黄成实 on 2018/5/16.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "ProfileCell.h"
#import "AccountManager.h"
@interface ProfileCell()

@property(strong, nonatomic)UILabel *titleLabel;
@property(strong, nonatomic)UILabel *contentLabel;
@property(strong, nonatomic)UIView  *lineView;

@end

@implementation ProfileCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}

-(void)initView{

    _titleLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentLeft textColor:c11 backgroundColor:nil multiLine:NO];
    _titleLabel.frame = CGRectMake(STWidth(15), STHeight(19),STWidth(100) , STHeight(16));
    [self.contentView addSubview:_titleLabel];
    
    _contentLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentRight textColor:c12 backgroundColor:nil multiLine:YES];
    [self.contentView addSubview:_contentLabel];
    
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = cline;
    _lineView.frame = CGRectMake(0, STHeight(54) - LineHeight, ScreenWidth, LineHeight);
    [self.contentView addSubview:_lineView];
    
}


-(void)updateData:(TitleContentModel *)model position:(NSInteger)position{
    _titleLabel.text = model.title;
    if(!IS_NS_STRING_EMPTY(model.content)){
        _contentLabel.text = model.content;
    }else{
        _contentLabel.text = @"";
    }
  
    _titleLabel.frame = CGRectMake(STWidth(15), STHeight(20),STWidth(100) , STHeight(16));
    
    if(position == 3 || position == 6){
        [_lineView setHidden:YES];
    }else{
        [_lineView setHidden:NO];
    }
    
    if(position == 6){
        CGSize cSize = [model.content sizeWithMaxWidth:ScreenWidth -  STWidth(150) font:[UIFont systemFontOfSize:STFont(16)]];
        _contentLabel.frame = CGRectMake(STWidth(135), STHeight(19),ScreenWidth - STWidth(150), cSize.height);
    }else{
        _contentLabel.frame = CGRectMake(STWidth(135), STHeight(19),ScreenWidth - STWidth(150), STHeight(16));
    }

}

+(NSString*)identify{
    return NSStringFromClass([ProfileCell class]);
}

@end
