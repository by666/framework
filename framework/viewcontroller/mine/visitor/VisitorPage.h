//
//  VisitorPage.h
//  framework
//
//  Created by 黄成实 on 2018/5/15.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "BaseViewController.h"
#import "VisitorModel.h"

@interface VisitorPage : BaseViewController

+(void)show:(BaseViewController *)controller type:(VisitorType)type;

+(void)show:(BaseViewController *)controller type:(VisitorType)type model:(VisitorModel *)model;

@end
