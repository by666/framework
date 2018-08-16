//
//  WeChatManager.h
//  framework
//
//  Created by 黄成实 on 2018/7/24.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeChatManager : NSObject
SINGLETON_DECLARATION(WeChatManager)

-(void)doShare:(NSString *)title content:(NSString *)content image:(UIImage *)image url:(NSString *)url controller:(UIViewController *)controller;

@end
