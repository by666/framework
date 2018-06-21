//
//  IFlyOnlineFaceDetectPage.m
//  framework
//
//  Created by 黄成实 on 2018/4/23.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "IFlyOnlineFaceDetectPage.h"
#import "UIImage+Extensions.h"
#import "UIImage+compress.h"
#import <iflyMSC/IFlyFaceSDK.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import "IFlyFaceResultKeys.h"
#import "PermissionDetector.h"
#import "STNetUtil.h"
#import "STConvertUtil.h"
#import "STFileUtil.h"

@interface IFlyOnlineFaceDetectPage ()<IFlyFaceRequestDelegate,
UINavigationControllerDelegate,
UIImagePickerControllerDelegate,
UIActionSheetDelegate>

@property (strong, nonatomic)UIButton *selectBtn;
@property (strong, nonatomic)UIButton *checkBtn;



@property (nonatomic,retain) IFlyFaceRequest * iFlySpFaceRequest;
@property (nonatomic,retain) CALayer *imgToUseCoverLayer;
@property (strong, nonatomic)UIImageView *imgToUse;
@property (nonatomic,retain) NSString *resultStings;


@end

@implementation IFlyOnlineFaceDetectPage{
    NSString *imagePath;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:c01];
    self.navigationItem.title = @"在线识别";
    self.iFlySpFaceRequest=[IFlyFaceRequest sharedInstance];
    [self.iFlySpFaceRequest setDelegate:self];
    [self initView];
}

-(void)initView{
    
    _imgToUse = [[UIImageView alloc]init];
    CGFloat h = StatuBarHeight + self.navigationController.navigationBar.height;
    _imgToUse.frame = CGRectMake(0, h, ScreenWidth, ScreenHeight - h - 50);
    _imgToUse.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_imgToUse];
    
    _selectBtn = [[UIButton alloc]init];
    _selectBtn.frame = CGRectMake(0,ScreenHeight - 50, ScreenWidth/2, 50);
    _selectBtn.backgroundColor = [UIColor greenColor];
    [_selectBtn setTitle:@"选择图片" forState:UIControlStateNormal];
    [_selectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:_selectBtn];
    [[_selectBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self doSelectPhoto];
    }];
    
    _checkBtn = [[UIButton alloc]init];
    _checkBtn.frame = CGRectMake(ScreenWidth/2,ScreenHeight - 50, ScreenWidth/2, 50);
    _checkBtn.backgroundColor = [UIColor blueColor];
    [_checkBtn setTitle:@"检测图片" forState:UIControlStateNormal];
    [_checkBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:_checkBtn];
    [[_checkBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self doCheckPhoto];
    }];
}

-(void)dealloc{
    self.iFlySpFaceRequest=nil;
    self.imgToUse=nil;
    self.imgToUseCoverLayer=nil;
    self.resultStings=nil;
}


#pragma mark 选择图片
-(void)doSelectPhoto{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {

    }];
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"照相机" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        [self doCamera];
    }];
    
    UIAlertAction *imageAction = [UIAlertAction actionWithTitle:@"图库" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        [self doPhotoLib];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:cameraAction];
    [alertController addAction:imageAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


//相机选择
-(void)doCamera{
    if(![PermissionDetector isCapturePermissionGranted]){
        [STLog print:@"没有相机权限"];
        return;
    }
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.modalPresentationStyle = UIModalPresentationFullScreen;
        if([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]){
            picker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        }
        
        picker.mediaTypes = @[(NSString*)kUTTypeImage];
        picker.allowsEditing = NO;
        picker.delegate = self;
        
        [self presentViewController:picker animated:YES completion:nil];

    }else{
        [STLog print:@"设备不可用"];
    }
}

