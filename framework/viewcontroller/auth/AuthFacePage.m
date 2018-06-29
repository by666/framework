//
//  AuthFacePage.m
//  framework
//
//  Created by 黄成实 on 2018/5/28.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "AuthFacePage.h"
#import "AuthFaceView.h"
#import "FaceEnterPage2.h"
#import "PermissionDetector.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "UIImage+Extensions.h"
#import "UIImage+compress.h"
#import "STFileUtil.h"
#import "FaceEnterPage.h"
#import "STObserverManager.h"
#import "MainPage.h"
#import "STTimeUtil.h"
#import <IDLFaceSDK/IDLFaceSDK.h>

@interface AuthFacePage ()<AuthFaceViewModelDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,STObserverProtocol>

@property(strong, nonatomic)AuthFaceView *authFaceView;
@property(strong, nonatomic)UserCommitModel *userCommitModel;
@property(strong, nonatomic)AuthFaceViewModel *viewModel;

@end

@implementation AuthFacePage

+(void)show:(BaseViewController *)controller model:(UserCommitModel *)model{
    AuthFacePage *page = [[AuthFacePage alloc]init];
    page.userCommitModel = model;
    [controller pushPage:page];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = cwhite;
    [self initView];
    [self showSTNavigationBar:MSG_AUTHFACE_TITLE needback:YES];
    [[STObserverManager sharedSTObserverManager] registerSTObsever:Notify_UpdateAvatar delegate:self];
}

-(void)dealloc{
    [[STObserverManager sharedSTObserverManager]removeSTObsever:Notify_UpdateAvatar];

}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setStatuBarBackgroud:cwhite];
}


-(void)initView{
    _viewModel = [[AuthFaceViewModel alloc]initWithModel:_userCommitModel];
    _viewModel.delegate = self;
    
    _authFaceView = [[AuthFaceView alloc]initWithViewModel:_viewModel];
    _authFaceView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    [self.view addSubview:_authFaceView];
    
}

-(void)onAddPhoto{
    [self onDoTakePhoto];
}


-(void)onRequestBegin{
    WS(weakSelf)
    dispatch_main_async_safe(^{
        [MBProgressHUD showHUDAddedTo:weakSelf.view animated:YES];
    });
}


-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if(_authFaceView){
        [_authFaceView onCommitFinish];
    }
}

-(void)onRequestFail:(NSString *)msg{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [STToastUtil showFailureAlertSheet:msg];
    if([msg isEqualToString:STATU_CHECKIN_DIFF_OWNNER_INFO] || [msg isEqualToString:STATU_CHECKIN_HAS_APPLY]){
        if(_authFaceView){
            [_authFaceView onCommitFinish];
        }
    }
}


-(void)onGoMainPage{
    [MainPage show:self];
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
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
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
    UIImage* image=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
    NSString *imagePath = [STFileUtil saveImageFile:image];
    WS(weakSelf)
    
    CGRect previewRect;
    [[IDLFaceDetectionManager sharedInstance] detectStratrgyWithImage:image previewRect:previewRect detectRect:previewRect completionHandler:^(NSDictionary *images, DetectRemindCode remindCode){
        if(remindCode == DetectRemindCodeOK){
            [weakSelf.authFaceView updateView:imagePath];
        }else{
            [STToastUtil showFailureAlertSheet:MSG_FACEDETECT_FAIL];
        }
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
    [_authFaceView updateView:msg];
}



@end
