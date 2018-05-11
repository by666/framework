//
//  FaceLoginView.m
//  framework
//
//  Created by 黄成实 on 2018/5/10.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "FaceLoginView.h"
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
#import "UIImage+Extensions.h"
#import "IFlyFaceImage.h"
#import "IFlyFaceResultKeys.h"
#import "STFileUtil.h"
#import "STTimeUtil.h"

@interface FaceLoginView()<CaptureManagerDelegate>

@property (nonatomic, retain ) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, retain ) CaptureManager             *captureManager;

@property (nonatomic, retain ) IFlyFaceDetector           *faceDetector;
@property (nonatomic, strong ) CanvasView                 *viewCanvas;

@property(strong, nonatomic)FaceLoginViewModel *mViewModel;

@property (nonatomic, strong) UIView *previewView;


@end


@implementation FaceLoginView{
    Boolean a;
}

-(instancetype)initWithViewModel:(FaceLoginViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
   
    [self setupCamera];

}


-(void)setupCamera{
    CGFloat width = STWidth(500);
    self.previewView = [[UIView alloc]init];
    self.previewView.backgroundColor = [UIColor blackColor];
    self.previewView.frame = CGRectMake((ScreenWidth - width)/2, STHeight(160), width, width);
    self.previewView.layer.masksToBounds = YES;
    self.previewView.layer.cornerRadius = width/2;
    [self addSubview:self.previewView];
    
    self.faceDetector=[IFlyFaceDetector sharedInstance];
    
    //初始化 CaptureSessionManager
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


-(void)releaseCamera{
    [self.captureManager removeObserver];
    self.captureManager=nil;
    self.viewCanvas=nil;
}
//- (void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//
//    [self.captureManager removeObserver];
//}
//
//-(void)dealloc{
//    self.captureManager=nil;
//    self.viewCanvas=nil;
//
//}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    [self.captureManager observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}


#pragma mark - Data Parser

- (void) showFaceLandmarksAndFaceRectWithPersonsArray:(NSMutableArray *)arrPersons{
    if (self.viewCanvas.hidden) {
        self.viewCanvas.hidden = NO ;
    }
    self.viewCanvas.arrPersons = arrPersons ;
    [self.viewCanvas setNeedsDisplay] ;
}

- (void) hideFace {
    if (!self.viewCanvas.hidden) {
        self.viewCanvas.hidden = YES ;
    }
}

-(NSString*)praseDetect:(NSDictionary* )positionDic OrignImage:(IFlyFaceImage*)faceImg{
    
    if(!positionDic){
        return nil;
    }
    
    
    
    // 判断摄像头方向
    BOOL isFrontCamera=self.captureManager.videoDeviceInput.device.position==AVCaptureDevicePositionFront;
    
    // scale coordinates so they fit in the preview box, which may be scaled
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

-(NSMutableArray*)praseAlign:(NSDictionary* )landmarkDic OrignImage:(IFlyFaceImage*)faceImg{
    if(!landmarkDic){
        return nil;
    }
    
    // 判断摄像头方向
    BOOL isFrontCamera=self.captureManager.videoDeviceInput.device.position==AVCaptureDevicePositionFront;
    
    // scale coordinates so they fit in the preview box, which may be scaled
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


-(void)onOutputFaceImage:(IFlyFaceImage*)faceImg{
//    NSString *imageStr =  [NSString stringWithFormat:@"%@.jpg",[STTimeUtil getCurrentTimeStamp]];
//    [STFileUtil saveImaqgeFile:imageStr image:[self fixOrientation:faceImg.image]];
    NSString* strResult;
//    NSString* strResult=[self.faceDetector trackFrame:faceImg.data withWidth:faceImg.width height:faceImg.height direction:(int)faceImg.direction];
//    NSLog(@"result:%@",strResult);
    
    //此处清理图片数据，以防止因为不必要的图片数据的反复传递造成的内存卷积占用。
    faceImg.data=nil;
    
    NSMethodSignature *sig = [self methodSignatureForSelector:@selector(praseTrackResult:OrignImage:)];
    if (!sig) return;
    NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:sig];
    [invocation setTarget:self];
    [invocation setSelector:@selector(praseTrackResult:OrignImage:)];
    [invocation setArgument:&strResult atIndex:2];
    [invocation setArgument:&faceImg atIndex:3];
    [invocation retainArguments];
    [invocation performSelectorOnMainThread:@selector(invoke) withObject:nil  waitUntilDone:NO];
    faceImg=nil;
}



- (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


@end
