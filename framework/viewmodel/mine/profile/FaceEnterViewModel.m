//
//  FaceEnterViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/16.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "FaceEnterViewModel.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <QuartzCore/QuartzCore.h>
#import "PermissionDetector.h"
#import "UIImage+Extensions.h"
#import "UIImage+compress.h"
#import "iflyMSC/IFlyFaceSDK.h"
#import "CaptureManager.h"
#import "CanvasView.h"
#import "CalculatorTools.h"
#import "IFlyFaceImage.h"
#import "IFlyFaceResultKeys.h"
#import "STFileUtil.h"
#import "STTimeUtil.h"

@interface FaceEnterViewModel()<CaptureManagerDelegate>

@property(strong, nonatomic) AVCaptureVideoPreviewLayer *previewLayer;
@property(strong, nonatomic) CaptureManager *captureManager;
@property(strong, nonatomic) IFlyFaceDetector *faceDetector;
@property(strong, nonatomic) CanvasView *viewCanvas;

@property(strong, nonatomic) UIView *previewView;

@end

@implementation FaceEnterViewModel


-(void)startFaceDetect{
    
}

#pragma mark 初始化人脸识别
-(void)setupFaceDetect:(UIView *)previewView{
    
    self.previewView = previewView;
    CGFloat width = previewView.size.width;
    
    self.faceDetector=[IFlyFaceDetector sharedInstance];
    self.captureManager=[[CaptureManager alloc] init];
    self.captureManager.delegate=self;
    self.previewLayer=self.captureManager.previewLayer;
    
    self.captureManager.previewLayer.frame= CGRectMake(0, 0, width, width);
    self.captureManager.previewLayer.videoGravity=AVLayerVideoGravityResizeAspectFill;
    [self.previewView.layer addSublayer:self.captureManager.previewLayer];
    
    
    self.viewCanvas = [[CanvasView alloc] initWithFrame:self.captureManager.previewLayer.frame] ;
    [self.previewView addSubview:self.viewCanvas] ;
    self.viewCanvas.center=self.captureManager.previewLayer.position;
    self.viewCanvas.backgroundColor = [UIColor clearColor] ;
    
    [self.captureManager setup];
    [self.captureManager addObserver];
    
    [self.faceDetector setParameter:@"1" forKey:@"detect"];
    [self.faceDetector setParameter:@"1" forKey:@"align"];
}


#pragma mark 释放人脸识别
-(void)releaseCamera{
    [self.captureManager removeObserver];
    self.captureManager=nil;
    self.viewCanvas=nil;
}


#pragma mark 监听相机变化

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    [self.captureManager observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}


#pragma mark - Data Parser

- (void)showFaceLandmarksAndFaceRectWithPersonsArray:(NSMutableArray *)arrPersons{
    if (self.viewCanvas.hidden) {
        self.viewCanvas.hidden = NO ;
    }
    self.viewCanvas.arrPersons = arrPersons ;
    [self.viewCanvas setNeedsDisplay] ;
}

- (void)hideFace {
    if (!self.viewCanvas.hidden) {
        self.viewCanvas.hidden = YES ;
    }
}






