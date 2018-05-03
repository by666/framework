//
//  STPUtil.h
//  gogo
//
//  Created by by.huang on 2017/10/21.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STPUtil : NSObject

//比例宽
+(int)getActualWidth : (int)width;

//比例高
+(int)getActualHeight : (int)height;

//APP版本
+(double)getAppVersion;

@end
