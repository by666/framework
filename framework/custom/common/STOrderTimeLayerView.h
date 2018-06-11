//
//  STOrderTimeLayerView.h
//  framework
//
//  Created by 黄成实 on 2018/6/7.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol STOrderTimeLayerViewDelegate

-(void)OnOrderTimeSelectResult:(NSString *)orderTime;

@end

@interface STOrderTimeLayerView : UIView

@property(weak, nonatomic)id<STOrderTimeLayerViewDelegate> delegate;

-(instancetype)init;
-(void)setOrderTime:(NSString *)carNumStr;

@end
