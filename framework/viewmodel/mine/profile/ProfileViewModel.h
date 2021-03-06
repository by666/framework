//
//  ProfileViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/16.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProfileModel.h"

@protocol ProfileViewDelegate<BaseRequestDelegate>

-(void)onUpdateProfile;
-(void)onGoFaceEnterPage;
-(void)onGoAuthStatuPage;

@end

@interface ProfileViewModel : NSObject

@property(weak, nonatomic)id <ProfileViewDelegate>delegate;
@property(strong, nonatomic)ProfileModel *model;
@property(strong, nonatomic)NSMutableArray *datas;

-(void)updateProfile;
-(void)goFaceEnterPage;
-(void)uploadHeadImage:(NSString *)imagePath;
-(void)goAuthStatuPage;

@end
