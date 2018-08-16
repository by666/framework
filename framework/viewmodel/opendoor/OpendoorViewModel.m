//
//  OpendoorViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/6/6.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "OpendoorViewModel.h"
#import "AccountManager.h"
#import "STNetUtil.h"
#import "STUserDefaults.h"
#import "STTimeUtil.h"

@implementation OpendoorViewModel

-(void)generateTempLock{
    if(_delegate){
        [_delegate onRequestBegin];
        LiveModel *liveModel = [[AccountManager sharedAccountManager]getLiveModel];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        dic[@"districtUid"] = liveModel.districtUid;
        WS(weakSelf)
        [STNetUtil get:URL_OPENDOOR parameters:dic success:^(RespondModel *respondModel) {
            if([respondModel.status isEqualToString:STATU_SUCCESS]){
                NSString *codeStr = [respondModel.data objectForKey:@"password"];
                [STUserDefaults saveKeyValue:@"opencode" value:codeStr];
                NSString *dateStr =[STTimeUtil generateDate_CH:[STTimeUtil getCurrentTimeStamp]];
                [STUserDefaults saveKeyValue:@"opendoor" value:dateStr];
                [weakSelf.delegate onRequestSuccess:respondModel data:codeStr];
            }else{
                [weakSelf.delegate onRequestFail:respondModel.msg];
            }
        } failure:^(int errorCode) {
            [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
        }];
        
    }
}


-(void)doShare:(NSString *)codeStr{
    if(_delegate){
        [_delegate onDoShare:codeStr];
    }
}
@end
