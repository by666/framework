
//
//  STPUtil.m
//  gogo
//
//  Created by by.huang on 2017/10/21.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "STPUtil.h"

@implementation STPUtil

+(CGFloat)getActualWidth : (CGFloat)width{
    return (ScreenWidth * width) / 375;
}

+(CGFloat)getActualHeight : (CGFloat)height{
    return (ScreenHeight * height) / 676;
}

+(double)getAppVersion{
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDict objectForKey:@"CFBundleVersion"];
    return [currentVersion doubleValue];
}

+(Boolean)isPhoneNumValid:(NSString *)phoneNum{
    if (IS_NS_STRING_EMPTY(phoneNum) ||  phoneNum.length != 11){
        return NO;
    }
    NSString *regex = @"^1(3[0-9]|4[0-9]|5[0-9]|8[0-9]|7[0-9])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [regextestmobile evaluateWithObject:phoneNum];
}

+(Boolean)isVerifyCodeValid:(NSString *)verifyCode{
    if(!IS_NS_STRING_EMPTY(verifyCode) && (verifyCode.length >= 4) && (verifyCode.length <=6)){
        return YES;
    }
    return NO;
}


+(CGSize)textSize:(NSString *)text maxWidth:(CGFloat)maxWidth font:(CGFloat)font{
   return [text boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
}



@end
