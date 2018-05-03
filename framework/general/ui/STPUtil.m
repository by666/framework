
//
//  STPUtil.m
//  gogo
//
//  Created by by.huang on 2017/10/21.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "STPUtil.h"

@implementation STPUtil

+(int)getActualWidth : (int)width{
    return ScreenWidth * width / 750;
}

+(int)getActualHeight : (int)height{
    return ScreenHeight * height / 1334;
}

+(double)getAppVersion{
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDict objectForKey:@"CFBundleVersion"];
    return [currentVersion doubleValue];
}

@end
