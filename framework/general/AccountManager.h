//
//  AccountManager.h
//  framework
//
//  Created by 黄成实 on 2018/4/24.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
#import "LiveModel.h"
#import "MainModel.h"
#import "ApplyModel.h"
@interface AccountManager : NSObject
SINGLETON_DECLARATION(AccountManager)

//存储用户账户信息
-(void)saveUserModel:(UserModel *)model;

//获取用户账户信息
-(UserModel *)getUserModel;

//清除用户账户信息
-(void)clearUserModel;


////////////////////////////////////

//存储用户居住信息
-(void)saveLiveModel:(LiveModel *)model;

//获取用户居住信息
-(LiveModel *)getLiveModel;

//清除用户居住信息
-(void)clearLiveModel;

////////////////////////////////////

//存储主页信息
-(void)saveMainModel:(MainModel *)model;

//获取主页信息
-(MainModel *)getMainModel;

//清除主页信息
-(void)clearMainModel;

////////////////////////////////////

//存储审核信息
-(void)saveApplyModel:(ApplyModel *)model;

//获取审核信息
-(ApplyModel *)getApplyModel;

//清除审核信息
-(void)clearApplyModel;

////////////////////////////////////

//是否登录
-(Boolean)isLogin;

//刷新token
-(void)refreshToken;


@end
