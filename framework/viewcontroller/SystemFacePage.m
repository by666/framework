//
//  SystemFacePage.m
//  framework
//
//  Created by 黄成实 on 2018/4/23.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "SystemFacePage.h"
#import "STUserDefaults.h"

@interface SystemFacePage ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic)UIImagePickerController *picker;
@property (strong, nonatomic)UIImageView *imageView;
@property (strong, nonatomic)UILabel *infoLabel;
@property (strong, nonatomic)UIButton *selectBtn;

@end

@implementation SystemFacePage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:c01];
    self.navigationItem.title = @"系统识别";
    [self initView];
}

-(void)initView{
    
    _imageView = [[UIImageView alloc]init];
    _imageView.frame = CGRectMake(0, StatuBarHeight+self.navigationController.navigationBar.frame.size.height, ScreenWidth, ScreenWidth);
    _imageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_imageView];
    
    CGFloat h =  _imageView.mj_h+_imageView.mj_y;
    _infoLabel = [[UILabel alloc]init];
    _infoLabel.textColor = [UIColor whiteColor];
    _infoLabel.numberOfLines = 0;
    _infoLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _infoLabel.font = [UIFont systemFontOfSize:13.0f];
    _infoLabel.frame = CGRectMake(0, h, ScreenWidth, ScreenHeight - h - 50);
    [self.view addSubview:_infoLabel];
    
    _selectBtn = [[UIButton alloc]init];
    _selectBtn.frame = CGRectMake(0, ScreenHeight - 50, ScreenWidth, 50);
    _selectBtn.backgroundColor = [UIColor blueColor];
    [_selectBtn setTitle:@"选择图片" forState:UIControlStateNormal];
    [self.view addSubview:_selectBtn];
    
    [[_selectBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self doSelectPhoto];
    }];
    
}

-(void)doSelectPhoto{
    if (!self.picker) {
        //初始化uiimagepickercontroller
        self.picker = [[UIImagePickerController alloc] init];
        //UIImagePickerController是UINavigationControllerDelegate的子类 所以设置代理的时候也要实现navigation的代理
        
        //是否可以编辑
        self.picker.allowsEditing = YES;
        //设置代理
        self.picker.delegate = self;
        //设置来源类型
        /**UIImagePickerControllerSourceType
         UIImagePickerControllerSourceTypePhotoLibrary:进入相册（横向排列）
         UIImagePickerControllerSourceTypeCamera：打开相机（必须要真机）
         UIImagePickerControllerSourceTypeSavedPhotosAlbum：进入相册(竖向排列)
         */
        self.picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
        
    }
    
    //清除上一次人脸识别到的视图
    for (UIView *view in self.imageView.subviews) {
        [view removeFromSuperview];
    }
    
    //弹出相册界面
    [self presentViewController:self.picker animated:YES completion:nil];
}

