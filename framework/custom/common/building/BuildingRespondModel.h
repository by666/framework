//
//  BuildingRespondModel.h
//  framework
//
//  Created by 黄成实 on 2018/6/13.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BuildingLayerModel.h"

@interface BuildingRespondModel : NSObject

@property(strong, nonatomic)BuildingLayerModel *layerInfo;
@property(strong, nonatomic)NSMutableArray *subLayerInfo;

@end
