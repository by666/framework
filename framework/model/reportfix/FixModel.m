//
//  FixModel.m
//  framework
//
//  Created by 黄成实 on 2018/6/8.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "FixModel.h"

@implementation FixModel

+(NSMutableArray *)getTestDatas{
    NSMutableArray *datas = [[NSMutableArray alloc]init];
    [datas addObject:[self buildModel:@"轮椅对开下半身残疾或行动不便的老人来说，就是他们的第二双脚.而多人都是这样，把轮椅买回家之后，只要轮椅不出故障，他们一般不会去检查和保养，对它们很放心，其实这是错误的做。"]];
    [datas addObject:[self buildModel:@"轮椅对开下半身残养，对它们很放心，其实这是错误的做。"]];
    [datas addObject:[self buildModel:@"轮椅对开下半身残疾或行动不便的老人来说，就是他们的第二双脚.而多人都是这样，把轮椅买回家之后，只要轮椅不出故障，他们一般不会去检查和保养，对它们很放心，其实这是错误的做。轮椅对开下半身残疾或行动不便的老人来说，就是他们的第二双脚.而多人都是这样，把轮椅买回家之后，只要轮椅不出故障，他们一般不会去检查和保养，对它们很放心，其实这是错误的做。"]];
    [datas addObject:[self buildModel:@"轮椅对开下半身残疾或行动不便的老人来说，就是他们的第二双脚.而多人都是这样，把轮椅买回家之后，只要轮椅不出故障，他们一般不会去检查和保养，对它们很放心，其实这是错误的做。"]];
    [datas addObject:[self buildModel:@"轮椅对开下半身残疾或行动不便的老人来说，就是他们的第二双脚.而多人都是这样，把轮椅买回家之后，只要轮椅不出故障，他们一般不会去检查和保养，对它们很放心，其实这是错误的做。轮椅对开下半身残疾或行动不便的老人来说，就是他们的第二双脚.而多人都是这样，把轮椅买回家之后，只要轮椅不出故障，他们一般不会去检查和保养，对它们很放心，其实这是错误的做。轮椅对开下半身残疾或行动不便的老人来说，就是他们的第二双脚.而多人都是这样，把轮椅买回家之后，只要轮椅不出故障，他们一般不会去检查和保养，对它们很放心，其实这是错误的做。轮椅对开下半身残疾或行动不便的老人来说，就是他们的第二双脚.而多人都是这样，把轮椅买回家之后，只要轮椅不出故障，他们一般不会去检查和保养，对它们很放心，其实这是错误的做。"]];
    return datas;
}


+(FixModel *)buildModel:(NSString *)detail{
    FixModel *model = [[FixModel alloc]init];
    model.reportTime = @"07.08 11:27";
    model.orderTime = @"07.09 10:00-11:00";
    model.category = @"电器类";
    model.detail = detail;
    model.expand = NO;
    return model;
}

@end
