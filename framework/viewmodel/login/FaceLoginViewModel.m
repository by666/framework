//
//  FaceEnterViewModel2.m
//  framework
//
//  Created by 黄成实 on 2018/6/20.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "FaceLoginViewModel.h"
#import <IDLFaceSDK/IDLFaceSDK.h>
#import <AVFoundation/AVFoundation.h>
#import "VideoCaptureDevice.h"
#import "STNetUtil.h"
#import "AccountManager.h"
#import "STUserDefaults.h"
#import "WYManager.h"


@interface FaceLoginViewModel()<CaptureDataOutputProtocol>

@property(assign, nonatomic)Boolean hasFinished;
@property(strong, nonatomic)VideoCaptureDevice *videoCapture;
@property(assign, nonatomic)float progress;

@end

@implementation FaceLoginViewModel

//设置人脸识别
-(void)setupFaceDetect{
    
    if ([[FaceSDKManager sharedInstance] canWork]) {
        NSString* licensePath = [[NSBundle mainBundle] pathForResource:FACE_LICENSE_NAME ofType:FACE_LICENSE_SUFFIX];
        [[FaceSDKManager sharedInstance] setLicenseID:FACE_LICENSE_ID andLocalLicenceFile:licensePath];
    }
    
    _videoCapture = [[VideoCaptureDevice alloc] init];
    _videoCapture.delegate = self;
    
    // 设置最小检测人脸阈值
    [[FaceSDKManager sharedInstance] setMinFaceSize:100];
    
    // 设置截取人脸图片大小
    [[FaceSDKManager sharedInstance] setCropFaceSizeWidth:400];
    
    // 设置人脸遮挡阀值
    [[FaceSDKManager sharedInstance] setOccluThreshold:0.3];
    
    // 设置亮度阀值
    [[FaceSDKManager sharedInstance] setIllumThreshold:95];
    
    // 设置图像模糊阀值
    [[FaceSDKManager sharedInstance] setBlurThreshold:0.3];
    
    // 设置头部姿态角度
    [[FaceSDKManager sharedInstance] setEulurAngleThrPitch:6 yaw:2 roll:6];
    
    // 设置是否进行人脸图片质量检测
    [[FaceSDKManager sharedInstance] setIsCheckQuality:YES];
    
    // 设置超时时间
    [[FaceSDKManager sharedInstance] setConditionTimeout:60];
    
    // 设置人脸检测精度阀值
    [[FaceSDKManager sharedInstance] setNotFaceThreshold:0.393241];
    
    // 设置照片采集张数
    [[FaceSDKManager sharedInstance] setMaxCropImageNum:1];

    
}


-(void)startCountTime{
    WS(weakSelf)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(FACE_DETECT_OVERTIME * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if(!weakSelf.hasFinished){
            [weakSelf.delegate onShowOvertimeDialog];
            [weakSelf stopFaceDetect];
        }
    });
}


-(void)startFaceDetect{
    _hasFinished = NO;
    _videoCapture.runningStatus = YES;
    [_videoCapture startSession];
    [[IDLFaceDetectionManager sharedInstance] startInitial];
    [self startCountTime];
}

-(void)stopFaceDetect{
    _hasFinished = YES;
    _videoCapture.runningStatus = NO;
    [IDLFaceDetectionManager.sharedInstance reset];
}


-(void)appResign{
    _hasFinished = YES;
    [IDLFaceDetectionManager.sharedInstance reset];
}

- (void)appActive{
    _hasFinished = NO;
}

#pragma mark - CaptureDataOutputProtocol

- (void)captureOutputSampleBuffer:(UIImage *)image {
    if(_delegate){
        [_delegate updatePreviewImage:image];
    }
    [self faceProcesss:image];
}

- (void)captureError {
    NSString *errorStr = @"出现未知错误，请检查相机设置";
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        errorStr = @"相机权限受限,请在设置中启用";
    }
    if(_delegate){
        [_delegate onCaptureError:errorStr];
    }
}



