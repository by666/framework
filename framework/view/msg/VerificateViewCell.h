//
//  VerificateViewCell.h
//  framework
//
//  Created by 黄成实 on 2018/5/31.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleContentModel.h"

@interface VerificateViewCell : UITableViewCell

-(void)updateData:(TitleContentModel *)model position:(NSInteger)position;
+(NSString*)identify;

@end