//相册选择
-(void)doPhotoLib{
    if(![PermissionDetector isAssetsLibraryPermissionGranted]){
        [STLog print:@"没有相册权限"];
        return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.modalPresentationStyle = UIModalPresentationCurrentContext;
    if([UIImagePickerController isSourceTypeAvailable: picker.sourceType ]) {
        picker.mediaTypes = @[(NSString*)kUTTypeImage];
        picker.delegate = self;
        picker.allowsEditing = NO;
    }
    
    [self presentViewController:picker animated:YES completion:nil];
}



//图片回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    if(_imgToUseCoverLayer){
        _imgToUseCoverLayer.sublayers=nil;
        [_imgToUseCoverLayer removeFromSuperlayer];
        _imgToUseCoverLayer=nil;
    }
    
    UIImage* image=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
    //压缩图片
    _imgToUse.image = [[image fixOrientation] compressedImage];
    imagePath = [STFileUtil saveImageFile:image];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark 检测图片
-(void)doCheckPhoto{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
   
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    
    UIAlertAction *registerAction = [UIAlertAction actionWithTitle:@"注册图片" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        [self doRegister];
    }];
    
    UIAlertAction *verifyAction = [UIAlertAction actionWithTitle:@"验证图片" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        [self doVerify];
    }];
    
    UIAlertAction *faceAction = [UIAlertAction actionWithTitle:@"人脸检测" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        [self doFace];
    }];
    
    UIAlertAction *faceDetailAction = [UIAlertAction actionWithTitle:@"人脸关键点检测" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        [self doFaceDetail];
    }];
    
    UIAlertAction *ocrAction = [UIAlertAction actionWithTitle:@"OCR识别" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        [self doOcrDetect];
    }];
    
    UIAlertAction *petAction = [UIAlertAction actionWithTitle:@"宠物检测" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        [self doDetectPet];
    }];

    
    [alertController addAction:cancelAction];
    [alertController addAction:registerAction];
    [alertController addAction:verifyAction];
    [alertController addAction:faceAction];
    [alertController addAction:faceDetailAction];
    [alertController addAction:ocrAction];
    [alertController addAction:petAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark 注册到人脸库
-(void)doRegister{
    self.resultStings=nil;
    self.resultStings=[[NSString alloc] init];
    
    if(_imgToUseCoverLayer){
        _imgToUseCoverLayer.sublayers=nil;
        [_imgToUseCoverLayer removeFromSuperlayer];
        _imgToUseCoverLayer=nil;
    }

    [self.iFlySpFaceRequest setParameter:[IFlySpeechConstant FACE_REG] forKey:[IFlySpeechConstant FACE_SST]];
    [self.iFlySpFaceRequest setParameter:IFLY_FACE_APPID forKey:[IFlySpeechConstant APPID]];
    [self.iFlySpFaceRequest setParameter:IFLY_FACE_APPID forKey:@"auth_id"];
    [self.iFlySpFaceRequest setParameter:@"del" forKey:@"property"];
    //  压缩图片大小
    NSData* imgData=[_imgToUse.image compressedData];
    NSLog(@"reg image data length: %lu",(unsigned long)[imgData length]);
    [self.iFlySpFaceRequest sendRequest:imgData];
}

#pragma mark 验证图片是否在人脸库
-(void)doVerify{
    self.resultStings=nil;
    self.resultStings=[[NSString alloc] init];
    
    if(_imgToUseCoverLayer){
        _imgToUseCoverLayer.sublayers=nil;
        [_imgToUseCoverLayer removeFromSuperlayer];
        _imgToUseCoverLayer=nil;
    }
  
    
    [self.iFlySpFaceRequest setParameter:[IFlySpeechConstant FACE_VERIFY] forKey:[IFlySpeechConstant FACE_SST]];
    [self.iFlySpFaceRequest setParameter:IFLY_FACE_APPID forKey:[IFlySpeechConstant APPID]];
    [self.iFlySpFaceRequest setParameter:IFLY_FACE_APPID forKey:@"auth_id"];
    NSUserDefaults* userDefaults=[NSUserDefaults standardUserDefaults];
    NSString* gid=[userDefaults objectForKey:KCIFlyFaceResultGID];
    if(!gid){
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"结果" message:@"请先注册，或在设置中输入已注册的gid" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        alert=nil;
        return;
    }
    [self.iFlySpFaceRequest setParameter:gid forKey:[IFlySpeechConstant FACE_GID]];
    [self.iFlySpFaceRequest setParameter:@"2000" forKey:@"wait_time"];
    //  压缩图片大小
    NSData* imgData=[_imgToUse.image compressedData];
    NSLog(@"verify image data length: %lu",(unsigned long)[imgData length]);
    [self.iFlySpFaceRequest sendRequest:imgData];
}


#pragma mark 人脸识别
-(void)doFace{
    self.resultStings=nil;
    self.resultStings=[[NSString alloc] init];
    
    if(_imgToUseCoverLayer){
        _imgToUseCoverLayer.sublayers=nil;
        [_imgToUseCoverLayer removeFromSuperlayer];
        _imgToUseCoverLayer=nil;
    }
    [self.iFlySpFaceRequest setParameter:[IFlySpeechConstant FACE_DETECT] forKey:[IFlySpeechConstant FACE_SST]];
    [self.iFlySpFaceRequest setParameter:IFLY_FACE_APPID forKey:[IFlySpeechConstant APPID]];
    //  压缩图片大小
    NSData* imgData=[_imgToUse.image compressedData];
    NSLog(@"detect image data length: %lu",(unsigned long)[imgData length]);
    [self.iFlySpFaceRequest sendRequest:imgData];
}

#pragma mark 人脸详细点识别
-(void)doFaceDetail{
    self.resultStings=nil;
    self.resultStings=[[NSString alloc] init];
    
    if(_imgToUseCoverLayer){
        _imgToUseCoverLayer.sublayers=nil;
        [_imgToUseCoverLayer removeFromSuperlayer];
        _imgToUseCoverLayer=nil;
    }
    [self.iFlySpFaceRequest setParameter:[IFlySpeechConstant FACE_ALIGN] forKey:[IFlySpeechConstant FACE_SST]];
    [self.iFlySpFaceRequest setParameter:IFLY_FACE_APPID forKey:[IFlySpeechConstant APPID]];
    //  压缩图片大小
    NSData* imgData=[_imgToUse.image compressedData];
    NSLog(@"align image data length: %lu",(unsigned long)[imgData length]);
    [self.iFlySpFaceRequest sendRequest:imgData];

}

#pragma mark 回调
/**
 * 消息回调
 * @param eventType 消息类型
 * @param params 消息数据对象
 */
- (void) onEvent:(int) eventType WithBundle:(NSString*) params{
    NSLog(@"onEvent | params:%@",params);
}

/**
 * 数据回调，可能调用多次，也可能一次不调用
 * @param buffer 服务端返回的二进制数据
 */
- (void) onData:(NSData* )data{
    
    NSLog(@"onData | ");
    NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"result:%@",result);
    
    if (result) {
        self.resultStings=[self.resultStings stringByAppendingString:result];
    }
    
}