#pragma mark 图片输出
-(void)onOutputFaceImage:(IFlyFaceImage*)faceImg{
    NSString* result=[self.faceDetector trackFrame:faceImg.data withWidth:faceImg.width height:faceImg.height direction:(int)faceImg.direction];
    NSError* error;
    NSData* resultData=[result dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* faceDic=[NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableContainers error:&error];
    if(!faceDic){
        return;
    }
    NSArray* faceArray=[faceDic objectForKey:KCIFlyFaceResultFace];
    if(IS_NS_COLLECTION_EMPTY(faceArray)){
        return;
    }
    if(_delegate){
        [_delegate onFaceDetectResult:YES image:faceImg.image];
    }
    
        
    faceImg.data=nil;
//    NSMethodSignature *sig = [self methodSignatureForSelector:@selector(praseTrackResult:OrignImage:)];
//    if (!sig) return;
//    NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:sig];
//    [invocation setTarget:self];
//    [invocation setSelector:@selector(praseTrackResult:OrignImage:)];
//    [invocation setArgument:&strResult atIndex:2];
//    [invocation setArgument:&faceImg atIndex:3];
//    [invocation retainArguments];
//    [invocation performSelectorOnMainThread:@selector(invoke) withObject:nil  waitUntilDone:NO];
    faceImg=nil;
}

#pragma mark 识别人脸结果
-(void)praseTrackResult:(NSString*)result OrignImage:(IFlyFaceImage*)faceImg{
    
    if(!result){
        return;
    }
    
    @try {
        NSError* error;
        NSData* resultData=[result dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary* faceDic=[NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableContainers error:&error];
        resultData=nil;
        if(!faceDic){
            return;
        }
        
        NSString* faceRet=[faceDic objectForKey:KCIFlyFaceResultRet];
        NSArray* faceArray=[faceDic objectForKey:KCIFlyFaceResultFace];
        faceDic=nil;
        
        int ret=0;
        if(faceRet){
            ret=[faceRet intValue];
        }
        //没有检测到人脸或发生错误
        if (ret || !faceArray || [faceArray count]<1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideFace];
            } ) ;
            return;
        }
        
        //检测到人脸
        NSMutableArray *arrPersons = [NSMutableArray array] ;
        for(id faceInArr in faceArray){
            if(faceInArr && [faceInArr isKindOfClass:[NSDictionary class]]){
                NSDictionary* positionDic=[faceInArr objectForKey:KCIFlyFaceResultPosition];
                NSString* rectString=[self praseDetect:positionDic OrignImage: faceImg];
                positionDic=nil;
                
                NSDictionary* landmarkDic=[faceInArr objectForKey:KCIFlyFaceResultLandmark];
                NSMutableArray* strPoints=[self praseAlign:landmarkDic OrignImage:faceImg];
                landmarkDic=nil;

                NSMutableDictionary *dicPerson = [NSMutableDictionary dictionary] ;
                if(rectString){
                    [dicPerson setObject:rectString forKey:RECT_KEY];
                }
                if(strPoints){
                    [dicPerson setObject:strPoints forKey:POINTS_KEY];
                }
                
                strPoints=nil;
                
                [dicPerson setObject:@"0" forKey:RECT_ORI];
                [arrPersons addObject:dicPerson] ;
                
                dicPerson=nil;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showFaceLandmarksAndFaceRectWithPersonsArray:arrPersons];
                } ) ;
            }
        }
        faceArray=nil;
    }
    @catch (NSException *exception) {
        NSLog(@"prase exception:%@",exception.name);
    }
    @finally {
    }
    
}


#pragma mark 处理旋转的图片
-(NSMutableArray*)praseAlign:(NSDictionary* )landmarkDic OrignImage:(IFlyFaceImage*)faceImg{
    if(!landmarkDic){
        return nil;
    }
    
    BOOL isFrontCamera=self.captureManager.videoDeviceInput.device.position==AVCaptureDevicePositionFront;
    CGFloat widthScaleBy = self.previewLayer.frame.size.width / faceImg.height;
    CGFloat heightScaleBy = self.previewLayer.frame.size.height / faceImg.width;
    
    NSMutableArray *arrStrPoints = [NSMutableArray array] ;
    NSEnumerator* keys=[landmarkDic keyEnumerator];
    for(id key in keys){
        id attr=[landmarkDic objectForKey:key];
        if(attr && [attr isKindOfClass:[NSDictionary class]]){
            id attr=[landmarkDic objectForKey:key];
            CGFloat x=[[attr objectForKey:KCIFlyFaceResultPointX] floatValue];
            CGFloat y=[[attr objectForKey:KCIFlyFaceResultPointY] floatValue];
            CGPoint p = CGPointMake(y,x);
            if(!isFrontCamera){
                p=pSwap(p);
                p=pRotate90(p, faceImg.height, faceImg.width);
            }
            p=pScale(p, widthScaleBy, heightScaleBy);
            [arrStrPoints addObject:NSStringFromCGPoint(p)];
        }
    }
    return arrStrPoints;
}

-(NSString*)praseDetect:(NSDictionary* )positionDic OrignImage:(IFlyFaceImage*)faceImg{
    if(!positionDic){
        return nil;
    }
    
    BOOL isFrontCamera=self.captureManager.videoDeviceInput.device.position==AVCaptureDevicePositionFront;
    CGFloat widthScaleBy = self.previewLayer.frame.size.width / faceImg.height;
    CGFloat heightScaleBy = self.previewLayer.frame.size.height / faceImg.width;
    
    CGFloat bottom =[[positionDic objectForKey:KCIFlyFaceResultBottom] floatValue];
    CGFloat top=[[positionDic objectForKey:KCIFlyFaceResultTop] floatValue];
    CGFloat left=[[positionDic objectForKey:KCIFlyFaceResultLeft] floatValue];
    CGFloat right=[[positionDic objectForKey:KCIFlyFaceResultRight] floatValue];
    
    
    float cx = (left+right)/2;
    float cy = (top + bottom)/2;
    float w = right - left;
    float h = bottom - top;
    
    float ncx = cy ;
    float ncy = cx ;
    
    CGRect rectFace = CGRectMake(ncx-w/2 ,ncy-w/2 , w, h);
    if(!isFrontCamera){
        rectFace=rSwap(rectFace);
        rectFace=rRotate90(rectFace, faceImg.height, faceImg.width);
    }
    rectFace=rScale(rectFace, widthScaleBy, heightScaleBy);
    return NSStringFromCGRect(rectFace);
}


-(void)goBack{
    if(_delegate){
        [_delegate onGoBack];
    }
}

@end
