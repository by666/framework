//
//  AuthStatuViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/24.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "AuthStatuViewModel.h"
#import "STNetUtil.h"
#import "AccountManager.h"

@implementation AuthStatuViewModel


-(void)doHurryRequest{
    if(_delegate){
        [_delegate onRequestBegin];
        WS(weakSelf)
        [STNetUtil post:URL_REMIND content:@"" success:^(RespondModel *respondModel) {
            if([respondModel.status isEqualToString:STATU_SUCCESS]){
                [weakSelf.delegate onRequestSuccess:respondModel data:nil];
            }else{
                [weakSelf.delegate onRequestFail:respondModel.msg];
            }
        } failure:^(int errorCode) {
            [weakSelf.delegate onRequestFail:[NSString stringWithFormat:@"%d",errorCode]];
        }];
    }
}

-(void)verifyUser{
    ApplyModel *applyModel = [[AccountManager sharedAccountManager] getApplyModel];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"applyId"] = @(applyModel.verifyId);
    if(applyModel.applyType == Live_Renter){
        dic[@"overdue"] = @"1546075507000";
    }else{
        dic[@"overdue"] = @"";
    }
    WS(weakSelf)
    [STNetUtil get:URL_VERIFY_USER parameters:dic success:^(RespondModel *repondModel) {
        if([repondModel.status isEqualToString:STATU_SUCCESS]){
            [weakSelf.delegate onRequestSuccess:repondModel data:repondModel.data];
        }else{
            [weakSelf.delegate onRequestFail:repondModel.msg];
        }
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}

@end
