//
//  SettingCell.h
//  framework
//
//  Created by 黄成实 on 2018/5/16.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleContentModel.h"

@interface SettingCell : UITableViewCell

-(void)updateData:(TitleContentModel *)model position:(NSInteger)position;
+(NSString*)identify;


@end
