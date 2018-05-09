//
//  IFlyOfflineFaceDetectPage.m
//  framework
//
//  Created by 黄成实 on 2018/4/23.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "IFlyOfflineFaceDetectPage.h"
#import "UIImage+Extensions.h"
#import "UIImage+compress.h"
#import <iflyMSC/IFlyFaceSDK.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import "IFlyFaceResultKeys.h"
#import "PermissionDetector.h"

@interface IFlyOfflineFaceDetectPage ()<UINavigationControllerDelegate,
UIImagePickerControllerDelegate,
UIActionSheetDelegate>

@property (strong, nonatomic)UIButton *selectBtn;
@property (strong, nonatomic)UIButton *checkBtn;



@property (nonatomic,retain) CALayer *imgToUseCoverLayer;
@property (strong, nonatomic)UIImageView *imgToUse;
@property (nonatomic,strong) NSString *resultStings;
@property (nonatomic,strong) IFlyFaceDetector *faceDetector;


@end

@implementation IFlyOfflineFaceDetectPage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:c01];
    self.navigationItem.title = @"离线识别";
    self.faceDetector=[IFlyFaceDetector sharedInstance];
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
    
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark 检测图片
-(void)doCheckPhoto{
    NSString* strResult=[self.faceDetector detectARGB:[_imgToUse image]];
    NSLog(@"result:%@",strResult);
    [self praseDetectResult:strResult];
}


-(void)praseDetectResult:(NSString*)result{
    NSString *resultInfo = @"";
    
    @try {
        NSError* error;
        NSData* resultData=[result dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary* dic=[NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableContainers error:&error];
        
        if(dic){
            NSNumber* ret=[dic objectForKey:KCIFlyFaceResultRet];
            NSArray* faceArray=[dic objectForKey:KCIFlyFaceResultFace];
            //检测
            if(ret && [ret intValue]==0 && faceArray &&[faceArray count]>0){
                resultInfo=[resultInfo stringByAppendingFormat:@"检测到人脸轮廓"];
            }else{
                resultInfo=[resultInfo stringByAppendingString:@"未检测到人脸轮廓"];
            }
            
            
            //绘图
            if(_imgToUseCoverLayer){
                _imgToUseCoverLayer.sublayers=nil;
                [_imgToUseCoverLayer removeFromSuperlayer];
                _imgToUseCoverLayer=nil;
            }
            _imgToUseCoverLayer = [[CALayer alloc] init];
            
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
                    NSDictionary* position=[faceInArr objectForKey:KCIFlyFaceResultPosition];
                    if(position){
                        CGFloat bottom =[[position objectForKey:KCIFlyFaceResultBottom] floatValue];
                        CGFloat top=[[position objectForKey:KCIFlyFaceResultTop] floatValue];
                        CGFloat left=[[position objectForKey:KCIFlyFaceResultLeft] floatValue];
                        CGFloat right=[[position objectForKey:KCIFlyFaceResultRight] floatValue];
                        
                        float x = left;
                        float y = top;
                        float width = right- left;
                        float height = bottom- top;
                        
                        CGRect innerRect = CGRectMake( resize_scale*x+image_x, resize_scale*y+image_y, resize_scale*width, resize_scale*height);
                        
                        [layer setFrame:innerRect];
                        layer.borderColor = [[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0] CGColor];
                    }
                }
                
                [_imgToUseCoverLayer addSublayer:layer];
                layer=nil;
                
            }
            self.imgToUse.layer.sublayers=nil;
            [self.imgToUse.layer addSublayer:_imgToUseCoverLayer];
            _imgToUseCoverLayer=nil;
            
        }
        
   
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"结果" message:resultInfo delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        alert=nil;
        
    }
    @catch (NSException *exception) {
        NSLog(@"prase exception:%@",exception.name);
    }
    @finally {
    }
    
}


@end
