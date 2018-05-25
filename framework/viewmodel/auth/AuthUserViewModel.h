//
//  AuthUserViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/24.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserAuthModel.h"

@protocol AuthUserViewDelegate

-(void)onGoCommunity;
-(void)submitUserInfo:(Boolean)success msg:(NSString *)errorMsg;

@end

@interface AuthUserViewModel : NSObject

@property(strong, nonatomic)UserAuthModel *data;
@property(weak, nonatomic)id<AuthUserViewDelegate> delegate;


-(void)goCommunityPage;
-(void)submitUserInfo;

@end