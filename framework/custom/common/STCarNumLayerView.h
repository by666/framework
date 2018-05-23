//
//  STCarNumLayerView.h
//  framework
//
//  Created by by.huang on 2018/5/23.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol STCarNumLayerViewDelegate

-(void)OnCarNumSelectResult:(NSString *)carNumStr;

@end

@interface STCarNumLayerView : UIView

@property(weak, nonatomic)id<STCarNumLayerViewDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame;
-(void)setCarNum:(NSString *)carNumStr;

@end



