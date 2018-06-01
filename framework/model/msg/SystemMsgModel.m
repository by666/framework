//
//  SystemMsgModel.m
//  framework
//
//  Created by 黄成实 on 2018/6/1.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "SystemMsgModel.h"

@implementation SystemMsgModel


+(NSMutableArray *)getTestDatas{
    NSMutableArray *datas = [[NSMutableArray alloc]init];
    [datas addObject:[self buildModel:1 title:@"系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功" content:@"您已成功更新到v1.4版本" timestamp:@"2018.6.1 14:34"]];
    [datas addObject:[self buildModel:2 title:@"系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功" content:@"您已成功更新到v1.3版本" timestamp:@"2018.5.28 09:53"]];
    [datas addObject:[self buildModel:3 title:@"系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功" content:@"您已成功更新到v1.2版本" timestamp:@"2018.5.14 18:12"]];
    [datas addObject:[self buildModel:4 title:@"系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功" content:@"您已成功更新到v1.1版本" timestamp:@"2018.5.1 11:15"]];
    [datas addObject:[self buildModel:1 title:@"系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功系统升级成功" content:@"您已成功更新到v1.4版本您已成功更新到v1.4版本您已成功更新到v1.4版本您已成功更新到v1.4版本您已成功更新到v1.4版本您已成功更新到v1.4版本您已成功更新到v1.4版本您已成功更新到v1.4版本您已成功更新到v1.4版本您已成功更新到v1.4版本您已成功更新到v1.4版本您已成功更新到v1.4版本您已成功更新到v1.4版本您已成功更新到v1.4版本您已成功更新到v1.4版本您已成功更新到v1.4版本您已成功更新到v1.4版本您已成功更新到v1.4版本您已成功更新到v1.4版本您已成功更新到v1.4版本" timestamp:@"2018.6.1 14:34"]];
    [datas addObject:[self buildModel:2 title:@"系统升级成功" content:@"您已成功更新到v1.3版本您已成功更新到v1.3版本您已成功更新到v1.3版本您已成功更新到v1.3版本您已成功更新到v1.3版本您已成功更新到v1.3版本您已成功更新到v1.3版本您已成功更新到v1.3版本您已成功更新到v1.3版本您已成功更新到v1.3版本您已成功更新到v1.3版本" timestamp:@"2018.5.28 09:53"]];
    [datas addObject:[self buildModel:3 title:@"系统升级成功" content:@"您已成功更新到v1.2版本您已成功更新到v1.2版本您已成功更新到v1.2版本您已成功更新到v1.2版本您已成功更新到v1.2版本您已成功更新到v1.2版本您已成功更新到v1.2版本您已成功更新到v1.2版本您已成功更新到v1.2版本您已成功更新到v1.2版本您已成功更新到v1.2版本您已成功更新到v1.2版本您已成功更新到v1.2版本您已成功更新到v1.2版本您已成功更新到v1.2版本您已成功更新到v1.2版本您已成功更新到v1.2版本您已成功更新到v1.2版本您已成功更新到v1.2版本您已成功更新到v1.2版本您已成功更新到v1.2版本您已成功更新到v1.2版本您已成功更新到v1.2版本您已成功更新到v1.2版本您已成功更新到v1.2版本您已成功更新到v1.2版本您已成功更新到v1.2版本您已成功更新到v1.2版本您已成功更新到v1.2版本您已成功更新到v1.2版本" timestamp:@"2018.5.14 18:12"]];
    [datas addObject:[self buildModel:4 title:@"系统升级成功" content:@"您已成功更新到v1.1版本您已成功更新到v1.1版本您已成功更新到v1.1版本您已成功更新到v1.1版本您已成功更新到v1.1版本您已成功更新到v1.1版本您已成功更新到v1.1版本您已成功更新到v1.1版本您已成功更新到v1.1版本您已成功更新到v1.1版本您已成功更新到v1.1版本您已成功更新到v1.1版本您已成功更新到v1.1版本您已成功更新到v1.1版本您已成功更新到v1.1版本您已成功更新到v1.1版本您已成功更新到v1.1版本您已成功更新到v1.1版本您已成功更新到v1.1版本您已成功更新到v1.1版本您已成功更新到v1.1版本您已成功更新到v1.1版本您已成功更新到v1.1版本您已成功更新到v1.1版本您已成功更新到v1.1版本您已成功更新到v1.1版本您已成功更新到v1.1版本您已成功更新到v1.1版本您已成功更新到v1.1版本您已成功更新到v1.1版本您已成功更新到v1.1版本您已成功更新到v1.1版本您已成功更新到v1.1版本您已成功更新到v1.1版本您已成功更新到v1.1版本您已成功更新到v1.1版本您已成功更新到v1.1版本您已成功更新到v1.1版本" timestamp:@"2018.5.1 11:15"]];
    return datas;
}

+(SystemMsgModel *)buildModel:(long)mid title:(NSString *)title content:(NSString *)content timestamp:(NSString *)timeStamp{
    SystemMsgModel *model = [[SystemMsgModel alloc]init];
    model.mid = mid;
    model.title =  title;
    model.content = content;
    model.timeStamp = timeStamp;
    
    CGSize titleSize = [model.title sizeWithMaxWidth:ScreenWidth - STWidth(70) font:[UIFont systemFontOfSize:STFont(16)]];
    CGSize contentSize = [model.content sizeWithMaxWidth:ScreenWidth - STWidth(70) font:[UIFont systemFontOfSize:STFont(14)]];    
    model.height = titleSize.height + contentSize.height + STHeight(72);
    return model;
}
@end
