//
//  SystemMsgCell.h
//  framework
//
//  Created by 黄成实 on 2018/6/1.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SystemMsgModel.h"

@interface SystemMsgCell : UITableViewCell

-(void)updateData:(SystemMsgModel *)model;
+(NSString*)identify;

@end
