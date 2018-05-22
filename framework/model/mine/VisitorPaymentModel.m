//
//  VisitorPaymentModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/22.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "VisitorPaymentModel.h"

@implementation VisitorPaymentModel

+(VisitorPaymentModel *)buildModel:(NSString *)carNum name:(NSString *)name enterTime:(NSString *)enterTime exitTime:(NSString *)exitTime parkTime:(NSString *)parkTime amount:(NSString *)amount{
    VisitorPaymentModel *model = [[VisitorPaymentModel alloc]init];
    model.carNum = carNum;
    model.name = name;
    model.enterTime = enterTime;
    model.exitTime = exitTime;
    model.amount = amount;
    model.parkTime = parkTime;
    return model;
    
}
@end