/**
 * 结束回调，没有错误时，error为null
 * @param error 错误类型
 */
- (void) onCompleted:(IFlySpeechError*) error{
    NSLog(@"onCompleted | error:%@",[error errorDesc]);
    NSString* errorInfo=[NSString stringWithFormat:@"错误码：%d\n 错误描述：%@",[error errorCode],[error errorDesc]];
    if(0!=[error errorCode]){
        [self performSelectorOnMainThread:@selector(showResultInfo:) withObject:errorInfo waitUntilDone:NO];
    }
    else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateFaceImage:self.resultStings];
        });
    }
}


-(void)updateFaceImage:(NSString*)result{
    NSError* error;
    NSData* resultData=[result dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* dic=[NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableContainers error:&error];
    if(dic){
        NSString* strSessionType=[dic objectForKey:KCIFlyFaceResultSST];
        //注册
        if([strSessionType isEqualToString:KCIFlyFaceResultReg]){
            [self praseRegResult:result];
        }
        //验证
        if([strSessionType isEqualToString:KCIFlyFaceResultVerify]){
            [self praseVerifyResult:result];
        }
        //检测
        if([strSessionType isEqualToString:KCIFlyFaceResultDetect]){
            [self praseDetectResult:result];
        }
        //关键点
        if([strSessionType isEqualToString:KCIFlyFaceResultAlign]){
            [self praseAlignResult:result];
        }
        
    }
}


#pragma mark 解析注册结果
-(void)praseRegResult:(NSString*)result{
    NSString *resultInfo = @"";
    NSString *resultInfoForLabel = @"";
    
    @try {
        NSError* error;
        NSData* resultData=[result dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary* dic=[NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableContainers error:&error];
        
        if(dic){
            NSString* strSessionType=[dic objectForKey:KCIFlyFaceResultSST];
            
            //注册
            if([strSessionType isEqualToString:KCIFlyFaceResultReg]){
                NSString* rst=[dic objectForKey:KCIFlyFaceResultRST];
                NSString* ret=[dic objectForKey:KCIFlyFaceResultRet];
                if([ret integerValue]!=0){
                    resultInfo=[resultInfo stringByAppendingFormat:@"注册错误\n错误码：%@",ret];
                }else{
                    if(rst && [rst isEqualToString:KCIFlyFaceResultSuccess]){
                        NSString* gid=[dic objectForKey:KCIFlyFaceResultGID];
                        resultInfo=[resultInfo stringByAppendingString:@"检测到人脸\n注册成功！"];
                        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
                        [defaults setObject:gid forKey:KCIFlyFaceResultGID];
                        resultInfoForLabel=[resultInfoForLabel stringByAppendingFormat:@"gid:%@",gid];
                    }else{
                        resultInfo=[resultInfo stringByAppendingString:@"未检测到人脸\n注册失败！"];
                    }
                }
            }
            [self performSelectorOnMainThread:@selector(showResultInfo:) withObject:resultInfo waitUntilDone:NO];
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"prase exception:%@",exception.name);
    }
    @finally {
    }
    
    
}


#pragma mark 解析验证结果
-(void)praseVerifyResult:(NSString*)result{
    NSString *resultInfo = @"";
    NSString *resultInfoForLabel = @"";
    
    @try {
        NSError* error;
        NSData* resultData=[result dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary* dic=[NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableContainers error:&error];
        
        if(dic){
            NSString* strSessionType=[dic objectForKey:KCIFlyFaceResultSST];
            
            if([strSessionType isEqualToString:KCIFlyFaceResultVerify]){
                NSString* rst=[dic objectForKey:KCIFlyFaceResultRST];
                NSString* ret=[dic objectForKey:KCIFlyFaceResultRet];
                if([ret integerValue]!=0){
                    if([ret integerValue] == 11700){
                        resultInfo=[resultInfo stringByAppendingString:@"未检测到人脸\n"];
                    }else{
                        resultInfo=[resultInfo stringByAppendingFormat:@"验证错误\n错误码：%@",ret];
                    }
                }else{
                    
                    if([rst isEqualToString:KCIFlyFaceResultSuccess]){
                        resultInfo=[resultInfo stringByAppendingString:@"检测到人脸\n"];
                    }else{
                        resultInfo=[resultInfo stringByAppendingString:@"未检测到人脸\n"];
                    }
                    NSString* verf=[dic objectForKey:KCIFlyFaceResultVerf];
                    NSString* score=[dic objectForKey:KCIFlyFaceResultScore];
                    if([verf boolValue]){
                        resultInfoForLabel=[resultInfoForLabel stringByAppendingFormat:@"score:%@\n",score];
                        resultInfo=[resultInfo stringByAppendingString:@"验证结果:验证成功!"];
                    }else{
                        NSUserDefaults* defaults=[NSUserDefaults standardUserDefaults];
                        NSString* gid=[defaults objectForKey:KCIFlyFaceResultGID];
                        resultInfoForLabel=[resultInfoForLabel stringByAppendingFormat:@"last reg gid:%@\n",gid];
                        resultInfo=[resultInfo stringByAppendingString:@"验证结果:验证失败!"];
                    }
                }
                
            }
            
            if([resultInfo length]<1){
                resultInfo=@"结果异常";
            }
            
            [self performSelectorOnMainThread:@selector(showResultInfo:) withObject:resultInfo waitUntilDone:NO];
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"prase exception:%@",exception.name);
    }
    @finally {
        
    }
    
    
}

#pragma mark 解析人脸信息
-(void)praseDetectResult:(NSString*)result{
    NSString *resultInfo = @"";
    NSString *resultInfoForLabel = @"";
    
    @try {
        NSError* error;
        NSData* resultData=[result dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary* dic=[NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableContainers error:&error];
        
        if(dic){
            NSString* strSessionType=[dic objectForKey:KCIFlyFaceResultSST];
            
            //检测
            if([strSessionType isEqualToString:KCIFlyFaceResultDetect]){
                NSString* rst=[dic objectForKey:KCIFlyFaceResultRST];
                NSString* ret=[dic objectForKey:KCIFlyFaceResultRet];
                if([ret integerValue]!=0){
                    resultInfo=[resultInfo stringByAppendingFormat:@"检测人脸错误\n错误码：%@",ret];
                }else{
                    resultInfo=[resultInfo stringByAppendingString:[rst isEqualToString:KCIFlyFaceResultSuccess]?@"检测到人脸轮廓":@"未检测到人脸轮廓"];
                }
                
                
                //绘图
                if(_imgToUseCoverLayer){
                    _imgToUseCoverLayer.sublayers=nil;
                    [_imgToUseCoverLayer removeFromSuperlayer];
                    _imgToUseCoverLayer=nil;
                }
                _imgToUseCoverLayer = [[CALayer alloc] init];
                
                
                NSArray* faceArray=[dic objectForKey:KCIFlyFaceResultFace];
                
                for(id faceInArr in faceArray){
                    
                    CALayer* layer= [[CALayer alloc] init];
                    layer.borderWidth = 2.0f;
                    [layer setCornerRadius:2.0f];
                    
                    float image_x, image_y, image_width, image_height;
                    if(_imgToUse.image.size.width/_imgToUse.image.size.height > _imgToUse.frame.size.width/_imgToUse.frame.size.height){
                        image_width = _imgToUse.frame.size.width;
                        image_height = image_width/_imgToUse.image.size.width * _imgToUse.image.size.height;
                        image_x = 0;
                        image_y = (_imgToUse.frame.size.height - image_height)/2;
                        
                    }else if(_imgToUse.image.size.width/_imgToUse.image.size.height < _imgToUse.frame.size.width/_imgToUse.frame.size.height)
                    {
                        image_height = _imgToUse.frame.size.height;
                        image_width = image_height/_imgToUse.image.size.height * _imgToUse.image.size.width;
                        image_y = 0;
                        image_x = (_imgToUse.frame.size.width - image_width)/2;
                        
                    }else{
                        image_x = 0;
                        image_y = 0;
                        image_width = _imgToUse.frame.size.width;
                        image_height = _imgToUse.frame.size.height;
                    }
                    
                    CGFloat resize_scale = image_width/_imgToUse.image.size.width;
                    //
                    if(faceInArr && [faceInArr isKindOfClass:[NSDictionary class]]){
                        
                        id posDic=[faceInArr objectForKey:KCIFlyFaceResultPosition];
                        if([posDic isKindOfClass:[NSDictionary class]]){
                            CGFloat bottom =[[posDic objectForKey:KCIFlyFaceResultBottom] floatValue];
                            CGFloat top=[[posDic objectForKey:KCIFlyFaceResultTop] floatValue];
                            CGFloat left=[[posDic objectForKey:KCIFlyFaceResultLeft] floatValue];
                            CGFloat right=[[posDic objectForKey:KCIFlyFaceResultRight] floatValue];
                            
                            float x = left;
                            float y = top;
                            float width = right- left;
                            float height = bottom- top;
                            
                            CGRect innerRect = CGRectMake( resize_scale*x+image_x, resize_scale*y+image_y, resize_scale*width, resize_scale*height);
                            
                            [layer setFrame:innerRect];
                            layer.borderColor = [[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0] CGColor];
                            
                        }
                        
                        id attrDic=[faceInArr objectForKey:KCIFlyFaceResultAttribute];
                        if([attrDic isKindOfClass:[NSDictionary class]]){
                            id poseDic=[attrDic objectForKey:KCIFlyFaceResultPose];
                            id pit=[poseDic objectForKey:KCIFlyFaceResultPitch];
                            
                            CATextLayer *label = [[CATextLayer alloc] init];
                            [label setFontSize:14];
                            [label setString:[@"" stringByAppendingFormat:@"%@", pit]];
                            [label setAlignmentMode:kCAAlignmentCenter];
                            [label setForegroundColor:layer.borderColor];
                            [label setFrame:CGRectMake(0, layer.frame.size.height, layer.frame.size.width, 25)];
                            
                            [layer addSublayer:label];
                        }
                    }
                    [_imgToUseCoverLayer addSublayer:layer];
                    
                }
                
                
                [self.imgToUse.layer addSublayer:_imgToUseCoverLayer];
            }
            
            
            [self performSelectorOnMainThread:@selector(showResultInfo:) withObject:resultInfo waitUntilDone:NO];
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"prase exception:%@",exception.name);
    }
    @finally {
    }
    
}

#pragma mark 解析人脸详细点
-(void)praseAlignResult:(NSString*)result{
    NSString *resultInfo = @"";
    NSString *resultInfoForLabel = @"";
    
    @try {
        NSError* error;
        NSData* resultData=[result dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary* dic=[NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableContainers error:&error];
        
        if(dic){
            NSString* strSessionType=[dic objectForKey:KCIFlyFaceResultSST];
            
            //关键点
            if([strSessionType isEqualToString:KCIFlyFaceResultAlign]){
                NSString* rst=[dic objectForKey:KCIFlyFaceResultRST];
                NSString* ret=[dic objectForKey:KCIFlyFaceResultRet];
                if([ret integerValue]!=0){
                    resultInfo=[resultInfo stringByAppendingFormat:@"检测关键点错误\n错误码：%@",ret];
                }else{
                    resultInfo=[resultInfo stringByAppendingString:[rst isEqualToString:@"success"]?@"检测到人脸关键点":@"未检测到人脸关键点"];
                }
                
                
                //绘图
                if(_imgToUseCoverLayer){
                    _imgToUseCoverLayer.sublayers=nil;
                    [_imgToUseCoverLayer removeFromSuperlayer];
                    _imgToUseCoverLayer=nil;
                }
                _imgToUseCoverLayer = [[CALayer alloc] init];
                
                float image_x, image_y, image_width, image_height;
                if(_imgToUse.image.size.width/_imgToUse.image.size.height > _imgToUse.frame.size.width/_imgToUse.frame.size.height){
                    image_width = _imgToUse.frame.size.width;
                    image_height = image_width/_imgToUse.image.size.width * _imgToUse.image.size.height;
                    image_x = 0;
                    image_y = (_imgToUse.frame.size.height - image_height)/2;
                    
                }else if(_imgToUse.image.size.width/_imgToUse.image.size.height < _imgToUse.frame.size.width/_imgToUse.frame.size.height)
                {
                    image_height = _imgToUse.frame.size.height;
                    image_width = image_height/_imgToUse.image.size.height * _imgToUse.image.size.width;
                    image_y = 0;
                    image_x = (_imgToUse.frame.size.width - image_width)/2;
                    
                }else{
                    image_x = 0;
                    image_y = 0;
                    image_width = _imgToUse.frame.size.width;
                    image_height = _imgToUse.frame.size.height;
                }
                
                CGFloat resize_scale = image_width/_imgToUse.image.size.width;
                
                NSArray* resultArray=[dic objectForKey:KCIFlyFaceResultResult];
                for (id anRst in resultArray) {
                    if(anRst && [anRst isKindOfClass:[NSDictionary class]]){
                        NSDictionary* landMarkDic=[anRst objectForKey:KCIFlyFaceResultLandmark];
                        NSEnumerator* keys=[landMarkDic keyEnumerator];
                        for(id key in keys){
                            id attr=[landMarkDic objectForKey:key];
                            if(attr && [attr isKindOfClass:[NSDictionary class]]){
                                id attr=[landMarkDic objectForKey:key];
                                CGFloat x=[[attr objectForKey:KCIFlyFaceResultPointX] floatValue];
                                CGFloat y=[[attr objectForKey:KCIFlyFaceResultPointY] floatValue];
                                
                                CALayer* layer= [[CALayer alloc] init];
                                NSLog(@"resize_scale:%f",resize_scale);
                                CGFloat radius=5.0f*resize_scale;
                                //关键点大小限制
                                if(radius>10){
                                    radius=10;
                                }
                                [layer setCornerRadius:radius];
                                CGRect innerRect = CGRectMake( resize_scale*x+image_x-radius/2, resize_scale*y+image_y-radius/2, radius, radius);
                                [layer setFrame:innerRect];
                                layer.backgroundColor = [[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0] CGColor];
                                
                                [_imgToUseCoverLayer addSublayer:layer];
                                
                                
                            }
                        }
                    }
                }
                
                [self.imgToUse.layer addSublayer:_imgToUseCoverLayer];
                
            }
            
            [self performSelectorOnMainThread:@selector(showResultInfo:) withObject:resultInfo waitUntilDone:NO];
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"prase exception:%@",exception.name);
    }
    @finally {
        
    }
    
}


-(void)showResultInfo:(NSString*)resultInfo{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"结果" message:resultInfo delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    alert=nil;
}


-(void)doOcrDetect{

    
    NSData *imgData = UIImageJPEGRepresentation(_imgToUse.image, 1.0f);
    NSString *imgStr = [imgData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    [STLog print:imgStr];

    NSString *appcode = @"60a5718e77604a61befe69f65ff36d21";
    NSString *host = @"https://ocrcp.market.alicloudapi.com";
    NSString *path = @"/rest/160601/ocr/ocr_vehicle_plate.json";
    NSString *method = @"POST";
    NSString *querys = @"";
    NSString *url = [NSString stringWithFormat:@"%@%@%@",  host,  path , querys];
    NSString *bodys =
    [NSString stringWithFormat:@"{\"image\": \"%@\",\"configure\": {\"multi_crop\":false}}",imgStr];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: url]  cachePolicy:1  timeoutInterval:  5];
    request.HTTPMethod  =  method;
    [request addValue:  [NSString  stringWithFormat:@"APPCODE %@" ,  appcode]  forHTTPHeaderField:  @"Authorization"];
    //根据API的要求，定义相对应的Content-Type
    [request addValue: @"application/json; charset=UTF-8" forHTTPHeaderField: @"Content-Type"];
    NSData *data = [bodys dataUsingEncoding: NSUTF8StringEncoding];
    [request setHTTPBody: data];
    NSURLSession *requestSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [requestSession dataTaskWithRequest:request
                                                   completionHandler:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                       NSLog(@"Response object: %@" , response);
                                                       NSString *bodyString = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
                                                       NSDictionary *dic = [STConvertUtil jsonToDic:bodyString];
                                                       NSMutableArray *plates = [dic mutableArrayValueForKey:@"plates"];
                                                       NSString *result;
                                                       if(!IS_NS_COLLECTION_EMPTY(plates)){
                                                           for(id index in plates){
                                                               result = [index objectForKey:@"txt"];
                                                            }
                                                       }
                                                       dispatch_sync(dispatch_get_main_queue(), ^{
                                                           [self showResultInfo:[NSString stringWithFormat:@"车牌号是：%@",result]];
                                                       });
                                                   
                                                       
                                                   }];
    
    [task resume];
    
}


-(void)doDetectPet{
    [STAlertUtil showAlertController:@"ops~~~~~" content:@"接口审核中" controller:self];
//    NSData *imgData = UIImageJPEGRepresentation(_imgToUse.image, 1.0f);
//    NSString *imgStr = [imgData base64Encoding];
//
//    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
//    dic[@"modelId"]= @(6697);
//    dic[@"type"] = @(1);
//    dic[@"image"] = [NSString stringWithFormat:@"data:image/jpeg;base64,%@",imgStr];
//    dic[@"method"] = @"model/verify";
//
//    NSString *jsonStr = [dic mj_JSONString];
//    [STNetUtil post:@"https://aip.baidubce.com/rpc/2.0/ai_custom/v1/classification/pet" content:jsonStr success:^(RespondModel *resondModel) {
//
//    } failure:^(NSError *error) {
//
//    }];
    
}



@end
