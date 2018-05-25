//
//  STBuildingLayerView.h
//  framework
//
//  Created by 黄成实 on 2018/5/25.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol STBuildingLayerViewDelegate

-(void)OnSelectResult:(NSArray *)array;

@end

@interface STBuildingLayerView : UIView

@property(weak, nonatomic)id<STBuildingLayerViewDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame datas:(NSMutableDictionary *)datas;

@end
