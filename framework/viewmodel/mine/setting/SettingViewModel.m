//
//  SettingViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/16.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "SettingViewModel.h"
#import "TitleContentModel.h"
@implementation SettingViewModel

-(instancetype)init{
    if(self == [super init]){
        _datas = [[NSMutableArray alloc]init];
        [self initData];
    }
    return self;
}

-(void)initData{
    [_datas addObject:[TitleContentModel buildModel:MSG_SETTING_PUSH content:nil isSwitch:YES]];
    [_datas addObject:[TitleContentModel buildModel:MSG_SETTING_FACELOGIN content:nil isSwitch:YES]];
    [_datas addObject:[TitleContentModel buildModel:MSG_SETTING_UPDATE_PHONENUM content:@"186****6420" isSwitch:NO]];
    [_datas addObject:[TitleContentModel buildModel:MSG_SETTING_ABOUT content:@"v1.0" isSwitch:NO]];
}

-(Boolean)OpenPushFunction:(Boolean)openPush{
    return YES;
}

-(Boolean)OpenFaceLoginFunction:(Boolean)openFaceLogin{
    return YES;
}

-(void)logout{
    //todo 网络请求
    if(_delegate){
        [_delegate onLogout:YES];
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
