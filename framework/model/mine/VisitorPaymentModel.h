//
//  VisitorPaymentModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/22.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VisitorPaymentModel : NSObject

@property(copy, nonatomic)NSString *carNum;
@property(copy, nonatomic)NSString *name;
@property(copy, nonatomic)NSString *enterTime;
@property(copy, nonatomic)NSString *exitTime;
@property(copy, nonatomic)NSString *parkTime;
@property(copy, nonatomic)NSString *amount;

+(VisitorPaymentModel *)buildModel:(NSString *)carNum name:(NSString *)name enterTime:(NSString *)enterTime exitTime:(NSString *)exitTime parkTime:(NSString *)parkTime amount:(NSString *)amount;

@end
