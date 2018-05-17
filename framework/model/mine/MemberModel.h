//
//  MemberModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/17.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MemberModel : NSObject

@property(copy, nonatomic)NSString *uid;
@property(copy, nonatomic)NSString *avatarUrl;
@property(copy, nonatomic)NSString *name;
@property(copy, nonatomic)NSString *identify;

@end
