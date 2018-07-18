//
//  ApplyModel.m
//  framework
//
//  Created by 黄成实 on 2018/7/4.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "ApplyModel.h"

@implementation ApplyModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"verifyId": @"id"};
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self == [super init]){
        self.applyState = (int)[aDecoder decodeIntegerForKey:@"applyState"];
        self.visualFlag = (int)[aDecoder decodeIntegerForKey:@"visualFlag"];
        self.applyType = (int)[aDecoder decodeIntegerForKey:@"applyType"];
        self.userUid = [aDecoder decodeObjectForKey:@"userUid"];
        self.verifyId = (int)[aDecoder decodeIntegerForKey:@"verifyId"];
        self.hasOwner = [aDecoder decodeBoolForKey:@"hasOwner"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInteger:self.applyState forKey:@"applyState"];
    [aCoder encodeInteger:self.visualFlag forKey:@"visualFlag"];
    [aCoder encodeInteger:self.applyType forKey:@"applyType"];
    [aCoder encodeObject:self.userUid forKey:@"userUid"];
    [aCoder encodeInteger:self.verifyId forKey:@"verifyId"];
    [aCoder encodeBool:self.hasOwner forKey:@"hasOwner"];

}

@end
