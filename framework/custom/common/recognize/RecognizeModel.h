//
//  RecognizeModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/29.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecognizeModel : NSObject

@property(copy,nonatomic)NSString *title;
@property(assign, nonatomic)Boolean selected;


+(NSMutableArray *)getTestDatas:(NSString *)str;

@end
