//
//  UserModel.h
//  framework
//
//  Created by 黄成实 on 2018/4/24.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject<NSCoding>

@property(copy, nonatomic)NSString *access_token;
@property(copy, nonatomic)NSString *refresh_token;

@property (assign, nonatomic) long uid;
@property (assign, nonatomic) int age;
@property (copy, nonatomic) NSString *phoneNum;
@property (copy, nonatomic) NSString *nickName;
@property (copy, nonatomic) NSString *gender;
@property (copy, nonatomic) NSString *avatarUrl;

@end
