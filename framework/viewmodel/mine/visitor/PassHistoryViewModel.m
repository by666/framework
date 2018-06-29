//
//  PassHistoryViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/6/27.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "PassHistoryViewModel.h"
#import "STNetUtil.h"
#import "AccountManager.h"

@implementation PassHistoryViewModel

-(instancetype)init{
    if(self == [super init]){
        _datas = [[NSMutableArray alloc]init];
    }
    return self;
}


-(void)requestDatas{
    if(_delegate){
        [_datas removeAllObjects];
        [_delegate onRequestBegin];
        LiveModel *liveModel = [[AccountManager sharedAccountManager]getLiveModel];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        dic[@"districtUid"] = liveModel.districtUid;
        WS(weakSelf)
        [STNetUtil get:URL_PRECHECKIN_HISTORY parameters:dic success:^(RespondModel *respondModel) {
            if([respondModel.status isEqualToString:STATU_SUCCESS]){
                weakSelf.datas = [PassHistoryModel mj_objectArrayWithKeyValuesArray:respondModel.data];
                [weakSelf.delegate onRequestSuccess:respondModel data:weakSelf.datas];
            }else{
                [weakSelf.delegate onRequestFail:respondModel.msg];
            }
        } failure:^(int errorCode) {
            [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
        }];
    }
}

-(void)goPassPage:(PassHistoryModel *)model{
    if(_delegate){
        [_delegate onGoPassPage:model];
    }
}


@end
