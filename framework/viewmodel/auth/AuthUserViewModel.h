//
//  AuthUserViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/24.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserAuthModel.h"
#import "CommunityPositionModel.h"
#import "UserCommitModel.h"

@protocol AuthUserViewDelegate<BaseRequestDelegate>

-(void)onGoCommunity;
-(void)submitUserInfo:(Boolean)success msg:(NSString *)errorMsg;

@end

@interface AuthUserViewModel : NSObject

@property(strong, nonatomic)UserAuthModel *data;
@property(weak, nonatomic)id<AuthUserViewDelegate> delegate;
@property(copy, nonatomic)NSString *districtUid;
@property(copy, nonatomic)NSString *fatherLocator;
@property(strong, nonatomic)UserCommitModel *userCommitModel;



-(void)getCommunityPosition:(CGFloat)longtitude latitude:(CGFloat)latitude;
-(void)getCommunityLayer:(CommunityPositionModel *)model;
-(void)getCommunityDoor:(NSString *)queryString;
-(void)submitUserInfo;

-(void)goCommunityPage;


@end