- (void)faceProcesss:(UIImage *)image{
    if(_hasFinished){
        return;
    }
    [[IDLFaceDetectionManager sharedInstance] detectStratrgyWithImage:image previewRect:_previewRect detectRect:_detectRect completionHandler:^(NSDictionary *images, DetectRemindCode remindCode) {
        switch (remindCode) {
            case DetectRemindCodeOK: {
                if (images[@"bestImage"] != nil && [images[@"bestImage"] count] != 0) {
                    NSData* data = [[NSData alloc] initWithBase64EncodedString:[images[@"bestImage"] lastObject] options:NSDataBase64DecodingIgnoreUnknownCharacters];
                    UIImage* outImage = [UIImage imageWithData:data];
                    [self warningStatus:CommonStatus warning:@"非常好" image:outImage];
                }
                break;
            }
            case DetectRemindCodePitchOutofDownRange:
                [self warningStatus:PoseStatus warning:@"建议略微抬头"];
                break;
            case DetectRemindCodePitchOutofUpRange:
                [self warningStatus:PoseStatus warning:@"建议略微低头"];
                break;
            case DetectRemindCodeYawOutofLeftRange:
                [self warningStatus:PoseStatus warning:@"建议略微向右转头"];
                break;
            case DetectRemindCodeYawOutofRightRange:
                [self warningStatus:PoseStatus warning:@"建议略微向左转头"];
                break;
            case DetectRemindCodePoorIllumination:
                [self warningStatus:CommonStatus warning:@"光线再亮些"];
                break;
            case DetectRemindCodeNoFaceDetected:
                [self warningStatus:CommonStatus warning:@"把脸移入框内"];
                break;
            case DetectRemindCodeImageBlured:
                [self warningStatus:CommonStatus warning:@"请保持不动"];
                break;
            case DetectRemindCodeOcclusionLeftEye:
                [self warningStatus:occlusionStatus warning:@"左眼有遮挡"];
                break;
            case DetectRemindCodeOcclusionRightEye:
                [self warningStatus:occlusionStatus warning:@"右眼有遮挡"];
                break;
            case DetectRemindCodeOcclusionNose:
                [self warningStatus:occlusionStatus warning:@"鼻子有遮挡"];
                break;
            case DetectRemindCodeOcclusionMouth:
                [self warningStatus:occlusionStatus warning:@"嘴巴有遮挡"];
                break;
            case DetectRemindCodeOcclusionLeftContour:
                [self warningStatus:occlusionStatus warning:@"左脸颊有遮挡"];
                break;
            case DetectRemindCodeOcclusionRightContour:
                [self warningStatus:occlusionStatus warning:@"右脸颊有遮挡"];
                break;
            case DetectRemindCodeOcclusionChinCoutour:
                [self warningStatus:occlusionStatus warning:@"下颚有遮挡"];
                break;
            case DetectRemindCodeTooClose:
                [self warningStatus:CommonStatus warning:@"手机拿远一点"];
                break;
            case DetectRemindCodeTooFar:
                [self warningStatus:CommonStatus warning:@"手机拿近一点"];
                break;
            case DetectRemindCodeBeyondPreviewFrame:
                [self warningStatus:CommonStatus warning:@"把脸移入框内"];
                break;
            case DetectRemindCodeVerifyInitError:
                [self warningStatus:CommonStatus warning:@"验证失败"];
                break;
            case DetectRemindCodeVerifyDecryptError:
                [self warningStatus:CommonStatus warning:@"验证失败"];
                break;
            case DetectRemindCodeVerifyInfoFormatError:
                [self warningStatus:CommonStatus warning:@"验证失败"];
                break;
            case DetectRemindCodeVerifyExpired:
                [self warningStatus:CommonStatus warning:@"验证失败"];
                break;
            case DetectRemindCodeVerifyMissRequiredInfo:
                [self warningStatus:CommonStatus warning:@"验证失败"];
                break;
            case DetectRemindCodeVerifyInfoCheckError:
                [self warningStatus:CommonStatus warning:@"验证失败"];
                break;
            case DetectRemindCodeVerifyLocalFileError:
                [self warningStatus:CommonStatus warning:@"验证失败"];
                break;
            case DetectRemindCodeVerifyRemoteDataError:
                [self warningStatus:CommonStatus warning:@"验证失败"];
                break;
            case DetectRemindCodeTimeout: {
                [self warningStatus:CommonStatus warning:@"超时"];
                break;
            }

            default:
                break;
        }

    }];
}

