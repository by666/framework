//
//  MessageCell.h
//  framework
//
//  Created by 黄成实 on 2018/5/30.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"

@interface MessageCell : UITableViewCell

-(void)updateData:(MessageModel *)model;
+(NSString*)identify;

@end
