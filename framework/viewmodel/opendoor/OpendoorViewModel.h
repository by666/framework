//
//  OpendoorViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/6/6.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OpendoorViewDelegate<BaseRequestDelegate>

-(void)onDoShare:(NSString *)codeStr;

@end

@interface OpendoorViewModel : NSObject

@property(weak, nonatomic)id<OpendoorViewDelegate> delegate;

-(void)generateTempLock;
-(void)doShare:(NSString *)codeStr;

@end
