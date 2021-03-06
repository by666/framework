//
//  VisitorPage.m
//  framework
//
//  Created by 黄成实 on 2018/5/15.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "VisitorPage.h"
#import "VisitorView.h"
#import "FaceEnterPage2.h"
#import "PermissionDetector.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "STFileUtil.h"
#import "PassPage.h"
#import "STObserverManager.h"
#import <IDLFaceSDK/IDLFaceSDK.h>
#import "LocalFaceDetect.h"
#import "UIImage+FixOrientation.h"

@interface VisitorPage ()<VisitorViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,STObserverProtocol>

@property(assign, nonatomic)VisitorType mType;
@property(strong, nonatomic)VisitorView *visitorView;
@property(strong, nonatomic)VisitorModel *mData;

@end

@implementation VisitorPage

+(void)show:(BaseViewController *)controller type:(VisitorType)type{
    VisitorPage *page = [[VisitorPage alloc]init];
    page.mType = type;
    [controller pushPage:page];
}

+(void)show:(BaseViewController *)controller type:(VisitorType)type model:(VisitorModel *)model{
    VisitorPage *page = [[VisitorPage alloc]init];
    page.mType = type;
    page.mData = model;
    [controller pushPage:page];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = c01;
    if(_mType == People){
        [self showSTNavigationBar:MSG_VISITOR_PEOPLE_TITLE needback:YES];
    }
    else if(_mType == Car){
        [self showSTNavigationBar:MSG_VISITOR_CAR_TITLE needback:YES];
    }
    [self initView];
    [[STObserverManager sharedSTObserverManager] registerSTObsever:Notify_UpdateAvatar delegate:self];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setStatuBarBackgroud:cwhite];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

-(void)dealloc{
    [[STObserverManager sharedSTObserverManager] removeSTObsever:Notify_UpdateAvatar];

}


-(void)initView{
    VisitorViewModel *viewModel = [[VisitorViewModel alloc]init];
    viewModel.delegate = self;
    if(_mData != nil){
        viewModel.data = _mData;
    }
    _visitorView = [[VisitorView alloc]initWithViewModel:viewModel type:_mType];
    _visitorView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    _visitorView.backgroundColor = c15;
    [self.view addSubview:_visitorView];
}


-(void)onGeneratePassFail:(NSString *)errorMsg{
    [_visitorView updateTipLabel:errorMsg];
}

-(void)onRequestBegin{
    WS(weakSelf)
    dispatch_main_async_safe(^{
        [MBProgressHUD showHUDAddedTo:weakSelf.view animated:YES];
    })
}

-(void)onRequestFail:(NSString *)msg{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [STToastUtil showFailureAlertSheet:msg];
}


-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [_visitorView showGeneratePass:data];
}
//人脸选择
-(void)onDoTakePhoto{
    STSheetModel *model = [[STSheetModel alloc]init];
    model.title = MSG_PROFILE_PHOTO;
    model.click = ^{
        [self doSelectFromPhoto];
    };
    
    STSheetModel *model2 = [[STSheetModel alloc]init];
    model2.title =MSG_PROFILE_ALBUM;
    model2.click = ^{
        [self doSelectFromAblum];
    };
    
    NSMutableArray *models = [[NSMutableArray alloc]init];
    [models addObject:model];
    [models addObject:model2];
    
    [STAlertUtil showSheetController:nil content:nil controller:self sheetModels:models];
}

#pragma mark 相册选择
-(void)doSelectFromAblum{
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

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage* image=[[info objectForKey:@"UIImagePickerControllerOriginalImage"] fixOrientation];
    NSString *imagePath = [STFileUtil saveImageFile:image];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    WS(weakSelf)
    [LocalFaceDetect detectLocalImage:image success:^(id successStr) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [weakSelf.visitorView updateView:imagePath];
        [STToastUtil showSuccessTips:MSG_FACEDETECT_SUCCESS];
    } failure:^(id failStr) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [STToastUtil showFailureAlertSheet:failStr];
    }];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark 人脸录入
-(void)doSelectFromPhoto{
    [FaceEnterPage2 show:self];
}

-(void)onReciveResult:(NSString *)key msg:(id)msg{
    if([key isEqualToString:Notify_UpdateAvatar]){
        [_visitorView updateView:msg];
    }
}

-(void)onGoPassPage:(VisitorModel *)visitorModel passModel:(PassModel *)passModel{
    [PassPage show:self passModel:passModel visitorModel:visitorModel needDelete:NO];
}

@end
