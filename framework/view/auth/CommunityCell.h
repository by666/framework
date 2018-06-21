//
//  CommunityCell.h
//  framework
//
//  Created by 黄成实 on 2018/5/29.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunityPositionModel.h"

@interface CommunityCell : UITableViewCell

-(void)updateData:(CommunityPositionModel *)model key:(NSString *)keyStr;
+(NSString*)identify;

@end
