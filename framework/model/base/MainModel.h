//
//  MainModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/15.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainModel : NSObject<NSCoding>

@property(copy, nonatomic)NSString *districtUid;
@property(copy, nonatomic)NSString *districtName;
@property(copy, nonatomic)NSString *addrCode;
@property(copy, nonatomic)NSString *addrStr;
@property(copy, nonatomic)NSString *detailAddr;
@property(assign, nonatomic)double latitude;
@property(assign, nonatomic)double longitude;
@property(copy, nonatomic)NSString *province;
@property(copy, nonatomic)NSString *city;
@property(copy, nonatomic)NSString *district;
@property(copy, nonatomic)NSString *tel;
@property(copy, nonatomic)NSString *md5Key;
@property(assign, nonatomic)int layerLevel;
@property(copy, nonatomic)NSString *mnsUrl;
@property(copy, nonatomic)NSString *mnsQueueName;
@property(copy, nonatomic)NSString *createTime;
@property(copy, nonatomic)NSString *modifyTime;
@property(copy, nonatomic)NSString *ekey;



@end
