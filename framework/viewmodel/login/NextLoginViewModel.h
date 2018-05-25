//
//  NextLoginViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/14.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NextLoginDelegate

-(void)onGoLoginPage;
-(void)onGoFaceLoginPage;

@end

@interface NextLoginViewModel : NSObject

@property(weak, nonatomic) id<NextLoginDelegate> delegate;

-(void)goLoginPage;
-(void)goFaceLoginPage;

@end