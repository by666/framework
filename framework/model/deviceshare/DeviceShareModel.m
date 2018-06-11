//
//  DeviceShareModel.m
//  framework
//
//  Created by 黄成实 on 2018/6/8.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "DeviceShareModel.h"

@implementation DeviceShareModel


+(NSMutableArray *)getTestDatas{
    NSMutableArray *datas = [[NSMutableArray alloc]init];
    NSString *detail = @"为避免压疮，对垫子要高度注意，有可能尽量用蛋篓（eggcrate）型或Roto垫，这种垫由一块大塑料，上面有大量直径5cm左右的乳头状塑胶空心柱组成，每个柱都柔软易动，患者坐上后受压面变成大量的受压点，而且患者稍一移动，受压点随乳头的移动而改变，这样就可以不断地变换受压点，避免经常压迫同一部位造成压疮。如无上述垫子，则需用层型泡沫塑料，其厚度应有10cm，上层为0.5cm 厚的高密度聚氯基甲酸酯（polyarethane）泡沫塑料，下层为中密度的同样性质的塑料，高密度者支持性强，中密度者柔软舒适。在坐位时，坐骨结节承压很大，常超出正常毛细血管端压力的1~16倍，易于缺血形成压疮。为避免此处压力过大，常在相应处的垫子上挖去一块，让坐骨结节架空，挖时前方应在坐骨结节前2.5cm处，侧方应在该结节外侧2.5cm处，深度在7.5cm左右，挖后垫子呈凹字形，缺口在后，若采用上述垫子加上切口，可以相当有效地防止压疮的产生。为避免压疮，对垫子要高度注意，有可能尽量用蛋篓（eggcrate）型或Roto垫，这种垫由一块大塑料，上面有大量直径5cm左右的乳头状塑胶空心柱组成，每个柱都柔软易动，患者坐上后受压面变成大量的受压点，而且患者稍一移动，受压点随乳头的移动而改变，这样就可以不断地变换受压点，避免经常压迫同一部位造成压疮。如无上述垫子，则需用层型泡沫塑料，其厚度应有10cm，上层为0.5cm 厚的高密度聚氯基甲酸酯（polyarethane）泡沫塑料，下层为中密度的同样性质的塑料，高密度者支持性强，中密度者柔软舒适。在坐位时，坐骨结节承压很大，常超出正常毛细血管端压力的1~16倍，易于缺血形成压疮。为避免此处压力过大，常在相应处的垫子上挖去一块，让坐骨结节架空，挖时前方应在坐骨结节前2.5cm处，侧方应在该结节外侧2.5cm处，深度在7.5cm左右，挖后垫子呈凹字形，缺口在后，若采用上述垫子加上切口，可以相当有效地防止压疮的产生。为避免压疮，对垫子要高度注意，有可能尽量用蛋篓（eggcrate）型或Roto垫，这种垫由一块大塑料，上面有大量直径5cm左右的乳头状塑胶空心柱组成，每个柱都柔软易动，患者坐上后受压面变成大量的受压点，而且患者稍一移动，受压点随乳头的移动而改变，这样就可以不断地变换受压点，避免经常压迫同一部位造成压疮。如无上述垫子，则需用层型泡沫塑料，其厚度应有10cm，上层为0.5cm 厚的高密度聚氯基甲酸酯（polyarethane）泡沫塑料，下层为中密度的同样性质的塑料，高密度者支持性强，中密度者柔软舒适。在坐位时，坐骨结节承压很大，常超出正常毛细血管端压力的1~16倍，易于缺血形成压疮。为避免此处压力过大，常在相应处的垫子上挖去一块，让坐骨结节架空，挖时前方应在坐骨结节前2.5cm处，侧方应在该结节外侧2.5cm处，深度在7.5cm左右，挖后垫子呈凹字形，缺口在后，若采用上述垫子加上切口，可以相当有效地防止压疮的产生。";
    [datas addObject:[self buildModel:@"ic_冲击钻" name:@"冲击钻" price:@"15元/天" brief:@"博世GSB 16RE冲击钻" detail:detail]];
    [datas addObject:[self buildModel:@"ic_轮椅" name:@"轮椅" price:@"15元/天" brief:@"加强铝合金 软座可折叠 H062" detail:detail]];
    [datas addObject:[self buildModel:@"ic_电烤箱" name:@"电烤箱" price:@"15元/天" brief:@"40升家用多功能电烤箱双层门" detail:detail]];
    [datas addObject:[self buildModel:@"ic_打气筒" name:@"打气筒" price:@"15元/天" brief:@"家用落地式山地单车高压打气筒" detail:detail]];
    return datas;
}


+(DeviceShareModel *)buildModel:(NSString *)imageSrc name:(NSString *)name price:(NSString *)price brief:(NSString *)brief detail:(NSString *)detail{
    DeviceShareModel *model = [[DeviceShareModel alloc]init];
    model.imageSrc = imageSrc;
    model.name = name;
    model.price = price;
    model.brief = brief;
    model.detail = detail;
    return model;
}
@end
