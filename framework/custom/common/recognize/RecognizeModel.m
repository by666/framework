//
//  RecognizeModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/29.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "RecognizeModel.h"

@implementation RecognizeModel


+(NSMutableArray *)getTestDatas:(NSString *)str{
    if(str.length > 2){
        str  = [str substringWithRange:NSMakeRange(0, 2)];
    }
    NSMutableArray *datas = [[NSMutableArray alloc]init];
    [datas addObject:[self buildModel:[NSString stringWithFormat:@"%@01",str] selected:YES]];
    [datas addObject:[self buildModel:[NSString stringWithFormat:@"%@02",str] selected:NO]];
    [datas addObject:[self buildModel:[NSString stringWithFormat:@"%@04",str] selected:NO]];
    [datas addObject:[self buildModel:[NSString stringWithFormat:@"%@05",str] selected:NO]];
    [datas addObject:[self buildModel:[NSString stringWithFormat:@"%@06",str] selected:NO]];
    return datas;
}

+(RecognizeModel *)buildModel:(NSString *)title selected:(Boolean)selected{
    RecognizeModel *model = [[RecognizeModel alloc]init];
    model.title = title;
    model.selected = selected;
    return model;
}
@end
