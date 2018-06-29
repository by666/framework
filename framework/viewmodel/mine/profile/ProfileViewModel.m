//
//  ProfileViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/16.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "ProfileViewModel.h"
#import "TitleContentModel.h"
#import "PermissionDetector.h"
#import "AccountManager.h"
#import "STNetUtil.h"
#import "STUploadImageUtil.h"
#import "STObserverManager.h"
@implementation ProfileViewModel


-(instancetype)init{
    if(self == [super init]){
        _datas = [[NSMutableArray alloc]init];
        _model = [[ProfileModel alloc]init];
    }
    return self;
}


-(void)uploadHeadImage:(NSString *)imagePath{
    if(_delegate){
        [_delegate onRequestBegin];
        WS(weakSelf)
        [[STUploadImageUtil sharedSTUploadImageUtil]uploadImageForOSS:imagePath success:^(NSString *imageUrl) {
            [self upload:imageUrl];
        } failure:^(NSString *errorStr) {
            [weakSelf.delegate onRequestFail:errorStr];
        }];
    }

}

-(void)upload:(NSString *)faceUrl{
    if(_delegate){
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        dic[@"faceUrl"] = faceUrl;
        WS(weakSelf)
        [STNetUtil post:URL_UPDATEFACE parameters:dic  success:^(RespondModel *respondModel) {
            if([respondModel.status isEqualToString:STATU_SUCCESS]){
                UserModel *model = [[AccountManager sharedAccountManager]getUserModel];
                model.headUrl = faceUrl;
                [[AccountManager sharedAccountManager]saveUserModel:model];
                [[STObserverManager sharedSTObserverManager] sendMessage:Notify_Update_User_Face msg:nil];
                [weakSelf.delegate onRequestSuccess:respondModel data:nil];
            }else{
                [weakSelf.delegate onRequestFail:respondModel.msg];
            }
        } failure:^(int errorCode) {
            [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
        }];
    }
}






-(void)updateProfile{
    [_datas removeAllObjects];
    [_datas addObject:[TitleContentModel buildModel:MSG_PROFILE_AVATAR content:_model.headUrl]];
    [_datas addObject:[TitleContentModel buildModel:MSG_PROFILE_NAME content:_model.name]];
    [_datas addObject:[TitleContentModel buildModel:MSG_PROFILE_GENDER content:_model.gender]];
    [_datas addObject:[TitleContentModel buildModel:MSG_PROFILE_BIRTHDAY content:_model.birthday]];
    [_datas addObject:[TitleContentModel buildModel:MSG_PROFILE_IDNUM content:_model.idNum]];
    [_datas addObject:[TitleContentModel buildModel:MSG_PROFILE_IDENTIFY content:_model.identify]];
    [_datas addObject:[TitleContentModel buildModel:MSG_PROFILE_PHONENUM content:_model.phoneNum]];
    if(_delegate){
        [_delegate onUpdateProfile];
    }
}


-(void)goFaceEnterPage{
    if(_delegate){
        [_delegate onGoFaceEnterPage];
    }
}

-(void)goAuthStatuPage{
    if(_delegate){
        [_delegate onGoAuthStatuPage];
    }
}


@end
