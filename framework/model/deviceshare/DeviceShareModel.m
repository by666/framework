//
//  DeviceShareModel.m
//  framework
//
//  Created by 黄成实 on 2018/6/8.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "DeviceShareModel.h"
#import "TitleContentModel.h"
@implementation DeviceShareModel


+(NSMutableArray *)getTestDatas{
    NSMutableArray *datas = [[NSMutableArray alloc]init];
    NSMutableArray *detailDatas = [[NSMutableArray alloc]init];
    [detailDatas addObject:[TitleContentModel buildModel:@"品牌" content:@"吉芮电动轮椅"]];
    [detailDatas addObject:[TitleContentModel buildModel:@"型号" content:@"JRWD1801"]];
    [detailDatas addObject:[TitleContentModel buildModel:@"生产企业" content:@"吉芮医疗器械（上海)有限公司"]];
    [detailDatas addObject:[TitleContentModel buildModel:@"适用人群" content:@"不限 中老年 中青年 儿童 老年"]];
    [detailDatas addObject:[TitleContentModel buildModel:@"适用疾病" content:@"下肢残疾 偏瘫 截瘫 摔伤 骨折牵引骨质疏松 骨裂等疾病"]];

    [datas addObject:[self buildModel:@"共享设备_icon_冲击钻" name:@"冲击钻" price:@"15元/天" brief:@"博世GSB 16RE冲击钻" detail:detailDatas]];
    [datas addObject:[self buildModel:@"共享设备_icon_轮椅" name:@"轮椅" price:@"15元/天" brief:@"加强铝合金 软座可折叠 H062" detail:detailDatas]];
    [datas addObject:[self buildModel:@"共享设备_icon_电烤箱" name:@"电烤箱" price:@"15元/天" brief:@"40升家用多功能电烤箱双层门" detail:detailDatas]];
    [datas addObject:[self buildModel:@"共享设备_icon_打气筒" name:@"打气筒" price:@"15元/天" brief:@"家用落地式山地单车高压打气筒" detail:detailDatas]];
    return datas;
}


+(DeviceShareModel *)buildModel:(NSString *)imageSrc name:(NSString *)name price:(NSString *)price brief:(NSString *)brief detail:(NSMutableArray *)detailDatas{
    DeviceShareModel *model = [[DeviceShareModel alloc]init];
    model.imageSrc = imageSrc;
    model.name = name;
    model.price = price;
    model.brief = brief;
    model.detailDatas = detailDatas;
    return model;
}
@end
