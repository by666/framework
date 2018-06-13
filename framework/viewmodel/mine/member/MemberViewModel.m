//
//  MemberViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/17.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MemberViewModel.h"
#import "STNetUtil.h"


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
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        dic[@"districtUid"] = @"1";
        dic[@"homeLocator"] = @"1.0.1";
        [STNetUtil get:URL_GETFAMILY_MEMBER parameters:dic success:^(RespondModel *respondModel) {
            if([respondModel.status isEqualToString:STATU_SUCCESS]){
                weakSelf.datas = [MemberModel mj_objectArrayWithKeyValuesArray:respondModel.data];
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
        if(!IS_NS_COLLECTION_EMPTY(_datas)){
            for(int i = 0 ; i < [_datas count] ; i++){
                MemberModel *tempModel = [_datas objectAtIndex:i];
                if([tempModel.creid isEqualToString:model.creid]){
                    [_datas removeObjectAtIndex:i];
                    [_delegate onDeleteMember:YES model:model row:i];
                    break;
                }
            }
        }
    }
}

-(void)showWarnPrompt:(MemberModel *)model{
    if(_delegate){
        [_delegate onShowWarnPrompt:model];
    }
}



@end