-(void)warningStatus:(WarningStatus)statu warning:(NSString *)warningStr{
    [self warningStatus:statu warning:warningStr image:nil];
}

-(void)warningStatus:(WarningStatus)statu warning:(NSString *)warningStr image:(UIImage *)image{
    if(_delegate){
        if(image != nil){
            [_delegate onDetectFaceResult:YES image:image tips:warningStr];
        }else{
            [_delegate onDetectFaceResult:NO image:nil tips:warningStr];
        }
    }

}

-(void)goBack{
    if(_delegate){
        [_delegate onGoBack];
    }
}


-(void)verifyImage:(NSString *)imagePath{
    if(!_hasFinished){
        _hasFinished = YES;
    }else{
        return;
    }
    if(_delegate){
        WS(weakSelf)
        [[STUploadImageUtil sharedSTUploadImageUtil]uploadImageForOSS:imagePath success:^(NSString *imageUrl){
            [weakSelf verifyByServer:imageUrl];
        } failure:^(NSString *errorStr) {
            [weakSelf.delegate onRequestFail:errorStr];
        } progress:^(double progress) {
            weakSelf.progress = (progress/100) * 0.5f;
            [weakSelf.delegate onProgress:weakSelf.progress];
            
        }];
    }

}

-(void)verifyByServer:(NSString *)faceUrl{
    [self startWait];
    if(_delegate){
        UserModel *userModel = [[AccountManager sharedAccountManager] getUserModel];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        dic[@"faceUrl"] = faceUrl;
        dic[@"userUid"] = userModel.userUid;
        dic[@"registrationId"] = [STUserDefaults getKeyValue:UD_PUSHID];
        WS(weakSelf)
        [STNetUtil post:URL_FACE_LOGIN content:dic.mj_JSONString success:^(RespondModel *respondModel) {
            if([respondModel.status isEqualToString:STATU_SUCCESS]){
                UserModel *model = [[AccountManager sharedAccountManager]getUserModel];
                model.token = [respondModel.data objectForKey:@"token"];
                model.userUid = [respondModel.data objectForKey:@"userUid"];
                WYUserModel *wyUserModel = [WYUserModel mj_objectWithKeyValues:[respondModel.data objectForKey:@"neteaseUser"]];
                [[WYManager sharedWYManager]doLogin:wyUserModel.accId psw:wyUserModel.token];
                [[AccountManager sharedAccountManager]saveWYUserModel:wyUserModel];
                [[AccountManager sharedAccountManager]saveUserModel:model];
                weakSelf.progress = 1.0f;
                [weakSelf.delegate onProgress:weakSelf.progress];
                [weakSelf.delegate onRequestSuccess:respondModel data:nil];
            }else{
                [weakSelf.delegate onRequestFail:respondModel.msg];
            }
        } failure:^(int errorCode) {
            [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
        } progress:^(double progress) {
            [STLog print:[NSString stringWithFormat:@"进度:%.2f",progress]];
        }];
    }
}

-(void)startWait{
    if(_progress >= 1.0f){
        return;
    }
    _progress += 0.05;
    WS(weakSelf)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.delegate onProgress:weakSelf.progress];
        [weakSelf startWait];
    });

}

@end
