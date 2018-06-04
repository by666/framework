//
//  MineCell.h
//  framework
//
//  Created by 黄成实 on 2018/5/16.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineCell : UITableViewCell

-(void)updateData:(NSString *)title image:(UIImage *)image hidden:(Boolean)hidden;
+(NSString*)identify;

@end
