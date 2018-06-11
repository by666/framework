//
//  DeviceShareOrderViewCell.h
//  framework
//
//  Created by 黄成实 on 2018/6/8.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleContentModel.h"

@interface DeviceShareOrderViewCell : UITableViewCell
@property(strong, nonatomic)UIButton *selectBtn;

-(void)updateData:(TitleContentModel *)model;
+(NSString *)identify;

@end
