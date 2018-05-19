//
//  CarModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/19.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CarModel : NSObject

//id
@property(copy, nonatomic)NSString *cid;
//车所属人
@property(copy, nonatomic)NSString *name;
//车牌号头
@property(copy, nonatomic)NSString *carHead;
//车牌号
@property(copy, nonatomic)NSString *carNum;
//月卡或者临时车
@property(copy, nonatomic)NSString *carType;
//我或者家属（其他）人的车
@property(assign, nonatomic)NSInteger carIdentify;

@end
