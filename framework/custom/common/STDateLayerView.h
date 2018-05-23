//
//  STDateLayerView.h
//  framework
//
//  Created by by.huang on 2018/5/23.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol STDateLayerViewDelegate

-(void)OnDateSelectResult:(NSString *)dateStr;

@end

@interface STDateLayerView : UIView

@property(weak, nonatomic)id<STDateLayerViewDelegate> delegate;

-(instancetype)initWithTitle:(NSString *)title frame:(CGRect)frame;
-(void)setDate:(NSString *)dateStr;

@end
