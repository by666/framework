//
//  CarViewCell.h
//  framework
//
//  Created by 黄成实 on 2018/5/19.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarModel.h"

@interface CarViewCell : UITableViewCell

-(void)updateData:(CarModel *)model;
+(NSString *)identify;

@end
