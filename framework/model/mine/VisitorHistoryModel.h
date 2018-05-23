//
//  VisitorHistoryModel.h
//  framework
//
//  Created by by.huang on 2018/5/23.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VisitorHistoryModel : NSObject

@property(copy, nonatomic)NSString *imageUrl;
@property(copy, nonatomic)NSString *name;
@property(copy, nonatomic)NSString *enterTime;
@property(copy, nonatomic)NSString *exitTime;


+(VisitorHistoryModel *)buildModel:(NSString *)name enterTime:(NSString *)enterTime exitTime:(NSString *)exitTime;
@end
