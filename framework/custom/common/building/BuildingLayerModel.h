//
//  BuildingLayerModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/28.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BuildingLayerModel : NSObject

@property(copy, nonatomic)NSString *layerName;
@property(copy, nonatomic)NSString *layerLocator;
@property(assign, nonatomic)int levelNum;

@end
