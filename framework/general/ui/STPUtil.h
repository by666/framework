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
+(CGFloat)getActualWidth : (CGFloat)width;

//比例高
+(CGFloat)getActualHeight : (CGFloat)height;

//APP版本
+(double)getAppVersion;

//手机号是否有效
+(Boolean)isPhoneNumValid:(NSString *)phoneNum;

//验证码是否有效
+(Boolean)isVerifyCodeValid:(NSString *)verifyCode;

@end
