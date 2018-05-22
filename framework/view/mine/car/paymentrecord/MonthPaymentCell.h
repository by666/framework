//
//  MonthPaymentCell.h
//  framework
//
//  Created by 黄成实 on 2018/5/22.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MonthPaymentModel.h"

@interface MonthPaymentCell : UITableViewCell


-(void)updateData:(MonthPaymentModel *)model;
+(NSString *)identify;


@end
