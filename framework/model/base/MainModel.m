//
//  MainModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/15.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MainModel.h"

@implementation MainModel



-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self == [super init]){
        self.layerLevel = (int)[aDecoder decodeIntegerForKey:@"layerLevel"];
        self.latitude = [aDecoder decodeDoubleForKey:@"latitude"];
        self.longitude = [aDecoder decodeDoubleForKey:@"longitude"];

        self.districtUid = [aDecoder decodeObjectForKey:@"districtUid"];
        self.districtName = [aDecoder decodeObjectForKey:@"districtName"];
        self.addrCode = [aDecoder decodeObjectForKey:@"addrCode"];
        self.addrStr = [aDecoder decodeObjectForKey:@"addrStr"];
        self.detailAddr = [aDecoder decodeObjectForKey:@"detailAddr"];
        self.province = [aDecoder decodeObjectForKey:@"province"];
        self.city = [aDecoder decodeObjectForKey:@"city"];
        self.district = [aDecoder decodeObjectForKey:@"district"];
        self.tel = [aDecoder decodeObjectForKey:@"tel"];
        self.md5Key = [aDecoder decodeObjectForKey:@"md5Key"];
        self.mnsUrl = [aDecoder decodeObjectForKey:@"mnsUrl"];
        self.mnsQueueName = [aDecoder decodeObjectForKey:@"mnsQueueName"];
        self.createTime = [aDecoder decodeObjectForKey:@"createTime"];
        self.modifyTime = [aDecoder decodeObjectForKey:@"modifyTime"];
        self.ekey = [aDecoder decodeObjectForKey:@"ekey"];

    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInteger:self.layerLevel forKey:@"layerLevel"];
    [aCoder encodeDouble:self.latitude forKey:@"latitude"];
    [aCoder encodeDouble:self.longitude forKey:@"longitude"];

    [aCoder encodeObject:self.districtUid  forKey:@"districtUid"];
    [aCoder encodeObject:self.districtName forKey:@"districtName"];
    [aCoder encodeObject:self.addrCode forKey:@"addrCode"];
    [aCoder encodeObject:self.addrStr forKey:@"addrStr"];
    [aCoder encodeObject:self.detailAddr forKey:@"detailAddr"];
    [aCoder encodeObject:self.province forKey:@"province"];
    [aCoder encodeObject:self.city forKey:@"city"];
    [aCoder encodeObject:self.district forKey:@"district"];
    [aCoder encodeObject:self.tel forKey:@"tel"];
    [aCoder encodeObject:self.md5Key forKey:@"md5Key"];
    [aCoder encodeObject:self.mnsUrl forKey:@"mnsUrl"];
    [aCoder encodeObject:self.mnsQueueName forKey:@"mnsQueueName"];
    [aCoder encodeObject:self.createTime forKey:@"createTime"];
    [aCoder encodeObject:self.modifyTime forKey:@"modifyTime"];
    [aCoder encodeObject:self.ekey forKey:@"ekey"];

}
@end
