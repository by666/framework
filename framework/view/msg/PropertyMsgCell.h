//
//  PropertyMsgCell.h
//  framework
//
//  Created by 黄成实 on 2018/6/1.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PropertyMsgModel.h"

@interface PropertyMsgCell : UITableViewCell

-(void)updateData:(PropertyMsgModel *)model;
+(NSString*)identify;

@end
