//
//  FixHistoryCell.h
//  framework
//
//  Created by 黄成实 on 2018/6/8.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FixModel.h"

@interface FixHistoryCell : UITableViewCell

@property(strong, nonatomic)UIButton *expandBtn;

-(void)updateData:(FixModel *)model;
+(NSString *)identify;

@end
