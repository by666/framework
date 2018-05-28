//
//  AuthFaceViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/28.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AuthFaceViewModelDelegate

-(void)onAddPhoto;
-(void)onCommitStart;
-(void)onCommitProgress:(float)progress;
-(void)onCommitEnd;
-(void)onGoMainPage;

@end

@interface AuthFaceViewModel : NSObject

@property(weak, nonatomic)id<AuthFaceViewModelDelegate> delegate;

-(void)addPhoto;
-(void)commitUserInfo;
-(void)goMainPage;

@end
