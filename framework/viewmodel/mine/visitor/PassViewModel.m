//
//  PassViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/6/27.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "PassViewModel.h"
#import "STNetUtil.h"
#import "AccountManager.h"

@implementation PassViewModel

-(void)deletePass:(NSString *)userUid checkId:(NSString *)checkId{
    if(_delegate){
        [_delegate onRequestBegin];
        LiveModel *liveModel = [[AccountManager sharedAccountManager]getLiveModel];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        dic[@"userUid"] = userUid;
        dic[@"id"] = checkId;
        dic[@"districtUid"] = liveModel.districtUid;
        WS(weakSelf)
        [STNetUtil get:URL_DELETE_PRECHECKIN parameters:dic success:^(RespondModel *respondModel) {
            if([respondModel.status isEqualToString:STATU_SUCCESS]){
                [weakSelf.delegate onRequestSuccess:respondModel data:respondModel.data];
            }else{
                [weakSelf.delegate onRequestFail:respondModel.msg];
            }
        } failure:^(int errorCode) {
            [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
        }];
    }
}


-(void)goVisitorPage{
    if(_delegate){
        [_delegate onGoVisitorPage:_mVisitorModel];
    }
}
@end
