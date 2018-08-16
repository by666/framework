//
//  HabitantModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/15.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HabitantModel : NSObject

@property(copy, nonatomic) NSString *userName;
@property(copy, nonatomic) NSString *userUid;
@property(copy, nonatomic) NSString *overdue;
@property(copy, nonatomic) NSString *headUrl;
@property(copy, nonatomic) NSString *creid;
@property(copy, nonatomic) NSString *mobile;
@property(assign, nonatomic) int liveAttr;

@end
