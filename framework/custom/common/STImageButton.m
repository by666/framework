//
//  STImageButton.m
//  framework
//
//  Created by 黄成实 on 2018/7/12.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "STImageButton.h"

@implementation STImageButton

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, 0, self.size.width, self.size.height);
}

@end
