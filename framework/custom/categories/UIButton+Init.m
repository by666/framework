//
//  UIButton+Init.m
//  framework
//
//  Created by 黄成实 on 2018/5/9.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "UIButton+Init.h"

@implementation UIButton(Init)


-(instancetype)initWithFont:(CGFloat)fontSize text:(NSString *)text textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor corner:(CGFloat)corner borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    if(self == [super init]){
        [self setTitle:text forState:UIControlStateNormal];
        if(textColor != nil){
            [self setTitleColor:textColor forState:UIControlStateNormal];
        }
        if(backgroundColor != nil){
            self.backgroundColor = backgroundColor;
        }
        if(borderColor != nil){
            self.layer.borderColor = [borderColor CGColor];
        }
        self.titleLabel.font = [UIFont systemFontOfSize:fontSize];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = corner;
        self.layer.borderWidth = borderWidth;
        
    }
    return self;
}

@end
