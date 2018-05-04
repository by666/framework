//
//  QRCodePage.m
//  framework
//
//  Created by 黄成实 on 2018/5/3.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "QRCodePage.h"
#import <objc/message.h>
#import "LBXScanViewStyle.h"
#import <ZBarSDK/ZBarSDK.h>
#import "STFileUtil.h"

@interface QRCodePage ()

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIButton *generateBtn;

@end

@implementation QRCodePage


-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = c01;
    self.navigationItem.title = @"二维码识别";
    
    
    self.style = [self ZhiFuBaoStyle];
    self.isOpenInterestRect = YES;
    self.libraryType = SLT_ZXing;
    self.scanCodeType = SCT_BarCode128;
    
    _generateBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
    [_generateBtn setTitle:@"生成" forState:UIControlStateNormal];
    [_generateBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_generateBtn addTarget:self action:@selector(OnGenerateBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithCustomView:_generateBtn];
    self.navigationItem.rightBarButtonItem = rightBar;
    
    
    _imageView = [[UIImageView alloc]init];
    _imageView.frame = CGRectMake((ScreenWidth - 480 )/2, (ScreenHeight - 480 )/2, 480, 480);
    _imageView.hidden = YES;
    [self.view addSubview:_imageView];
}


- (void)scanResultWithArray:(NSArray<LBXScanResult*>*)array
{
    if (IS_NS_COLLECTION_EMPTY(array)){
        [STLog print:@"识别失败"];
        return;
    }
    
    LBXScanResult *scanResult = array[0];
    NSString*strResult = scanResult.strScanned;
    self.scanImage = scanResult.imgScanned;
    if (IS_NS_STRING_EMPTY(strResult)) {
        [STLog print:@"识别失败"];
        return;
    }
    
    [STLog print:scanResult.strScanned];

    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"识别结果" message:strResult preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self reStartDevice];
    }];
    
    [controller addAction:confirmAction];
    [self presentViewController:controller animated:YES completion:nil];
}


- (LBXScanViewStyle*)ZhiFuBaoStyle
{
    //设置扫码区域参数
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    style.centerUpOffset = 60;
    style.xScanRetangleOffset = 30;
    
    if ([UIScreen mainScreen].bounds.size.height <= 480 )
    {
        //3.5inch 显示的扫码缩小
        style.centerUpOffset = 40;
        style.xScanRetangleOffset = 20;
    }
    
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Inner;
    style.photoframeLineW = 2.0;
    style.photoframeAngleW = 16;
    style.photoframeAngleH = 16;
    
    style.isNeedShowRetangle = NO;
    style.anmiationStyle = LBXScanViewAnimationStyle_NetGrid;
    
    style.notRecoginitonArea = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    
    
    //使用的支付宝里面网格图片
    UIImage *imgFullNet = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_full_net"];
    style.animationImage = imgFullNet;
    
    return style;
}

-(void)OnGenerateBtnClick{
    if([_generateBtn.titleLabel.text isEqualToString:@"关闭"]){
        _imageView.hidden = YES;
        [_generateBtn setTitle:@"生成" forState:UIControlStateNormal];
        return;
    }
    __weak QRCodePage *weakSelf = self;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"生成二维码" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField = alertController.textFields.firstObject;
        if(!IS_NS_STRING_EMPTY(textField.text)){
            UIImage *image = [ZXingWrapper createCodeWithString:textField.text size:CGSizeMake(480, 480) CodeFomart:kBarcodeFormatQRCode];
            weakSelf.imageView.image  = image;
            weakSelf.imageView.hidden = NO;
            [weakSelf.view bringSubviewToFront:weakSelf.imageView];
            [weakSelf.generateBtn setTitle:@"关闭" forState:UIControlStateNormal];
        }
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入字符串";
    }];
    [self presentViewController:alertController animated:true completion:nil];
}


@end
