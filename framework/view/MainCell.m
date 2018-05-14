//
//  MainCell.m
//  framework
//
//  Created by 黄成实 on 2018/5/14.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MainCell.h"

@interface MainCell()

@property(strong, nonatomic)UILabel *titleLabel;

@end

@implementation MainCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}

-(void)initView{
    _titleLabel = [[UILabel alloc]initWithFont:STFont(30) text:@"666" textAlignment:NSTextAlignmentCenter textColor:[UIColor blackColor] backgroundColor:nil multiLine:NO];
    _titleLabel.frame = CGRectMake(0, 0, ScreenWidth, STHeight(100));
    [self.contentView addSubview:_titleLabel];
}

-(void)setDatas:(NSMutableArray *)datas{
 
}

@end
