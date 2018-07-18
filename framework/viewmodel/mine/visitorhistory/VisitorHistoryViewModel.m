//
//  VisitorHistoryViewModel.m
//  framework
//
//  Created by by.huang on 2018/5/23.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "VisitorHistoryViewModel.h"
#import "STNetUtil.h"
#import "AccountManager.h"
@implementation VisitorHistoryViewModel


-(instancetype)init{
    if(self == [super init]){
        _datas = [[NSMutableArray alloc]init];
    }
    return self;
}


-(void)getVisitoryHistoryDatas{
    if(_delegate){
        [_delegate onRequestBegin];
        LiveModel *liveModel = [[AccountManager sharedAccountManager]getLiveModel];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        dic[@"districtUid"] = liveModel.districtUid;
        WS(weakSelf)
        [STNetUtil get:URL_CHECKIN_HISTORY parameters:dic success:^(RespondModel *respondModel) {
            if([respondModel.status isEqualToString:STATU_SUCCESS]){
                weakSelf.datas = [VisitorHistoryModel mj_objectArrayWithKeyValuesArray:respondModel.data];
                [weakSelf.delegate onRequestSuccess:respondModel data:weakSelf.datas];
            }else{
                [weakSelf.delegate onRequestFail:respondModel.msg];
            }
        } failure:^(int errorCode) {
            [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
        }];
    }
}

-(void)goVisitorPage:(VisitorModel *)model{
    if(_delegate){
        [_delegate onGoVisitorPage:model];
    }
}

@end
