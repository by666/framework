//
//  AddMemberViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/17.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "AddMemberViewModel.h"
#import "STNetUtil.h"
#import "STUploadImageUtil.h"
@interface AddMemberViewModel()

@property(strong, nonatomic)MemberModel *originModel;

@end

@implementation AddMemberViewModel

-(instancetype)initWithData:(MemberModel *)model{
    if(self == [super init]){
        _model = model;
        _originModel =  [MemberModel buildModel:_model.nickname homeLocator:_model.homeLocator cretype:0 creid:_model.creid faceUrl:_model.faceUrl districtUid:_model.districtUid userUid:_model.userUid];
    }
    return self;
}


//上传添加成员头像
-(void)addMemberModel{
    if(_delegate){
        [_delegate onRequestBegin];
//        UIImage *image = [UIImage imageWithContentsOfFile:_model.faceUrl];
//        WS(weakSelf)
//        [STNetUtil upload:image url:URL_UPLOAD_IMAGE success:^(RespondModel *respondModel) {
//            weakSelf.model.faceUrl = [respondModel.data objectForKey:@"path"];
//            [self uploadAddMember];
//        } failure:^(int errorCode) {
//            [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
//        }];
        WS(weakSelf)
        [[STUploadImageUtil sharedSTUploadImageUtil]uploadImageForOSS:_model.facePath success:^(NSString *imageUrl) {
            weakSelf.model.faceUrl = imageUrl;
            [self uploadAddMember];
        } failure:^(NSString *errorStr) {
            [weakSelf.delegate onRequestFail:errorStr];
        }];
    }

}

//添加成员
-(void)uploadAddMember{
    if(_delegate){
        WS(weakSelf)
        MemberModel *model = [MemberModel buildModel:_model.nickname homeLocator:_model.homeLocator cretype:0 creid:_model.creid faceUrl:_model.faceUrl districtUid:_model.districtUid userUid:_model.userUid];
        NSString *jsonStr = [model mj_JSONString];
        [STNetUtil post:URL_ADDFAMILY_MEMBER content:jsonStr success:^(RespondModel *respondModel) {
            if([respondModel.status isEqualToString:STATU_SUCCESS]){
                [weakSelf.delegate onRequestSuccess:respondModel data:model];
            }else{
                [weakSelf.delegate onRequestFail:respondModel.msg];
            }
        } failure:^(int errorCode) {
            [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
        }];
    }
}

-(void)deleteMemberModel:(MemberModel *)model{
    if(_delegate){
        WS(weakSelf)
        [_delegate onRequestBegin];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        dic[@"userUid"] = model.userUid;
        dic[@"homeLocator"] = model.homeLocator;
        dic[@"districtUid"] = model.districtUid;
        [STNetUtil get:URL_DELFAMILY_MEMBER parameters:dic success:^(RespondModel *respondModel) {
            if([respondModel.status isEqualToString:STATU_SUCCESS]){
                [weakSelf.delegate onRequestSuccess:respondModel data:model];
            }else{
                [weakSelf.delegate onRequestFail:respondModel.msg];
            }
        } failure:^(int errorCode) {
            [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
        }];
    }
}


-(void)checkUpdateMemberModel:(MemberModel *)model changePhoto:(Boolean)changePhoto{
    Boolean nickEqual = [_originModel.nickname isEqualToString:model.nickname];
    Boolean idNumEqual = [_originModel.creid isEqualToString:model.creid];
    if(_delegate){
        if(nickEqual && idNumEqual && !changePhoto){
            [self goLastPage];
        }else{
            [_delegate onCheckUpdate:model changePhoto:changePhoto];
        }
    }
}

-(void)updateMemberModel:(MemberModel *)model changePhoto:(Boolean)changePhoto{
    if(_delegate){
        [_delegate onRequestBegin];
        if(changePhoto){
//            UIImage *image = [UIImage imageWithContentsOfFile:model.faceUrl];
//            WS(weakSelf)
//            [STNetUtil upload:image url:URL_UPLOAD_IMAGE success:^(RespondModel *respondModel) {
//                model.faceUrl = [respondModel.data objectForKey:@"path"];
//                [weakSelf uploadUpdateMemberModel:model];
//            } failure:^(int errorCode) {
//                [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
//            }];
            WS(weakSelf)
            [[STUploadImageUtil sharedSTUploadImageUtil] uploadImageForOSS:model.facePath success:^(NSString *imageUrl) {
                model.faceUrl = imageUrl;
                [weakSelf uploadUpdateMemberModel:model];
            } failure:^(NSString *errorStr) {
                [weakSelf.delegate onRequestFail:errorStr];
            }];
            
        }else{
            [self uploadUpdateMemberModel:model];
        }
        
    }

}


-(void)uploadUpdateMemberModel:(MemberModel *)model{
    if(_delegate){
        WS(weakSelf)
//        [_delegate onRequestBegin];
        NSString *jsonStr = [model mj_JSONString];
        [STNetUtil post:URL_UPDATEFAMILY_MEMBER content:jsonStr success:^(RespondModel *respondModel) {
            if([respondModel.status isEqualToString:STATU_SUCCESS]){
                [weakSelf.delegate onRequestSuccess:respondModel data:model];
            }else{
                [weakSelf.delegate onRequestFail:respondModel.msg];
            }
        } failure:^(int errorCode) {
            [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
        }];
    }
}


-(void)goLastPage{
    if(_delegate){
        [_delegate onGoLastPage];
    }
}


-(void)doTakePhoto{
    if(_delegate){
        [_delegate onDoTakePhoto];
    }
}

@end
