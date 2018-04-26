//
//  STConvertUtil.m
//  framework
//
//  Created by 黄成实 on 2018/4/26.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "STConvertUtil.h"

@implementation STConvertUtil


+(NSString *)DataToString:(NSData *)data{
  return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+(NSData *)StringToData:(NSString *)str{
    return [str dataUsingEncoding:NSUTF8StringEncoding];
}

+(NSString *)base64Encode:(NSString *)str{
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSData *base64Data = [data base64EncodedDataWithOptions:0];
    return[[NSString alloc]initWithData:base64Data encoding:NSUTF8StringEncoding];
}

+(NSString *)base64Decode:(NSString *)str{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}


@end
