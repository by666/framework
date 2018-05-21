//
//  PaymentRecordPage.h
//  framework
//
//  Created by 黄成实 on 2018/5/21.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface PaymentRecordPage : BaseViewController

//index进入时，选择的tab
+(void)show:(BaseViewController *)controller index:(NSInteger)index;

@end
