//
//  SettingViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/16.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "SettingViewModel.h"
#import "TitleContentModel.h"
#import "STNetUtil.h"
#import "AccountManager.h"
@implementation SettingViewModel

-(instancetype)init{
    if(self == [super init]){
        _datas = [[NSMutableArray alloc]init];
        [self initData];
    }
    return self;
}

-(void)initData{
    
    UserModel *model = [[AccountManager sharedAccountManager]getUserModel];
    [_datas addObject:[TitleContentModel buildModel:MSG_SETTING_PUSH content:nil isSwitch:YES]];
    [_datas addObject:[TitleContentModel buildModel:MSG_SETTING_FACELOGIN content:nil isSwitch:YES]];
    [_datas addObject:[TitleContentModel buildModel:MSG_SETTING_UPDATE_PHONENUM content:[STPUtil getSecretPhoneNum:model.phoneNum] isSwitch:NO]];
    [_datas addObject:[TitleContentModel buildModel:MSG_SETTING_ABOUT content:@"v1.0" isSwitch:NO]];
}

-(Boolean)OpenPushFunction:(Boolean)openPush{
    return YES;
}

-(Boolean)OpenFaceLoginFunction:(Boolean)openFaceLogin{
    return YES;
}

-(void)logout{
    if(_delegate){
        [_delegate onRequestBegin];
        
        WS(weakSelf)
        [STNetUtil post:URL_LOGOUT content:@"" success:^(RespondModel *respondModel) {
            if([respondModel.status isEqualToString:STATU_SUCCESS]){
                [[AccountManager sharedAccountManager] clearUserModel];
                [[AccountManager sharedAccountManager] clearLiveModel];
                [[AccountManager sharedAccountManager] clearMainModel];
                [[AccountManager sharedAccountManager] clearApplyModel];
                [[AccountManager sharedAccountManager] clearWYUserModel];

                [weakSelf.delegate onRequestSuccess:respondModel data:nil];
            }else{
                [weakSelf.delegate onRequestFail:respondModel.msg];
            }
        } failure:^(int errorCode) {
            [weakSelf.delegate onRequestFail:[NSString stringWithFormat:@"%d",errorCode]];
        }];
    }
    
}

-(void)goAboutPage{
    if(_delegate){
        [_delegate onGoAboutPage];
    }
}

-(void)goUpdatePhoneNumPage{
    if(_delegate){
        [_delegate onGoUpdatePhoneNumPage];
    }
}
@end
