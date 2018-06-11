//
//  DeviceShareCell.h
//  framework
//
//  Created by 黄成实 on 2018/6/8.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeviceShareModel.h"
@interface DeviceShareCell : UITableViewCell

@property(strong, nonatomic)UIButton *rentBtn;

-(void)updateData:(DeviceShareModel *)model;
+(NSString *)identify;


@end
