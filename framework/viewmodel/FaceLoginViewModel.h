//
//  FaceLoginViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/10.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FaceLoginDelegate

-(void)onFaceDetectResult:(Boolean)success;
-(void)onGoMainPage;
-(void)onDetectOutOfTime;

@end

@interface FaceLoginViewModel : NSObject

@property(weak, nonatomic)id <FaceLoginDelegate>delegate;

-(void)startFaceDetect;

-(void)goMainPage;

-(void)detectOutOfTime;

@end
