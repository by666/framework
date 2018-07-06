//
//  FaceEnterView2.m
//  framework
//
//  Created by 黄成实 on 2018/6/20.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "FaceEnterView2.h"
#import "CircularProgressView.h"
#import "FaceEnterViewModel2.h"
#import "STObserverManager.h"
#import "STFileUtil.h"
#import "STTimeUtil.h"
@interface FaceEnterView2()

@property(strong, nonatomic) FaceEnterViewModel2 *mViewModel;
@property(strong, nonatomic) UIImageView *previewView;
@property(strong, nonatomic) CircularProgressView *progressView;
@property(assign, nonatomic) float progress;
@property(strong, nonatomic) UILabel *subLabel;


//@property (nonatomic, readwrite, retain) UIImageView *displayImageView;
//@property (nonatomic, readwrite, assign) BOOL hasFinished;
//@property (nonatomic, readwrite, retain) UIImage* coverImage;
//@property (nonatomic, readwrite, assign) CGRect previewRect;
//@property (nonatomic, readwrite, assign) CGRect detectRect;


//@property (nonatomic, readwrite, retain) VideoCaptureDevice *videoCapture;
//@property (nonatomic, readwrite, retain) UILabel *remindLabel;
//@property (nonatomic, readwrite, retain) UILabel * remindDetailLabel;
//@property(strong, nonatomic) UIView *previewView;
//@property(strong, nonatomic) CircularProgressView *progressView;
//@property(assign, nonatomic) float progress;
@property (nonatomic, retain) UIView *animaView;

@end

@implementation FaceEnterView2


-(instancetype)initWithViewModel:(FaceEnterViewModel2 *)viewModel{
    if(self == [super init]){
        _progress = 0.0f;
        _mViewModel = viewModel;
        [self initView];
        [_mViewModel setupFaceDetect];
    }
    return self;
}

-(void)initView{
    
    UILabel *titieLabel = [[UILabel alloc]initWithFont:STFont(18) text:MSG_FACEENTER_TITLE textAlignment:NSTextAlignmentCenter textColor:c19 backgroundColor:nil multiLine:NO];
    titieLabel.frame = CGRectMake(0, STHeight(30), ScreenWidth, STHeight(18));
    [self addSubview:titieLabel];
    
    _subLabel = [[UILabel alloc]initWithFont:STFont(14) text:MSG_FACEENTER_SUBTITLE textAlignment:NSTextAlignmentCenter textColor:c12 backgroundColor:nil multiLine:NO];
    _subLabel.frame = CGRectMake(0, STHeight(58), ScreenWidth, STHeight(14));
    [self addSubview:_subLabel];
    
    
    CGFloat circlewidth = STWidth(217);
    _progressView = [[CircularProgressView alloc]initWithFrame:CGRectMake((ScreenWidth - circlewidth)/2, STHeight(103), circlewidth, circlewidth) backColor:c14 progressColor:c13 lineWidth:STWidth(2) audioURL:nil];
    _progressView.progress = _progress;
    [self addSubview:_progressView];
    
    CGFloat width = STWidth(206);
    _previewView = [[UIImageView alloc]init];
    _previewView.backgroundColor = [UIColor blackColor];
    _previewView.frame = CGRectMake((ScreenWidth - width)/2, STHeight(108.5), width, width);
    _previewView.layer.masksToBounds = YES;
    _previewView.layer.cornerRadius = width/2;
    _previewView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_previewView];
    
    float scaleValue = 0.7f;
    _mViewModel.previewRect = CGRectMake(_previewView.frame.origin.x- _previewView.frame.size.width*(1/scaleValue-1)/2.0, _previewView.frame.origin.y - _previewView.frame.size.height*(1/scaleValue-1)/2.0 - 60 + StatuBarHeight + NavigationBarHeight, _previewView.frame.size.width/scaleValue, _previewView.frame.size.height/scaleValue);
    _mViewModel.detectRect = CGRectMake(ScreenWidth*(1-scaleValue)/2.0, ScreenHeight*(1-scaleValue)/2.0, ScreenWidth*scaleValue, ScreenHeight*scaleValue);
    
