//
//  MessageSettingCell.h
//  framework
//
//  Created by 黄成实 on 2018/5/18.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageSettingCell : UITableViewCell

-(void)updateData:(NSString *)title;
+(NSString*)identify;

@end
