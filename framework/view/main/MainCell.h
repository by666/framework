//
//  MainCell.h
//  framework
//
//  Created by 黄成实 on 2018/6/7.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainCell : UICollectionViewCell

-(void)setData:(NSString *)title imageStr:(NSString *)imageStr;
+(NSString *)identify;

@end