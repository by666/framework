//
//  BindPhoneViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/9.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PhoneDelegate

-(void)OnBindPhoneNum:(Boolean)success msg:(NSString *)msg;

@end
@interface BindPhoneViewModel : NSObject

@property(weak, nonatomic)id <PhoneDelegate>delegate;

-(void)doBindPhoneNum:(NSString *)phoneNum;

@end
