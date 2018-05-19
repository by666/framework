//
//  MessageSettingViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/18.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MessageSettingViewModel.h"

@implementation MessageSettingViewModel


-(instancetype)init{
    if(self == [super init]){
        _pushArray = @[MSG_MESSAGESETTING_PUSH_APP,MSG_MESSAGESETTING_PUSH_BELL,MSG_MESSAGESETTING_PUSH_TV];
        _expressArray = @[MSG_MESSAGESETTING_EXPRESS_APP,MSG_MESSAGESETTING_EXPRESS_SCREEN];
    }
    return self;
}
@end
