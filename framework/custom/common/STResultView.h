//
//  STResultView.h
//  framework
//
//  Created by 黄成实 on 2018/5/24.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STResultView : UIView
typedef void (^OnClick)(NSString *result);

-(instancetype)initWithTips:(NSString *)tips1 tips2:(NSString *)tips2;
-(instancetype)initWithTips:(NSString *)tips1 tips2:(NSString *)tips2 btnTxt:(NSString *)btnTxt click:(OnClick)click;
-(void)setTips1Text:(NSString *)text;
@end
