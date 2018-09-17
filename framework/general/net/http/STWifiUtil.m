//
//  STWifiUtil.m
//  framework
//
//  Created by 黄成实 on 2018/8/17.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "STWifiUtil.h"

@implementation STWifiUtil


+(Boolean)isWifiAvailable{
    NSString *urlStr = @"http://captive.apple.com";
    NSString *newUrlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:newUrlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:3];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSString* result1 = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSString *str = [self flattenHTML:result1];
    NSString *nstr = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    if ([nstr isEqualToString:@"Success"])
    {
     
        return YES;
    }
    return NO;
}


+ (NSString *)flattenHTML:(NSString *)html {
    
    NSString *text = nil;
    NSScanner *theScanner = [NSScanner scannerWithString:html];
    
    while ([theScanner isAtEnd] == NO) {
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        [theScanner scanUpToString:@">" intoString:&text] ;
        html = [html stringByReplacingOccurrencesOfString:
                [NSString stringWithFormat:@"%@>", text]
                                               withString:@""];
    }
    return html;
}


@end
