//
//  STBuildingLayerView.h
//  framework
//
//  Created by 黄成实 on 2018/5/25.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol STBuildingLayerViewDelegate

-(void)OnBuildingSelectResult:(NSString *)result fatherLocator:(NSString *)fatherLocator;

@end


@interface STBuildingLayerView : UIView

@property(weak, nonatomic)id<STBuildingLayerViewDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame data:(id)data level:(int)level;

@end
