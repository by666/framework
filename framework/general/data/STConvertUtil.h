//
//  STConvertUtil.h
//  framework
//
//  Created by 黄成实 on 2018/4/26.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STConvertUtil : NSObject

//data转string
+(NSString *)DataToString:(NSData *)data;

//string转data
+(NSData *)StringToData:(NSString *)str;

//base编码
+(NSString *)base64Encode:(NSString *)str;

//base64解码
+(NSString *)base64Decode:(NSString *)str;

@end
