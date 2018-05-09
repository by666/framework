//
//  UserModel.m
//  framework
//
//  Created by 黄成实 on 2018/4/24.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel


-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self == [super init]){
        self.uid = [aDecoder decodeIntegerForKey:@"uid"];
        self.age = (int)[aDecoder decodeIntegerForKey:@"age"];
        self.phoneNum = [aDecoder decodeObjectForKey:@"phoneNum"];
        self.nickName = [aDecoder decodeObjectForKey:@"nickName"];
        self.gender = [aDecoder decodeObjectForKey:@"gender"];
        self.avatarUrl = [aDecoder decodeObjectForKey:@"avatarUrl"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInteger:self.uid forKey:@"uid"];
    [aCoder encodeInteger:self.age  forKey:@"age"];
    [aCoder encodeObject:self.phoneNum forKey:@"phoneNum"];
    [aCoder encodeObject:self.nickName forKey:@"nickName"];
    [aCoder encodeObject:self.gender forKey:@"gender"];
    [aCoder encodeObject:self.avatarUrl forKey:@"avatarUrl"];
}

@end
