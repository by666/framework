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
#import "UIImage+Extensions.h"
#import "UIImage+compress.h"
#import "STFileUtil.h"
#import "FaceEnterPage.h"
#import "STObserverManager.h"

@interface AddMemberPage ()<AddMemberViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,STObserverProtocol>

@property(strong, nonatomic)AddMemberView *addMemberView;
@property(strong, nonatomic)MemberModel *memberModel;

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
    __weak AddMemberPage *weakSelf = self;
    
    if(_memberModel == nil){
        [self showSTNavigationBar:MSG_ADDMEMBER_TITLE needback:YES rightBtn:MSG_ADDMEMBER_SAVE block:^{
            [weakSelf.addMemberView saveMember];
        }];
    }else{
        [self showSTNavigationBar:MSG_ADDMEMBER_TITLE needback:YES rightBtn:MSG_ADDMEMBER_DELETE block:^{
            [weakSelf.addMemberView deleteMember];
        }];
    }

    [[STObserverManager sharedSTObserverManager] registerSTObsever:Notify_UpdateAvatar delegate:self];
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated{
    [self setStatuBarBackgroud:cwhite];
}

-(void)dealloc{
    [[STObserverManager sharedSTObserverManager]removeSTObsever:Notify_UpdateAvatar];
}



-(UIView *)addMemberView{
    if(_addMemberView == nil){
        AddMemberViewModel *viewModel = [[AddMemberViewModel alloc]init];
        viewModel.delegate = self;
        _addMemberView = [[AddMemberView alloc]initWithViewModel:viewModel memberModel:_memberModel];
        _addMemberView.backgroundColor = c15;
        _addMemberView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    }
    return _addMemberView;
}

-(void)initView{
    [self.view addSubview:[self addMemberView]];
}

-(void)onAddMemberModel:(Boolean)success model:(MemberModel *)model{
    [MBProgressHUD hideHUDForView:_addMemberView animated:YES];
    [[STObserverManager sharedSTObserverManager] sendMessage:Notify_AddMember msg:model];
    [self backLastPage];
}

-(void)onDeleteMemberModel:(Boolean)success model:(MemberModel *)model{
    [MBProgressHUD hideHUDForView:_addMemberView animated:YES];
    [[STObserverManager sharedSTObserverManager] sendMessage:Notify_DeleteMember msg:model];
    [self backLastPage];
}

-(void)backLastPage{
    MemberModel *model = [_addMemberView getCurrentModel];
    [[STObserverManager sharedSTObserverManager] sendMessage:Notify_UpdateMember msg:model];
    [self.navigationController popViewControllerAnimated:YES];

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
    NSString *imagePath = [STFileUtil saveImageFile:@"head.jpg" image:image];
    [_addMemberView updateView:imagePath];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark 人脸录入
-(void)doSelectFromPhoto{
    [FaceEnterPage show:self];
}


-(void)onReciveResult:(NSString *)key msg:(id)msg{
    [_addMemberView updateView:msg];
}

@end
