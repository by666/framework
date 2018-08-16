//
//  MainCardCell.h
//  framework
//
//  Created by 黄成实 on 2018/8/6.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MemberModel.h"

@interface MainCardCell : UICollectionViewCell

-(void)setData:(MemberModel *)model position:(NSInteger)position;
+(NSString *)identify;

@end
