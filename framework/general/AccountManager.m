//
//  AccountManager.m
//  framework
//
//  Created by 黄成实 on 2018/4/24.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "AccountManager.h"
#import "STUserDefaults.h"

@implementation AccountManager
SINGLETON_IMPLEMENTION(AccountManager)


///
-(void)saveUserModel:(UserModel *)model{
    [STUserDefaults saveModel:UD_USERMODEL model:model];
 }

-(UserModel *)getUserModel{
    if([STUserDefaults getModel:UD_USERMODEL]){
        return [STUserDefaults getModel:UD_USERMODEL];
    }
    return [UserModel new];
}

-(void)clearUserModel{
    [STUserDefaults removeModel:UD_USERMODEL];
}

///
-(void)saveLiveModel:(LiveModel *)model{
    [STUserDefaults saveModel:UD_LIVEMODEL model:model];
}

-(LiveModel *)getLiveModel{
    if([STUserDefaults getModel:UD_LIVEMODEL]){
        return [STUserDefaults getModel:UD_LIVEMODEL];
    }
    return [LiveModel new];
}

-(void)clearLiveModel{
    [STUserDefaults removeModel:UD_LIVEMODEL];
}


///
-(void)saveMainModel:(MainModel *)model{
    [STUserDefaults saveModel:UD_MAINMODEL model:model];
}

-(MainModel *)getMainModel{
    if([STUserDefaults getModel:UD_MAINMODEL]){
        return [STUserDefaults getModel:UD_MAINMODEL];
    }
    return [MainModel new];
}

-(void)clearMainModel{
    [STUserDefaults removeModel:UD_MAINMODEL];
}


//
-(void)saveApplyModel:(ApplyModel *)model{
    [STUserDefaults saveModel:UD_APPLYMODEL model:model];
}

-(ApplyModel *)getApplyModel{
    if([STUserDefaults getModel:UD_APPLYMODEL]){
        return [STUserDefaults getModel:UD_APPLYMODEL];
    }
    return [ApplyModel new];
}

-(void)clearApplyModel{
    [STUserDefaults removeModel:UD_APPLYMODEL];
}



-(Boolean)isLogin{
    UserModel *model = [self getUserModel];
    if(model && !IS_NS_STRING_EMPTY(model.token) && !IS_NS_STRING_EMPTY(model.userUid)){
        return YES;
    }
    return NO;
}

-(void)refreshToken{
    //todo
    
}

@end