//    [_mViewModel setupFaceDetect:self.previewView];
    
    
    //
    //    CGFloat circlewidth = STWidth(217);
    //    _progressView = [[CircularProgressView alloc]initWithFrame:CGRectMake((ScreenWidth - circlewidth)/2, STHeight(103), circlewidth, circlewidth) backColor:c14 progressColor:c13 lineWidth:STWidth(2) audioURL:nil];
    //    _progressView.progress = _progress;
    //    [self.view addSubview:_progressView];
    //
    //    CGFloat width = STWidth(206);
    //
    //    // 用于播放视频流
    //    self.detectRect = CGRectMake((ScreenWidth - width)/2, STHeight(108.5), width, width);
    //    self.previewRect = CGRectMake((ScreenWidth - width)/2, STHeight(108.5), width, width);
    //
    //
    //    _displayImageView = [[UIImageView alloc] initWithFrame:self.previewRect];
    //    _displayImageView.layer.masksToBounds = YES;
    //    _displayImageView.layer.cornerRadius = width/2;
    //    _displayImageView.contentMode = UIViewContentModeScaleAspectFill;
    //    [self.view addSubview:_displayImageView];
    //
    //
    //    // 提示框
    //    self.remindLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 400, ScreenWidth, 30)];
    //    self.remindLabel.textAlignment = NSTextAlignmentCenter;
    //    self.remindLabel.textColor = c01;
    //    self.remindLabel.font = [UIFont boldSystemFontOfSize:22.0];
    //    [self.view addSubview:self.remindLabel];
    //
    //
    //    self.remindDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,500, ScreenWidth, 30)];
    //    self.remindDetailLabel.font = [UIFont systemFontOfSize:20];
    //    self.remindDetailLabel.textColor = [UIColor blueColor];
    //    self.remindDetailLabel.textAlignment = NSTextAlignmentCenter;
    //    [self.view addSubview:self.remindDetailLabel];
    //
    //
        self.animaView = [[UIView alloc] initWithFrame:CGRectMake((ScreenWidth - width)/2, STHeight(108.5), width, width)];
        self.animaView.backgroundColor = [UIColor whiteColor];
        self.animaView.layer.masksToBounds = YES;
        self.animaView.layer.cornerRadius = width/2;
        self.animaView.alpha = 0;
        [self addSubview:self.animaView];
    
    
}


-(void)handlProgress{
    _progress += 0.02;
    _progressView.progress = _progress;
    [STLog print:[NSString stringWithFormat:@"%f",_progress]];
}


-(void)updatePreviewImage:(UIImage *)image{

    WS(weakSelf)
    dispatch_sync(dispatch_get_main_queue(), ^(){
        weakSelf.previewView.image = image;
//        if(weakSelf.progress >= 1){
//            [STLog print:@"识别成功"];
//            NSString *imagePath = [STFileUtil saveImageFile:@"head.jpg" image:image];
//            [[STObserverManager sharedSTObserverManager] sendMessage:Notify_UpdateAvatar msg:imagePath];
//            [weakSelf.mViewModel releaseCamera];
//            [weakSelf.mViewModel goBack];
//            return;
//        }
//        [self handlProgress];
    });
    
}



-(void)onDetectFaceResult:(Boolean)success image:(UIImage *)image tips:(NSString *)tips{
    
    WS(weakSelf)
    dispatch_main_async_safe(^{
        weakSelf.subLabel.text = tips;
        if(success){
            [weakSelf handleSuccess:image];
        }else{
            
        }
    });

}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
}


-(void)handleSuccess:(UIImage *)image{
    WS(weakSelf)
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.animaView.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf.animaView.alpha = 0;
        } completion:^(BOOL finished) {
            NSString *imagePath = [STFileUtil saveImageFile:image];
            [[STObserverManager sharedSTObserverManager] sendMessage:Notify_UpdateAvatar msg:imagePath];
            if(weakSelf.mViewModel){
                [weakSelf.mViewModel goBack];
            }
        }];
    }];
}



@end
