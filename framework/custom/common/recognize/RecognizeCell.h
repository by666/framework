//
//  RecognizeCell.h
//  framework
//
//  Created by 黄成实 on 2018/5/29.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecognizeModel.h"

@interface RecognizeCell : UITableViewCell

-(void)updateData:(RecognizeModel *)model;
+(NSString*)identify;

@end
