//
//  FaceEnterViewModel2.h
//  framework
//
//  Created by 黄成实 on 2018/6/20.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FaceLoginViewDelegate<BaseRequestDelegate>

-(void)updatePreviewImage:(UIImage *)image;
-(void)onCaptureError:(NSString *)errorStr;
-(void)onDetectFaceResult:(Boolean)success image:(UIImage *)image tips:(NSString *)tips;
-(void)onGoBack;
-(void)onProgress:(double)progress;


@end

@interface FaceLoginViewModel : NSObject

@property(weak, nonatomic)id<FaceLoginViewDelegate> delegate;
@property(assign, nonatomic)CGRect previewRect;
@property(assign, nonatomic)CGRect detectRect;

//初始化人脸识别设置
-(void)setupFaceDetect;

//开始人脸识别
-(void)startFaceDetect;

//停止人脸识别
-(void)stopFaceDetect;

//app隐藏
-(void)appResign;

//app激活
-(void)appActive;

//返回
-(void)goBack;

//比对人脸
-(void)verifyImage:(NSString *)imagePath;

@end
