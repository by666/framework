//
//  CommunityModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/29.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "CommunityModel.h"

@implementation CommunityModel


+ (NSMutableArray *)getTestDatas{
    NSMutableArray *datas = [[NSMutableArray alloc]init];
    [datas addObject:[CommunityModel buildModel:@"光明顶" address:@"山东省-泰安市-东平县-银山镇-昆仑山"]];
    [datas addObject:[CommunityModel buildModel:@"少林寺" address:@"河南省-登封市-嵩山-五乳峰"]];
    [datas addObject:[CommunityModel buildModel:@"武当山" address:@"湖北省-丹江口市-武当山"]];
    [datas addObject:[CommunityModel buildModel:@"峨眉山" address:@"四川省-峨眉山市-峨眉山"]];
    [datas addObject:[CommunityModel buildModel:@"天山" address:@"新疆-天山-托木尔峰"]];
    return datas;
}

+(CommunityModel *)buildModel:(NSString *)name address:(NSString *)address{
    CommunityModel *model = [[CommunityModel alloc]init];
    model.name = name;
    model.address = address;
    return model;
}


@end
