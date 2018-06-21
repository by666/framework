//
//  AuthStatuViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/24.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "AuthStatuViewModel.h"
#import "STNetUtil.h"

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

@end
