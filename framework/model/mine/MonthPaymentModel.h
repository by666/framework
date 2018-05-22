//
//  MonthPaymentModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/22.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MonthPaymentModel : NSObject

@property(copy, nonatomic)NSString *carNum;
@property(copy, nonatomic)NSString *name;
@property(copy, nonatomic)NSString *expiryDate;
@property(copy, nonatomic)NSString *cardType;
@property(copy, nonatomic)NSString *amount;
@property(copy, nonatomic)NSString *payDate;

+(MonthPaymentModel *)buildModel:(NSString *)carNum name:(NSString *)name expiryDate:(NSString *)expiryDate cardType:(NSString *)cardType amount:(NSString *)amount payDate:(NSString *)payDate;

@end
