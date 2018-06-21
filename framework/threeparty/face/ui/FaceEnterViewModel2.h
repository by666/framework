//
//  FaceEnterViewModel2.h
//  framework
//
//  Created by 黄成实 on 2018/6/20.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FaceEnterViewDelegate2

-(void)updatePreviewImage:(UIImage *)image;
-(void)onCaptureError:(NSString *)errorStr;
-(void)onDetectFaceResult:(Boolean)success image:(UIImage *)image tips:(NSString *)tips;
-(void)onGoBack;

@end

@interface FaceEnterViewModel2 : NSObject

@property(weak, nonatomic)id<FaceEnterViewDelegate2> delegate;
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



@end
