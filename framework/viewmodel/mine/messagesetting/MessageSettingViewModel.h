//
//  MessageSettingViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/18.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MessageSettingViewDelegate

@end

@interface MessageSettingViewModel : NSObject

@property(strong, nonatomic)NSArray *pushArray;
@property(strong, nonatomic)NSArray *expressArray;

@property (weak, nonatomic) id<MessageSettingViewDelegate> delegate;

@end
