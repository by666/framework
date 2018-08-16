//
//  MainCell2.h
//  framework
//
//  Created by 黄成实 on 2018/8/7.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleContentModel.h"

@interface MainCell2 : UICollectionViewCell

-(void)setData:(TitleContentModel *)model;
+(NSString *)identify;

@end
