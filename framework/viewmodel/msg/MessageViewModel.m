//
//  MessageViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/29.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MessageViewModel.h"
#import "STNetUtil.h"
#import "AccountManager.h"

@implementation MessageViewModel{
    int pageId;
}

-(instancetype)init{
    if(self == [super init]){
        _datas = [[NSMutableArray alloc]init];
        pageId = 0;
    }
    return self;
}


-(void)requestMessageList:(Boolean)isRequestMore{
    if(!_delegate){
        return;
    }
    if(!isRequestMore){
        pageId = 0;
        [_delegate onRequestBegin];
    }
    pageId++;
    LiveModel *liveModel = [[AccountManager sharedAccountManager] getLiveModel];
    NSString *districtUid = liveModel.districtUid;
    NSString *homeLocator = liveModel.homeLocator;
    if(IS_NS_STRING_EMPTY(liveModel.districtUid) || IS_NS_STRING_EMPTY(liveModel.homeLocator)){
        ApplyModel *applyModel = [[AccountManager sharedAccountManager]getApplyModel];
        districtUid = applyModel.districtUid;
        homeLocator = applyModel.homeLocator;
    }
    if(IS_NS_STRING_EMPTY(districtUid) || IS_NS_STRING_EMPTY(homeLocator)){
        [_delegate onRequestFail:@""];
        return;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"messageType"] = @"0";
    dic[@"districtUid"] = districtUid;
    dic[@"homeLocator"] = homeLocator;
    dic[@"pageId"] = @(pageId);
    WS(weakSelf)
    [STNetUtil get:URL_GET_MESSAGELIST parameters:dic success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            id data = respondModel.data;
            id rows = [data objectForKey:@"rows"];
            NSMutableArray *datas = [MessageModel mj_objectArrayWithKeyValuesArray:rows];
            Boolean hasMoreData = YES;
            if(IS_NS_COLLECTION_EMPTY(datas)){
                hasMoreData = NO;
            }
            if(isRequestMore){
                [weakSelf.datas addObjectsFromArray:datas];
            }else{
                weakSelf.datas = datas;
            }
            [weakSelf.delegate onRequestSuccess:respondModel data:@(hasMoreData)];
            
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}



-(void)goSystemPage{
    if(_delegate){
        [_delegate onGoSystemPage];
    }
}

-(void)goPropertyPage{
    if(_delegate){
        [_delegate onGoPropertyPage];
    }
}

-(void)goMessageDetailPage:(MessageModel *)model{
    if(_delegate){
        [_delegate onGoMessageDetailPage:model];
    }
}


-(void)doAgree:(MessageModel *)model{
    if(IS_NS_COLLECTION_EMPTY(_datas)){
        return;
    }
    for(MessageModel *data in _datas){
        if(model.mid == data.mid){
            data.applyState = Granted;
        }
    }
    if(_delegate){
        [_delegate onDataChange];
    }
}


-(void)doReject:(MessageModel *)model{
    if(IS_NS_COLLECTION_EMPTY(_datas)){
        return;
    }
    for(MessageModel *data in _datas){
        if(model.mid == data.mid){
            data.applyState = Reject;
        }
    }
    if(_delegate){
        [_delegate onDataChange];
    }
}

-(void)goAuthUserPage{
    if(_delegate){
        [_delegate onGoAuthUserPage];
    }
}


@end
