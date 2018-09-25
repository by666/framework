//
//  VideoPage.h
//  framework
//
//  Created by by.huang on 2018/9/18.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "BaseViewController.h"
#import "UserModel.h"

@interface VideoPage : BaseViewController

+(void)show:(BaseViewController *)controller callID:(UInt64)callID userModel:(UserModel *)model;
-(void)updateTime:(int)time;

@end
