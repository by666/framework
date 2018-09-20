//
//  WYUserModel.h
//  framework
//
//  Created by by.huang on 2018/9/20.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYUserModel : NSObject

@property(assign, nonatomic)long wyid;
@property(copy, nonatomic)NSString *userUid;
@property(copy, nonatomic)NSString *accId;
@property(copy, nonatomic)NSString *name;
@property(copy, nonatomic)NSString *token;
@property(copy, nonatomic)NSString *createTime;
@property(copy, nonatomic)NSString *modifyTime;


@end
