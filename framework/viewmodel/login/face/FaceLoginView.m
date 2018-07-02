//
//  FaceEnterView2.m
//  framework
//
//  Created by 黄成实 on 2018/6/20.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "FaceLoginView.h"
#import "CircularProgressView.h"
#import "FaceLoginViewModel.h"
#import "STObserverManager.h"
#import "STFileUtil.h"
#import "STTimeUtil.h"
#import "STUploadImageUtil.h"
@interface FaceLoginView()

@property(strong, nonatomic) FaceLoginViewModel *mViewModel;
@property(strong, nonatomic) UIImageView *previewView;
@property(strong, nonatomic) CircularProgressView *progressView;
@property(assign, nonatomic) CGFloat progress;
@property(strong, nonatomic) UILabel *subLabel;
@property (nonatomic, retain) UIView *animaView;

@end

@implementation FaceLoginView


-(instancetype)initWithViewModel:(FaceLoginViewModel *)viewModel{
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
    
    _mViewModel.previewRect = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    _mViewModel.detectRect = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);

    self.animaView = [[UIView alloc] initWithFrame:CGRectMake((ScreenWidth - width)/2, STHeight(108.5), width, width)];
    self.animaView.backgroundColor = [UIColor whiteColor];
    self.animaView.layer.masksToBounds = YES;
    self.animaView.layer.cornerRadius = width/2;
    self.animaView.alpha = 0;
    [self addSubview:self.animaView];

    
}


-(void)onProgress:(double)progress{
    _progressView.progress = progress;
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
            NSString *imagePath = [STFileUtil saveImageFile:image];
            [weakSelf.mViewModel verifyImage:imagePath];
        }else{
            
        }
    });
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
}






@end
