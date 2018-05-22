//
//  MonthPaymentModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/22.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MonthPaymentModel.h"

@implementation MonthPaymentModel



+(MonthPaymentModel *)buildModel:(NSString *)carNum name:(NSString *)name expiryDate:(NSString *)expiryDate cardType:(NSString *)cardType amount:(NSString *)amount payDate:(NSString *)payDate{
    MonthPaymentModel *model = [[MonthPaymentModel alloc]init];
    model.carNum = carNum;
    model.name = name;
    model.expiryDate = expiryDate;
    model.cardType = cardType;
    model.amount = amount;
    model.payDate = payDate;
    return model;
}
@end
