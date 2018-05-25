//
//  ProfilePage.m
//  framework
//
//  Created by 黄成实 on 2018/5/15.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "ProfilePage.h"
#import "ProfileView.h"
#import "PermissionDetector.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "UIImage+Extensions.h"
#import "UIImage+compress.h"
#import "STFileUtil.h"
#import "FaceEnterPage.h"
#import "STObserverManager.h"
#import "AuthStatuPage.h"

@interface ProfilePage ()<ProfileViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,STObserverProtocol>

@property(strong, nonatomic)ProfileView *profileView;
@property(strong, nonatomic)ProfileViewModel *mViewModel;

@end

@implementation ProfilePage

+(void)show:(BaseViewController *)controller{
    ProfilePage *page = [[ProfilePage alloc]init];
    [controller pushPage:page];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = c15;
    [self showSTNavigationBar:MSG_PROFILE_TITLE needback:YES];
    [[STObserverManager sharedSTObserverManager] registerSTObsever:Notify_UpdateAvatar delegate:self];
    [self initView];
}

-(void)initView{
    _mViewModel = [[ProfileViewModel alloc]init];
    _mViewModel.delegate = self;
    _profileView = [[ProfileView alloc]initWithViewModel:_mViewModel];
    _profileView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    [self.view addSubview:_profileView];
}

-(void)viewWillAppear:(BOOL)animated{
    [self setStatuBarBackgroud:cwhite];
}


-(void)dealloc{
    [[STObserverManager sharedSTObserverManager]removeSTObsever:Notify_UpdateAvatar];
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


#pragma mark 人脸录入
-(void)doSelectFromPhoto{
    if(![PermissionDetector isCapturePermissionGranted]){
        [STLog print:@"没有相机权限"];
        return;
    }
    [FaceEnterPage show:self];
}



#pragma mark 回调
-(void)onUpdateProfile{
    [_profileView updateTableView];
}

-(void)onGoFaceEnterPage{
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


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage* image=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
    //压缩
//    UIImage *compressImage = [[image fixOrientation] compressedImage];
    NSString *imagePath = [STFileUtil saveImageFile:@"head.jpg" image:image];
    if(_mViewModel){
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self performSelector:@selector(test:) withObject:imagePath afterDelay:1.0f];
    }
}

-(void)test :(NSString *)imagePath{
    [_mViewModel uploadHeadImage:imagePath];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)onUploadHeadImage:(Boolean)success image:(NSString *)imagePath{
    _mViewModel.model.avatarUrl = imagePath;
    [_mViewModel updateProfile];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}


-(void)onReciveResult:(NSString *)key msg:(id)msg{
    _mViewModel.model.avatarUrl = msg;
    [_mViewModel updateProfile];
}


-(void)onGoAuthStatuPage{
    [AuthStatuPage show:self];
}
@end
