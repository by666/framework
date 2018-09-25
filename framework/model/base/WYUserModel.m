//
//  WYUserModel.m
//  framework
//
//  Created by by.huang on 2018/9/20.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "WYUserModel.h"

@implementation WYUserModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"wyid": @"id"};
}



-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self == [super init]){
        self.wyid = (long)[aDecoder decodeIntegerForKey:@"wyid"];
        self.userUid = [aDecoder decodeObjectForKey:@"userUid"];
        self.accId = [aDecoder decodeObjectForKey:@"accId"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.token = [aDecoder decodeObjectForKey:@"token"];
        self.createTime = [aDecoder decodeObjectForKey:@"createTime"];
        self.modifyTime = [aDecoder decodeObjectForKey:@"modifyTime"];
        
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeInteger:self.wyid forKey:@"wyid"];
    [aCoder encodeObject:self.userUid  forKey:@"userUid"];
    [aCoder encodeObject:self.accId forKey:@"accId"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeObject:self.createTime forKey:@"createTime"];
    [aCoder encodeObject:self.modifyTime forKey:@"modifyTime"];
    
}
@end
