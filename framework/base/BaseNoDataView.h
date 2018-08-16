//
//  BaseNoDataView.h
//  framework
//
//  Created by 黄成实 on 2018/8/15.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseNoDataView : UIView

-(instancetype)initWithImage:(NSString *)imageSrc title:(NSString *)title buttonTitle:(NSString *)buttonTitle onclick:(void (^)(void))onclick;

@end
