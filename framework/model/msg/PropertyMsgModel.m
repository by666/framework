//
//  PropertyMsgModel.m
//  framework
//
//  Created by 黄成实 on 2018/6/1.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "PropertyMsgModel.h"

@implementation PropertyMsgModel

+(NSMutableArray *)getTestDatas{
    NSMutableArray *datas = [[NSMutableArray alloc]init];
    [datas addObject:[self buildModel:1 title:@"物业升级提醒"  timestamp:@"2018.6.1 14:34"]];
    [datas addObject:[self buildModel:2 title:@"加强小区安全工作"  timestamp:@"2018.5.28 09:53"]];
    [datas addObject:[self buildModel:3 title:@"物业通知"  timestamp:@"2018.5.14 18:12"]];
    [datas addObject:[self buildModel:4 title:@"小区消防演习通知" timestamp:@"2018.5.1 11:15"]];
    [datas addObject:[self buildModel:1 title:@"小区安全知识讲座"  timestamp:@"2018.6.1 14:34"]];
    [datas addObject:[self buildModel:2 title:@"物业通知"  timestamp:@"2018.5.28 09:53"]];
    [datas addObject:[self buildModel:3 title:@"物业通知"  timestamp:@"2018.5.14 18:12"]];
    [datas addObject:[self buildModel:4 title:@"物业通知"  timestamp:@"2018.5.1 11:15"]];
    return datas;
}

+(PropertyMsgModel *)buildModel:(long)mid title:(NSString *)title timestamp:(NSString *)timeStamp{
    PropertyMsgModel *model = [[PropertyMsgModel alloc]init];
    model.mid = mid;
    model.title =  title;
    model.timeStamp = timeStamp;
    return model;
}

@end
