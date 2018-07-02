//
//  LiveModel.m
//  framework
//
//  Created by 黄成实 on 2018/6/19.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "LiveModel.h"

@implementation LiveModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"verifyId": @"id"};
}


-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self == [super init]){
        self.liveAttr = (int)[aDecoder decodeIntegerForKey:@"liveAttr"];
        self.allowbyownerFlag = (int)[aDecoder decodeIntegerForKey:@"allowbyownerFlag"];
        self.defaultHomeFlag = (int)[aDecoder decodeIntegerForKey:@"defaultHomeFlag"];
        self.delState = (int)[aDecoder decodeIntegerForKey:@"delState"];
        self.districtUid = [aDecoder decodeObjectForKey:@"districtUid"];
        self.homeLocator = [aDecoder decodeObjectForKey:@"homeLocator"];
        self.userUid = [aDecoder decodeObjectForKey:@"userUid"];
        self.mainUid = [aDecoder decodeObjectForKey:@"mainUid"];
        self.nickname = [aDecoder decodeObjectForKey:@"nickname"];
        self.userUid = [aDecoder decodeObjectForKey:@"userUid"];
        self.overdue = [aDecoder decodeObjectForKey:@"overdue"];
        self.createTime = [aDecoder decodeObjectForKey:@"createTime"];
        self.modifyTime = [aDecoder decodeObjectForKey:@"modifyTime"];
        self.verifyId = (int)[aDecoder decodeIntegerForKey:@"verifyId"];

    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeInteger:self.liveAttr forKey:@"liveAttr"];
    [aCoder encodeInteger:self.allowbyownerFlag forKey:@"allowbyownerFlag"];
    [aCoder encodeInteger:self.defaultHomeFlag forKey:@"defaultHomeFlag"];
    [aCoder encodeInteger:self.delState forKey:@"delState"];

    [aCoder encodeObject:self.districtUid  forKey:@"districtUid"];
    [aCoder encodeObject:self.homeLocator forKey:@"homeLocator"];
    [aCoder encodeObject:self.userUid forKey:@"userUid"];
    [aCoder encodeObject:self.mainUid forKey:@"mainUid"];
    [aCoder encodeObject:self.nickname forKey:@"nickname"];
    [aCoder encodeObject:self.overdue forKey:@"overdue"];
    [aCoder encodeObject:self.createTime forKey:@"createTime"];
    [aCoder encodeObject:self.modifyTime forKey:@"modifyTime"];
    [aCoder encodeInteger:self.verifyId forKey:@"verifyId"];


}

@end