//完成选取
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(nonnull NSDictionary<NSString *,id> *)info{
    
    NSString* type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        UIImage* cropImage = [info objectForKey:UIImagePickerControllerEditedImage];
        self.imageView.image = cropImage;
        //人脸识别
        [self beginDetectorFacewithImage:cropImage];
    }else{
        
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)beginDetectorFacewithImage:(UIImage *)image
{
    NSString *result = @"";
    //1 将UIImage转换成CIImage
    CIImage* ciimage = [CIImage imageWithCGImage:image.CGImage];
    
    //缩小图片，默认照片的图片像素很高，需要将图片的大小缩小为我们现实的ImageView的大小，否则会出现识别五官过大的情况
    float factorX = self.imageView.bounds.size.width/image.size.width;
    float factorY = self.imageView.bounds.size.height/image.size.height;
    ciimage = [ciimage imageByApplyingTransform:CGAffineTransformMakeScale(factorX, factorY)];
    
    //2.设置人脸识别精度
    NSDictionary* opts = [NSDictionary dictionaryWithObject:
                          CIDetectorAccuracyHigh forKey:CIDetectorAccuracy];
    //3.创建人脸探测器
    CIDetector* detector = [CIDetector detectorOfType:CIDetectorTypeFace
                                              context:nil options:opts];
    //4.获取人脸识别数据
    NSArray* features = [detector featuresInImage:ciimage];
    if(IS_NS_COLLECTION_EMPTY(features)){
        result = @"未识别到人脸";
        _infoLabel.text = result;
        return;
    }
    //5.分析人脸识别数据
    for (CIFaceFeature *faceFeature in features){
        result = [result stringByAppendingString:[NSString stringWithFormat:@"hasLeftEyePosition:%d\n",faceFeature.hasLeftEyePosition]];
        result = [result stringByAppendingString:[NSString stringWithFormat:@"hasRightEyePosition:%d\n",faceFeature.hasRightEyePosition]];
        result = [result stringByAppendingString:[NSString stringWithFormat:@"leftEyeClosed:%d\n",faceFeature.leftEyeClosed]];
        result = [result stringByAppendingString:[NSString stringWithFormat:@"rightEyeClosed:%d\n",faceFeature.rightEyeClosed]];
        result = [result stringByAppendingString:[NSString stringWithFormat:@"hasMouthPosition:%d\n",faceFeature.hasMouthPosition]];
        result = [result stringByAppendingString:[NSString stringWithFormat:@"hasSmile:%d\n",faceFeature.hasSmile]];
        
        result = [result stringByAppendingString:[NSString stringWithFormat:@"hasFaceAngle:%d\n",faceFeature.hasFaceAngle]];
        result = [result stringByAppendingString:[NSString stringWithFormat:@"faceAngle:%f\n ",faceFeature.faceAngle]];

         _infoLabel.text = result;
        //注意坐标的换算，CIFaceFeature计算出来的坐标的坐标系的Y轴与iOS的Y轴是相反的,需要自行处理
        
        // 标出脸部
        CGFloat faceWidth = faceFeature.bounds.size.width;
        UIView* faceView = [[UIView alloc] initWithFrame:faceFeature.bounds];
        faceView.frame = CGRectMake(faceView.frame.origin.x, self.imageView.bounds.size.height-faceView.frame.origin.y - faceView.bounds.size.height, faceView.frame.size.width, faceView.frame.size.height);
        faceView.layer.borderWidth = 1;
        faceView.layer.borderColor = [[UIColor redColor] CGColor];
        [self.imageView addSubview:faceView];
        // 标出左眼
        if(faceFeature.hasLeftEyePosition) {
            UIView* leftEyeView = [[UIView alloc] initWithFrame:
                                   CGRectMake(faceFeature.leftEyePosition.x-faceWidth*0.15,
                                              self.imageView.bounds.size.height-(faceFeature.leftEyePosition.y-faceWidth*0.15)-faceWidth*0.3, faceWidth*0.3, faceWidth*0.3)];
            [leftEyeView setBackgroundColor:[[UIColor blueColor] colorWithAlphaComponent:0.3]];
            //            [leftEyeView setCenter:faceFeature.leftEyePosition];
            leftEyeView.layer.cornerRadius = faceWidth*0.15;
            [self.imageView  addSubview:leftEyeView];
        }
        // 标出右眼
        if(faceFeature.hasRightEyePosition) {
            UIView* leftEye = [[UIView alloc] initWithFrame:
                               CGRectMake(faceFeature.rightEyePosition.x-faceWidth*0.15,
                                          self.imageView.bounds.size.height-(faceFeature.rightEyePosition.y-faceWidth*0.15)-faceWidth*0.3, faceWidth*0.3, faceWidth*0.3)];
            [leftEye setBackgroundColor:[[UIColor blueColor] colorWithAlphaComponent:0.3]];
            leftEye.layer.cornerRadius = faceWidth*0.15;
            [self.imageView  addSubview:leftEye];
        }
        // 标出嘴部
        if(faceFeature.hasMouthPosition) {
            UIView* mouth = [[UIView alloc] initWithFrame:
                             CGRectMake(faceFeature.mouthPosition.x-faceWidth*0.2,
                                        self.imageView.bounds.size.height-(faceFeature.mouthPosition.y-faceWidth*0.2)-faceWidth*0.4, faceWidth*0.4, faceWidth*0.4)];
            [mouth setBackgroundColor:[[UIColor greenColor] colorWithAlphaComponent:0.3]];
            
            mouth.layer.cornerRadius = faceWidth*0.2;
            [self.imageView  addSubview:mouth];
        }
        
    }
}




@end
