//
//  AddressLayerModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/25.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressLayerModel : NSObject

@property(copy, nonatomic)NSString *name;
@property(strong, nonatomic)NSMutableArray *sub;

@end
