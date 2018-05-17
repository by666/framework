//
//  ProfileModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/16.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProfileModel : NSObject


@property(strong, nonatomic)UIImage *image;
@property(copy, nonatomic)NSString *avatarUrl;
@property(copy, nonatomic)NSString *name;
@property(copy, nonatomic)NSString *gender;
@property(copy, nonatomic)NSString *birthday;
@property(copy, nonatomic)NSString *idNum;
@property(copy, nonatomic)NSString *identify;
@property(copy, nonatomic)NSString *phoneNum;

@end
