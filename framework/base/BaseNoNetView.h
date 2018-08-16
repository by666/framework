//
//  BaseNoNetView.h
//  framework
//
//  Created by 黄成实 on 2018/8/15.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseNoNetView : UIView

-(instancetype)initWithBlock:(void (^)(void))onclick;

@end
