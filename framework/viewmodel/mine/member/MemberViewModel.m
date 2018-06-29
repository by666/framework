//
//  MemberViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/17.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MemberViewModel.h"
#import "STNetUtil.h"
#import "AccountManager.h"

@implementation MemberViewModel


-(instancetype)init{
    if(self == [super init]){
        _datas = [[NSMutableArray alloc]init];
    }
    return self;
}


-(void)requestMemberDatas{
    if(_delegate){
        WS(weakSelf)
        [_delegate onRequestBegin];
        LiveModel *model =  [[AccountManager sharedAccountManager]getLiveModel];
        UserModel *userModel = [[AccountManager sharedAccountManager]getUserModel];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        dic[@"districtUid"] = model.districtUid;
        dic[@"homeLocator"] = model.homeLocator;
        [STNetUtil get:URL_GETFAMILY_MEMBER parameters:dic success:^(RespondModel *respondModel) {
            if([respondModel.status isEqualToString:STATU_SUCCESS]){
                weakSelf.datas = [MemberModel mj_objectArrayWithKeyValuesArray:respondModel.data];
                MemberModel *memberModel = [MemberModel buildModel:userModel.userName homeLocator:model.homeLocator cretype:userModel.cretype creid:userModel.creid faceUrl:userModel.headUrl districtUid:model.districtUid userUid:model.userUid];
                memberModel.identify = MSG_MEMBER_ROOT;
                [weakSelf.datas insertObject:memberModel atIndex:0];
                [weakSelf.delegate onRequestSuccess:respondModel data:weakSelf.datas];
            }else{
                [weakSelf.delegate onRequestFail:respondModel.msg];
            }
        } failure:^(int errorCode) {
            [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
        }];
    }
}


-(void)goAddMemberView{
    if(_delegate){
        [_delegate onGoAddMemberView];
    }
}

-(void)goEditMemberView:(MemberModel *)model{
    if(_delegate){
        [_delegate onGoEditMemberView:model];
    }
}


-(void)deleteMember:(MemberModel *)model{
    if(_delegate){
        WS(weakSelf)
        [_delegate onRequestBegin];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        dic[@"userUid"] = model.userUid;
        dic[@"homeLocator"] = model.homeLocator;
        dic[@"districtUid"] = model.districtUid;
        [STNetUtil get:URL_DELFAMILY_MEMBER parameters:dic success:^(RespondModel *respondModel) {
            if([respondModel.status isEqualToString:STATU_SUCCESS]){
                [weakSelf.datas removeObject:model];
                [weakSelf.delegate onRequestSuccess:respondModel data:model];
            }else{
                [weakSelf.delegate onRequestFail:respondModel.msg];
            }
        } failure:^(int errorCode) {
            [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
        }];
    }
    
}

-(void)showWarnPrompt:(MemberModel *)model{
    if(_delegate){
        [_delegate onShowWarnPrompt:model];
    }
}



@end
