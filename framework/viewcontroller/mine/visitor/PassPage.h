//
//  PassPage.h
//  framework
//
//  Created by 黄成实 on 2018/6/27.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "BaseViewController.h"
#import "PassModel.h"
#import "VisitorModel.h"

@interface PassPage : BaseViewController

+(void)show:(BaseViewController *)controller passModel:(PassModel*)passModel visitorModel:(VisitorModel *)visitorModel needDelete:(Boolean)needDelete;

@end
