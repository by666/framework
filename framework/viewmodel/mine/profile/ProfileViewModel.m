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

@implementation ProfileViewModel


-(instancetype)init{
    if(self == [super init]){
        _datas = [[NSMutableArray alloc]init];
        _model = [[ProfileModel alloc]init];
    }
    return self;
}


-(void)updateProfile{
    [_datas removeAllObjects];
    [_datas addObject:[TitleContentModel buildModel:MSG_PROFILE_AVATAR content:_model.avatarUrl]];
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

-(void)uploadHeadImage:(NSString *)imagePath{
    if(_delegate){
        [_delegate onUploadHeadImage:YES image:imagePath];
    }
}

-(void)goAuthStatuPage{
    if(_delegate){
        [_delegate onGoAuthStatuPage];
    }
}


@end
