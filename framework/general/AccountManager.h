//
//  AccountManager.h
//  framework
//
//  Created by 黄成实 on 2018/4/24.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
@interface AccountManager : NSObject
SINGLETON_DECLARATION(AccountManager)

-(void)saveUserModel:(UserModel *)model;

@end
