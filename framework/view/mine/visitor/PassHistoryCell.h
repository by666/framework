//
//  PassHistoryCell.h
//  framework
//
//  Created by 黄成实 on 2018/6/27.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PassHistoryModel.h"

@interface PassHistoryCell : UITableViewCell

-(void)updateData:(PassHistoryModel *)model;
+(NSString *)identify;

@end
