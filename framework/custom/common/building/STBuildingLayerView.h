//
//  STBuildingLayerView.h
//  framework
//
//  Created by 黄成实 on 2018/5/25.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol STBuildingLayerViewDelegate

-(void)OnBuildingSelectResult:(NSString *)result;

@end


//注：最大支持3列
@interface STBuildingLayerView : UIView

@property(weak, nonatomic)id<STBuildingLayerViewDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame datas:(NSMutableArray *)datas;

-(void)setData:(NSString *)dataStr;
@end
