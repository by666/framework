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
    
    
    UILabel *titieLabel = [[UILabel alloc]initWithFont:STFont(17) text:MSG_FACEENTER_TITLE textAlignment:NSTextAlignmentCenter textColor:c08 backgroundColor:nil multiLine:NO];
    titieLabel.frame = CGRectMake(0, STHeight(40), ScreenWidth, STHeight(17));
    [self addSubview:titieLabel];
    
    UILabel *subLabel = [[UILabel alloc]initWithFont:STFont(14) text:MSG_FACEENTER_SUBTITLE textAlignment:NSTextAlignmentCenter textColor:c12 backgroundColor:nil multiLine:NO];
    subLabel.frame = CGRectMake(0, STHeight(68), ScreenWidth, STHeight(14));
    [self addSubview:subLabel];
    
    
    CGFloat circlewidth = STWidth(217);
    _progressView = [[CircularProgressView alloc]initWithFrame:CGRectMake((ScreenWidth - circlewidth)/2, STHeight(113), circlewidth, circlewidth) backColor:c14 progressColor:c13 lineWidth:STWidth(4) audioURL:nil];
    _progressView.progress = _progress;
    [self addSubview:_progressView];
    
    CGFloat width = STWidth(200);
    _previewView = [[UIImageView alloc]init];
    _previewView.backgroundColor = [UIColor blackColor];
    _previewView.frame = CGRectMake((ScreenWidth - width)/2, STHeight(121.5), width, width);
    _previewView.layer.masksToBounds = YES;
    _previewView.layer.cornerRadius = width/2;
    _previewView.contentMode = UIViewContentModeScaleAspectFill;
    _previewView.clipsToBounds = YES;
    [self addSubview:_previewView];
    
    UIView *tipsView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, STHeight(50))];
    tipsView.backgroundColor = [c35 colorWithAlphaComponent:0.6f];
    [_previewView addSubview:tipsView];
    
    _subLabel = [[UILabel alloc]initWithFont:STFont(16) text:MSG_FACEENTER_SUBTITLE textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    _subLabel.frame = CGRectMake(0, STHeight(23), width , STHeight(16));
    [tipsView addSubview:_subLabel];
    
    float scaleValue = 0.7f;
    _mViewModel.previewRect = CGRectMake(_previewView.frame.origin.x- _previewView.frame.size.width*(1/scaleValue-1)/2.0, _previewView.frame.origin.y - _previewView.frame.size.height*(1/scaleValue-1)/2.0 - 60 + StatuBarHeight + NavigationBarHeight, _previewView.frame.size.width/scaleValue, _previewView.frame.size.height/scaleValue);
    _mViewModel.detectRect = CGRectMake(ScreenWidth*(1-scaleValue)/2.0, ScreenHeight*(1-scaleValue)/2.0, ScreenWidth*scaleValue, ScreenHeight*scaleValue);
    
    
    self.animaView = [[UIView alloc] initWithFrame:CGRectMake((ScreenWidth - width)/2, STHeight(118.5), width, width)];
    self.animaView.backgroundColor = [UIColor whiteColor];
    self.animaView.layer.masksToBounds = YES;
    self.animaView.layer.cornerRadius = width/2;
    self.animaView.alpha = 0;
    [self addSubview:self.animaView];

    
    
}


-(void)handlProgress{
    _progress += 0.2f;
    _progressView.progress = _progress;
    [STLog print:[NSString stringWithFormat:@"%f",_progress]];
}


-(void)updatePreviewImage:(UIImage *)image{

    WS(weakSelf)
    dispatch_sync(dispatch_get_main_queue(), ^(){
        weakSelf.previewView.image = image;
    });
    
}



-(void)onDetectFaceResult:(Boolean)success image:(UIImage *)image tips:(NSString *)tips{
    WS(weakSelf)
    dispatch_main_async_safe(^{
        weakSelf.subLabel.text = tips;
        if(success){
            weakSelf.progress = 1.0f;
            weakSelf.progressView.progress = 1.0f;
            [weakSelf handleSuccess:image];
        }else{
            if(weakSelf.progress <= 0.8f){
                if(![tips isEqualToString:@"把脸移入框内"]){
                    [self handlProgress];
                }
            }
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
