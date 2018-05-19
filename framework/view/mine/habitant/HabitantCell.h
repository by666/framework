//
//  HabitantCell.h
//  framework
//
//  Created by 黄成实 on 2018/5/18.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HabitantModel.h"

@interface HabitantCell : UITableViewCell

-(void)updateData:(HabitantModel *)model;
+(NSString *)identify;

@end
