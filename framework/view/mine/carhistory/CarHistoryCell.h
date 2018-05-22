//
//  CarHistoryCell.h
//  framework
//
//  Created by 黄成实 on 2018/5/22.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarHistoryModel.h"

@interface CarHistoryCell : UITableViewCell

-(void)updateData:(CarHistoryModel *)model;
+(NSString *)identify;


@end
