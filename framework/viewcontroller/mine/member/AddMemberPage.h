//
//  AddMemberPage.h
//  framework
//
//  Created by 黄成实 on 2018/5/17.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "BaseViewController.h"
#import "MemberModel.h"

@interface AddMemberPage : BaseViewController

+(void)show:(BaseViewController *)controller;

+(void)show:(BaseViewController *)controller model:(MemberModel *)model;

@end
