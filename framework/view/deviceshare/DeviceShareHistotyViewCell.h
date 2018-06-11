//
//  DeviceShareHistotyViewCell.h
//  framework
//
//  Created by 黄成实 on 2018/6/11.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeviceShareHistoryModel.h"

@interface DeviceShareHistotyViewCell : UITableViewCell

-(void)updateData:(DeviceShareHistoryModel *)model;
+(NSString *)identify;

@end
