//
//  CommunityPositionModel.h
//  framework
//
//  Created by 黄成实 on 2018/6/13.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommunityPositionModel : NSObject

@property(copy, nonatomic)NSString *districtName;
@property(copy, nonatomic)NSString *districtUid;
@property(assign, nonatomic)int layerLevel;

@end
