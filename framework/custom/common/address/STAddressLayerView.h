//
//  STAddressLayerView.h
//  framework
//
//  Created by 黄成实 on 2018/5/25.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STAddressLayerView : UIView

//注：最大支持省，市，区（column = 2,省和市）
-(instancetype)initWithColumn:(NSInteger)column;

@end
