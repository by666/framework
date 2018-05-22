//
//  VisitorPaymentCell.h
//  framework
//
//  Created by 黄成实 on 2018/5/22.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VisitorPaymentModel.h"

@interface VisitorPaymentCell : UITableViewCell

-(void)updateData:(VisitorPaymentModel *)model;
+(NSString *)identify;

@end
