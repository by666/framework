//
//  UITextField+Init.m
//  framework
//
//  Created by 黄成实 on 2018/5/9.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "UITextField+Init.h"

@implementation UITextField(Init)

-(instancetype)initWithFont:(CGFloat)fontSize textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor corner:(CGFloat)corner borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor padding:(CGFloat)padding{
    if(self == [super init]){
        if(textColor != nil){
            self.textColor = textColor;
        }
        if(backgroundColor != nil){
            self.backgroundColor = backgroundColor;
        }
        if(borderColor != nil){
            self.layer.borderColor = [borderColor CGColor];
        }
        self.font = [UIFont systemFontOfSize:fontSize];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = corner;
        self.layer.borderWidth = borderWidth;
        
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, padding, 0)];
        leftView.backgroundColor = backgroundColor;
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

@end
