//
//  STSelectLayerButton.m
//  framework
//
//  Created by 黄成实 on 2018/6/6.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "STSelectLayerButton.h"

@interface STSelectLayerButton()

@property(strong, nonatomic)UILabel *selectLabel;

@end

@implementation STSelectLayerButton

-(instancetype)initWithFrame:(CGRect)frame{
    if(self == [super initWithFrame:frame]){
        [self initView:frame];
    }
    return self;
}


-(void)initView:(CGRect)rect{
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(rect.size.width - STWidth(7), (rect.size.height - STHeight(11))/2, STWidth(7), STHeight(11))];
    imageView.image = [UIImage imageNamed:@"ic_arrow_bottom"];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:imageView];
    
    _selectLabel = [[UILabel alloc]initWithFont:STFont(14) text:@"" textAlignment:NSTextAlignmentCenter textColor:c12 backgroundColor:nil multiLine:NO];
    [self addSubview:_selectLabel];
}


-(void)setSelectText:(NSString *)text{
    CGSize textSize = [text sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(14)]];
    _selectLabel.text = text;
    _selectLabel.frame = CGRectMake(self.frame.size.width - STWidth(15) - textSize.width, (self.frame.size.height  - STHeight(14))/2, textSize.width, STHeight(14));
}


-(NSString *)getSelectText{
    return _selectLabel.text;
}
@end
