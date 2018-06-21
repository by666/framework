//
//  AuthFaceViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/28.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserCommitModel.h"
@protocol AuthFaceViewModelDelegate<BaseRequestDelegate>

-(void)onAddPhoto;
-(void)onGoMainPage;

@end

@interface AuthFaceViewModel : NSObject
@property(weak, nonatomic)id<AuthFaceViewModelDelegate> delegate;
@property(strong, nonatomic)UserCommitModel *userCommitModel;
-(instancetype)initWithModel:(UserCommitModel *)model;

-(void)addPhoto;
-(void)commitUserInfo;
-(void)goMainPage;

@end
