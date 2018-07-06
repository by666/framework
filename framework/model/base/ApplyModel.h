//
//  ApplyModel.h
//  framework
//
//  Created by 黄成实 on 2018/7/4.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApplyModel : NSObject<NSCoding>

@property(copy, nonatomic)NSString *userUid;
@property(assign, nonatomic)int applyState;
@property(assign, nonatomic)int visualFlag;
@property(assign, nonatomic)int applyType;
@property(assign, nonatomic)int verifyId;

@end
