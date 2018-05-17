//
//  FaceEnterViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/16.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FaceEnterViewDelegate

-(void)onFaceDetectResult:(Boolean)success image:(UIImage *)image;
-(void)onGoBack;

@end

@interface FaceEnterViewModel : NSObject

@property(weak, nonatomic)id <FaceEnterViewDelegate>delegate;

-(void)setupFaceDetect:(UIView *)previewView;
-(void)startFaceDetect;
-(void)releaseCamera;
-(void)goBack;

@end
