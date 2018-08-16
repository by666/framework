//
//  EnterAuthViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/30.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "EnterAuthViewModel.h"
#import "TitleContentModel.h"
#import "STNetUtil.h"

@implementation EnterAuthViewModel

-(instancetype)initWithData:(MessageModel *)model{
    if(self == [super init]){
        _model = model;
        _datas = [[NSMutableArray alloc]init];
    }
    return self;
}

-(void)buildDatas:(MessageModel *)model{
    if(!IS_NS_STRING_EMPTY(model.licenseNum)){
        [_datas addObject:[TitleContentModel buildModel:MSG_ENTERAUTH_VISITOR content:model.userName]];
        [_datas addObject:[TitleContentModel buildModel:MSG_ENTERAUTH_CARNUM content:model.licenseNum]];
    }else{
        [_datas addObject:[TitleContentModel buildModel:MSG_ENTERAUTH_VISITOR content:model.userName]];
    }
    [_datas addObject:[TitleContentModel buildModel:MSG_ENTERAUTH_TIME content:model.createTime]];
    [_datas addObject:[TitleContentModel buildModel:MSG_ENTERAUTH_POSITION content:@"小区大门门禁处"]];

}

-(void)requestData{
    if(!_delegate){
        return;
    }
    [_delegate onRequestBegin];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"applyId"] = @(_model.mid);
    WS(weakSelf)
    [STNetUtil get:URL_GET_MESSAGE_VISITOR parameters:dic success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            id data = respondModel.data;
            weakSelf.faceUrl = [data objectForKey:@"faceUrl"];
            NSString *licenseNum = [data objectForKey:@"licenseNum"];
            NSString *userName = [data objectForKey:@"userName"];
            NSString *createTime = [data objectForKey:@"createTime"];
            if(!IS_NS_STRING_EMPTY(licenseNum)){
                [weakSelf.datas addObject:[TitleContentModel buildModel:MSG_ENTERAUTH_CARNUM content:licenseNum]];
            }
            [weakSelf.datas addObject:[TitleContentModel buildModel:MSG_ENTERAUTH_VISITOR content:userName]];
            [weakSelf.datas addObject:[TitleContentModel buildModel:MSG_ENTERAUTH_TIME content:createTime]];
            [weakSelf.datas addObject:[TitleContentModel buildModel:MSG_ENTERAUTH_POSITION content:@"小区大门门禁处"]];
            [weakSelf.delegate onRequestSuccess:respondModel data:data];
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
    
}



-(void)doAgree:(MessageStatu)statu{
    if(!_delegate){
        return;
    }
    [_delegate onRequestBegin];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"applyState"] = @(statu);
    dic[@"applyId"] = @(_model.mid);

    WS(weakSelf)
    [STNetUtil post:URL_POST_MESSAGE_VISITOR content:[dic mj_JSONString] success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            weakSelf.model.applyState = statu;
            [weakSelf.delegate onRequestSuccess:respondModel data:weakSelf.model];
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}

@end
