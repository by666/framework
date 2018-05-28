//
//  AuthFacePage.m
//  framework
//
//  Created by 黄成实 on 2018/5/28.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "AuthFacePage.h"
#import "AuthFaceView.h"
#import "FaceEnterPage.h"
#import "PermissionDetector.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "UIImage+Extensions.h"
#import "UIImage+compress.h"
#import "STFileUtil.h"
#import "FaceEnterPage.h"
#import "STObserverManager.h"
#import "MainPage.h"

@interface AuthFacePage ()<AuthFaceViewModelDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,STObserverProtocol>

@property(strong, nonatomic)AuthFaceView *authFaceView;

@end

@implementation AuthFacePage

+(void)show:(BaseViewController *)controller{
    AuthFacePage *page = [[AuthFacePage alloc]init];
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
    [self setStatuBarBackgroud:cwhite];
}


-(void)initView{
    AuthFaceViewModel *viewModel = [[AuthFaceViewModel alloc]init];
    viewModel.delegate = self;
    
    _authFaceView = [[AuthFaceView alloc]initWithViewModel:viewModel];
    _authFaceView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    [self.view addSubview:_authFaceView];
    
}

-(void)onAddPhoto{
    [self onDoTakePhoto];
}

-(void)onCommitStart{
    if(_authFaceView){
        [_authFaceView onCommitStart];
    }
}

-(void)onCommitProgress:(float)progress{
    if(_authFaceView){
        [_authFaceView onCommitProgress:progress];
    }
}

-(void)onCommitEnd{
    if(_authFaceView){
        [_authFaceView onCommitFinish];
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
    UIImage* image=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
    NSString *imagePath = [STFileUtil saveImageFile:@"head.jpg" image:image];
    [_authFaceView updateView:imagePath];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark 人脸录入
-(void)doSelectFromPhoto{
    [FaceEnterPage show:self];
}


-(void)onReciveResult:(NSString *)key msg:(id)msg{
    [_authFaceView updateView:msg];
}


@end
