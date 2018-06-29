//
//  AuthFaceViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/28.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "AuthFaceViewModel.h"
#import "STNetUtil.h"
#import "STUploadImageUtil.h"
@interface AuthFaceViewModel()

@end

@implementation AuthFaceViewModel

-(instancetype)initWithModel:(UserCommitModel *)model{
    if(self == [super init]){
        _userCommitModel = model;
    }
    return self;
}

-(void)addPhoto{
    if(_delegate){
        [_delegate onAddPhoto];
    }
}

-(void)commitUserInfo{
    if(_delegate){
//        [_delegate onRequestBegin];
//        UIImage *image = [UIImage imageWithContentsOfFile:_userCommitModel.facePath];
//        WS(weakSelf)
//        [STNetUtil upload:image url:URL_UPLOAD_IMAGE success:^(RespondModel *respondModel) {
//            weakSelf.userCommitModel.faceUrl = [respondModel.data objectForKey:@"path"];
//            [self upload];
//        } failure:^(int errorCode) {
//            [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
//        }];
        
        [_delegate onRequestBegin];
        WS(weakSelf)
        [[STUploadImageUtil sharedSTUploadImageUtil]uploadImageForOSS:_userCommitModel.facePath success:^(NSString *imageUrl) {
            weakSelf.userCommitModel.faceUrl = imageUrl;
            [self upload];
        } failure:^(NSString *errorStr) {
            [weakSelf.delegate onRequestFail:errorStr];
        }];
    }

}


-(void)upload{
    if(_delegate){
        NSString *jsonStr = [self buildCommitInfoStr];
        [STLog print:@"提交的用户数据" content:jsonStr];
        WS(weakSelf)
        [STNetUtil post:URL_UPLOADUSERINFO content:jsonStr success:^(RespondModel *respondModel) {
            if([respondModel.status isEqualToString:STATU_SUCCESS]){
                [weakSelf.delegate onRequestSuccess:respondModel data:nil];
            }else{
                [weakSelf.delegate onRequestFail:respondModel.status];
            }
        } failure:^(int errorCode) {
            [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
        }];
    }
}



-(void)goMainPage{
    if(_delegate){
        [_delegate onGoMainPage];
    }
}

-(NSString *)buildCommitInfoStr{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"faceUrl"] = _userCommitModel.faceUrl;
    
    NSMutableDictionary *liveDic = [[NSMutableDictionary alloc]init];
    liveDic[@"districtUid"] = _userCommitModel.districtUid;
    liveDic[@"homeLocator"] = _userCommitModel.homeLocator;
    liveDic[@"liveAttr"] = _userCommitModel.liveAttr;
    
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc]init];
    userDic[@"creid"] = _userCommitModel.creid;
    userDic[@"cretype"] = _userCommitModel.cretype;
    userDic[@"userName"] = _userCommitModel.userName;
    userDic[@"headUrl"] = _userCommitModel.faceUrl;

    dic[@"liveUserInfo"] = liveDic;
    dic[@"userInfo"]  = userDic;
    
    return [dic mj_JSONString];
}
@end
