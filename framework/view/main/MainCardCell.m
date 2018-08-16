//
//  MainCardCell.m
//  framework
//
//  Created by 黄成实 on 2018/8/6.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MainCardCell.h"

@interface MainCardCell()

@property (strong, nonatomic) UIImageView *headImageView;
@property (strong, nonatomic) UILabel *nameLabel;

@end

@implementation MainCardCell

-(instancetype)initWithFrame:(CGRect)frame{
    if(self == [super initWithFrame:frame]){
        [self initView];
    }
    return self;
}


-(void)initView{
    
    _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(25),0, STWidth(50), STWidth(50))];
    _headImageView.layer.masksToBounds = YES;
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    _headImageView.layer.cornerRadius = STWidth(25);
    [self.contentView addSubview:_headImageView];
    
    
    _nameLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    _nameLabel.frame = CGRectMake(STWidth(25), STHeight(56), STWidth(50), STHeight(22));
    [self.contentView addSubview:_nameLabel];
    
    
}

-(void)setData:(MemberModel *)model position:(NSInteger)position{
    _nameLabel.text = model.nickname;

    if(position == 0){
        _headImageView.image = [UIImage imageNamed:model.faceUrl];
        _nameLabel.textColor = c12;
    }else{
        NSURL *url = [[STUploadImageUtil sharedSTUploadImageUtil]getRealUrl:model.faceUrl];
        [_headImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"ic_head"]];
        _nameLabel.textColor = c11;
    }

}

+(NSString *)identify{
    return NSStringFromClass([MainCardCell class]);
}

@end
