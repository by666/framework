//
//  FaceEnterView.m
//  framework
//
//  Created by 黄成实 on 2018/5/16.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "FaceEnterView.h"
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
#import "CircularProgressView.h"
#import "STObserverManager.h"

@interface FaceEnterView()

@property(strong, nonatomic) FaceEnterViewModel *mViewModel;
@property(strong, nonatomic) UIView *previewView;
@property(strong, nonatomic) CircularProgressView *progressView;
@property(assign, nonatomic) float progress;


@end


@implementation FaceEnterView{
}

-(instancetype)initWithViewModel:(FaceEnterViewModel *)viewModel{
    if(self == [super init]){
        _progress = 0.0f;
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    
    UILabel *titieLabel = [[UILabel alloc]initWithFont:STFont(18) text:MSG_FACEENTER_TITLE textAlignment:NSTextAlignmentCenter textColor:c19 backgroundColor:nil multiLine:NO];
    titieLabel.frame = CGRectMake(0, STHeight(30), ScreenWidth, STHeight(18));
    [self addSubview:titieLabel];
    
    UILabel *subLabel = [[UILabel alloc]initWithFont:STFont(14) text:MSG_FACEENTER_SUBTITLE textAlignment:NSTextAlignmentCenter textColor:c12 backgroundColor:nil multiLine:NO];
    subLabel.frame = CGRectMake(0, STHeight(58), ScreenWidth, STHeight(14));
    [self addSubview:subLabel];
    
    
    CGFloat circlewidth = STWidth(217);
    _progressView = [[CircularProgressView alloc]initWithFrame:CGRectMake((ScreenWidth - circlewidth)/2, STHeight(103), circlewidth, circlewidth) backColor:c14 progressColor:c13 lineWidth:STWidth(2) audioURL:nil];
    _progressView.progress = _progress;
    [self addSubview:_progressView];
    
    CGFloat width = STWidth(206);
    self.previewView = [[UIView alloc]init];
    self.previewView.backgroundColor = [UIColor blackColor];
    self.previewView.frame = CGRectMake((ScreenWidth - width)/2, STHeight(108.5), width, width);
    self.previewView.layer.masksToBounds = YES;
    self.previewView.layer.cornerRadius = width/2;
    [self addSubview:self.previewView];

    [_mViewModel setupFaceDetect:self.previewView];
    
}


-(void)handlProgress{
    _progress += 0.02;
    _progressView.progress = _progress;
    [STLog print:[NSString stringWithFormat:@"%f",_progress]];
}


-(void)updateFaceDetectResult:(UIImage *)image{

    __weak FaceEnterView *weakSelf = self;
    dispatch_sync(dispatch_get_main_queue(), ^(){
        if(weakSelf.progress >= 1){
            [STLog print:@"识别成功"];
            NSString *imagePath = [STFileUtil saveImageFile:image];
            [[STObserverManager sharedSTObserverManager] sendMessage:Notify_UpdateAvatar msg:imagePath];
            [weakSelf.mViewModel releaseCamera];
            [weakSelf.mViewModel goBack];
            return;
        }
        [self handlProgress];
    });

}

@end

