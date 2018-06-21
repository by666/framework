//
//  MainViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/9.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MainViewModel.h"
#import "STNetUtil.h"
#import "AccountManager.h"
#import "MainModel.h"

@implementation MainViewModel


-(instancetype)init{
    if(self == [super init]){
        
    }
    return self;
}


-(void)goOpendoorPage{
    if(_delegate){
        [_delegate onGoOpendoorPage];
    }
}

-(void)goCarPage{
    if(_delegate){
        [_delegate onGoCarPage];
    }
}

-(void)goVisitorPage{
    if(_delegate){
        [_delegate onGoVisitorPage];
    }
}

-(void)goVisitorHistoryPage{
    if(_delegate){
        [_delegate onGoVisitorHistoryPage];
    }
}

-(void)goReportFixPage{
    if(_delegate){
        [_delegate onGoReportFixPage];
    }
}

-(void)goDeviceSharePage{
    if(_delegate){
        [_delegate onGoDeviceSharePage];
    }
}

-(void)doCallProperty{
    if(_delegate){
        [_delegate onDoCallProperty];
    }
}

-(void)goMessagePage{
    if(_delegate){
        [_delegate onGoMessagePage];
    }
}

-(void)goMinePage{
    if(_delegate){
        [_delegate onGoMinePage];
    }
}

-(void)getUserInfo{
    WS(weakSelf)
    [STNetUtil get:URL_GETUSERINFO parameters:nil success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            if(weakSelf.delegate){
                UserModel *data = [[AccountManager sharedAccountManager]getUserModel];
                data.cretype = [[respondModel.data objectForKey:@"cretype"] intValue];
                data.creid = [respondModel.data valueForKey:@"creid"];
                data.headUrl = [respondModel.data valueForKey:@"headUrl"];
                data.userName = [respondModel.data valueForKey:@"userName"];
                [[AccountManager sharedAccountManager]saveUserModel:data];
                [weakSelf.delegate onRequestSuccess:respondModel data:data];
            }else{
                [weakSelf.delegate onRequestFail:respondModel.msg];
            }
        }
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}


-(void)getLiveInfo{
    WS(weakSelf)
   [STNetUtil get:URL_GETLIVEINFO parameters:nil success:^(RespondModel *respondModel) {
       if([respondModel.status isEqualToString:STATU_SUCCESS]){
           LiveModel *model = [LiveModel mj_objectWithKeyValues:respondModel.data];
           [[AccountManager sharedAccountManager]saveLiveModel:model];
           [weakSelf.delegate onRequestSuccess:respondModel data:respondModel.data];
           [self getMainInfo:model.districtUid];
       }else{
           [weakSelf.delegate onRequestFail:respondModel.status];
       }
   } failure:^(int errorCode) {
       [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
   }];
}

-(void)getMainInfo:(NSString *)districtUid{
    WS(weakSelf)
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"districtUid"] = districtUid;
    [STNetUtil get:URL_GETMAININFO parameters:dic success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            weakSelf.model = [MainModel mj_objectWithKeyValues:respondModel.data];
            [[AccountManager sharedAccountManager]saveMainModel:weakSelf.model];
            [weakSelf.delegate onRequestSuccess:respondModel data:weakSelf.model];
        }else{
            [weakSelf.delegate onRequestFail:respondModel.status];
        }
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}
@end
