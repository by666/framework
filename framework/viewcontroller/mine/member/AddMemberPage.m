//
//  AddMemberPage.m
//  framework
//
//  Created by 黄成实 on 2018/5/17.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "AddMemberPage.h"
#import "AddMemberView.h"
#import "PermissionDetector.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "STFileUtil.h"
#import "FaceEnterPage2.h"
#import "STObserverManager.h"
#import "AccountManager.h"
#import <IDLFaceSDK/IDLFaceSDK.h>
#import "ImageUtils.h"
#import "LocalFaceDetect.h"

@interface AddMemberPage ()<AddMemberViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,STObserverProtocol>

@property(strong, nonatomic)AddMemberView *addMemberView;
@property(strong, nonatomic)MemberModel *memberModel;
@property(strong, nonatomic)AddMemberViewModel *viewModel;
@property(assign, nonatomic)Boolean changePhoto;

@end

@implementation AddMemberPage

+(void)show:(BaseViewController *)controller{
    AddMemberPage *page = [[AddMemberPage alloc]init];
    [controller pushPage:page];
}

+(void)show:(BaseViewController *)controller model:(MemberModel *)model{
    AddMemberPage *page = [[AddMemberPage alloc]init];
    page.memberModel = model;
    [controller pushPage:page];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = c15;
    [[STObserverManager sharedSTObserverManager] registerSTObsever:Notify_UpdateAvatar delegate:self];
    [self initView];

    WS(weakSelf)
    if(IS_NS_STRING_EMPTY(_memberModel.nickname)){
        [self showSTNavigationBar:MSG_ADDMEMBER_TITLE needback:YES rightBtn:MSG_COMMIT rightColor:c13 block:^{
            [weakSelf.addMemberView saveMember];
        }];
    }else{
        [self showSTNavigationBar:MSG_ADDMEMBER_TITLE needback:YES rightBtn:MSG_ADDMEMBER_DELETE block:^{
            [STAlertUtil showAlertController:MSG_WARN content:MSG_MEMBER_DELETE_TIPS controller:weakSelf confirm:^{
                [weakSelf.viewModel deleteMemberModel:weakSelf.viewModel.model];
            }];
        }];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setStatuBarBackgroud:cwhite];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

-(void)dealloc{
    [[STObserverManager sharedSTObserverManager]removeSTObsever:Notify_UpdateAvatar];
    if(_addMemberView){
        [_addMemberView removeView];
    }
}



-(void)initView{
    
    if(_memberModel == nil){
        _memberModel = [[MemberModel alloc]init];
        LiveModel *liveModel = [[AccountManager sharedAccountManager]getLiveModel];
        _memberModel.userUid = liveModel.userUid;
        _memberModel.districtUid = liveModel.districtUid;
        _memberModel.homeLocator = liveModel.homeLocator;
    }
    _viewModel = [[AddMemberViewModel alloc]initWithData:_memberModel];
    _viewModel.delegate = self;
    
    _addMemberView = [[AddMemberView alloc]initWithViewModel:_viewModel];
    _addMemberView.backgroundColor = c15;
    _addMemberView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    
    [self.view addSubview:_addMemberView];
}



#pragma mark 网络请求回调
-(void)onRequestBegin{
    WS(weakSelf)
    dispatch_main_async_safe(^{
        [MBProgressHUD showHUDAddedTo:weakSelf.view animated:YES];
    });
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if([respondModel.requestUrl isEqualToString:URL_DELFAMILY_MEMBER]){
        [STToastUtil showSuccessTips:MSG_DELETE_SUCCESS];
        [[STObserverManager sharedSTObserverManager] sendMessage:Notify_DeleteMember msg:data];
    }
    else if([respondModel.requestUrl isEqualToString:URL_ADDFAMILY_MEMBER]){
        [STToastUtil showSuccessTips:MSG_ADD_SUCCESS];
        [[STObserverManager sharedSTObserverManager] sendMessage:Notify_AddMember msg:data];
    }
    else if([respondModel.requestUrl isEqualToString:URL_UPDATEFAMILY_MEMBER]){
        [STToastUtil showSuccessTips:MSG_UPDATE_SUCCESS];
        [[STObserverManager sharedSTObserverManager] sendMessage:Notify_UpdateMember msg:data];
    }
    [self onGoLastPage];
}

-(void)onRequestFail:(NSString *)msg{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [STToastUtil showFailureAlertSheet:msg];
}


-(void)onCheckUpdate:(MemberModel *)model changePhoto:(Boolean)changePhoto{
    WS(weakSelf)
    [STAlertUtil showAlertController:MSG_PROMPT content:MSG_ADDMEMBER_UPDATE_TIPS controller:self confirm:^{
        if(weakSelf.viewModel){
            [weakSelf.viewModel updateMemberModel:model changePhoto:(Boolean)changePhoto];
        }
    } cancel:^{
        [[STObserverManager sharedSTObserverManager]sendMessage: Notify_UpdateMember msg:nil];
        [weakSelf onGoLastPage];
    }];
}

-(void)onGoLastPage{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)backLastPage{
    if(IS_NS_STRING_EMPTY(_viewModel.model.nickname)){
        [self onGoLastPage];
        return;
    }
    if(_viewModel){
        [_viewModel checkUpdateMemberModel:[_addMemberView getCurrentModel] changePhoto:_changePhoto];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_addMemberView touchesBegan:touches withEvent:event];
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
    NSString *imagePath = [STFileUtil saveImageFile:image];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    WS(weakSelf)
    [LocalFaceDetect detectLocalImage:image success:^(id successStr) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [weakSelf.addMemberView updateView:imagePath];
        weakSelf.changePhoto = YES;
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
    [_addMemberView updateView:msg];
    _changePhoto = YES;
}


@end
