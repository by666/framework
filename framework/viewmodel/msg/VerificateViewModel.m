//
//  VerificateViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/31.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "VerificateViewModel.h"
#import "TitleContentModel.h"
#import "STNetUtil.h"
@implementation VerificateViewModel


-(instancetype)initWithModel:(MessageModel *)model{
    if(self == [super init]){
        _model = model;
        _datas = [[NSMutableArray alloc]init];
        _vaildArray = [[NSMutableArray alloc]init];
        [self setupValidArray];
    }
    return self;
}

-(void)requestData{
    if(!_delegate){
        return;
    }
    [_delegate onRequestBegin];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"applyId"] = @(_model.mid);
    WS(weakSelf)
    [STNetUtil get:URL_GET_MESSAGE_APPLY parameters:dic success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            id data = respondModel.data;
            [weakSelf.datas addObject:[TitleContentModel buildModel:MSG_VERIFICATE_HEAD content:[data objectForKey:@"faceUrl"]]];
            [weakSelf.datas addObject:[TitleContentModel buildModel:MSG_VERIFICATE_NAME content:[data objectForKey:@"userName"]]];
            int applyType = [[data objectForKey:@"applyType"] intValue];
            [weakSelf.datas addObject:[TitleContentModel buildModel:MSG_VERIFICATE_IDENTIFY content:[STPUtil getLiveAttr:applyType]]];
            [weakSelf.datas addObject:[TitleContentModel buildModel:MSG_VERIFICATE_IDNUM content:[data objectForKey:@"creid"]]];
            [weakSelf.datas addObject:[TitleContentModel buildModel:MSG_VERIFICATE_PHONENUM content:[data objectForKey:@"mobile"]]];
            [weakSelf.delegate onRequestSuccess:respondModel data:data];
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];

}

-(void)setupValidArray{
    [_vaildArray addObject:MSG_VERIFICATE_DATE_QUATERYEAD];
    [_vaildArray addObject:MSG_VERIFICATE_DATE_HALF];
    [_vaildArray addObject:MSG_VERIFICATE_DATE_YEAR];
    [_vaildArray addObject:MSG_VERIFICATE_DATE_FOREVER];
    

}


-(void)doAgree:(bool)isAgree valid:(int)validType userTime:(NSString *)userTime{
    if(!_delegate){
        return;
    }
    [_delegate onRequestBegin];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"apply"] = @(isAgree);
    dic[@"applyId"] = @(_model.mid);
    dic[@"timeDot"] = @(validType);
    if(validType == 5){
        dic[@"userTime"] = userTime;
    }
    WS(weakSelf)
    [STNetUtil post:URL_POST_MESSAGE_APPLY content:[dic mj_JSONString] success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            if(isAgree){
                weakSelf.model.applyState = Granted;
            }else{
                weakSelf.model.applyState = Reject;
            }
            [weakSelf.delegate onRequestSuccess:respondModel data:weakSelf.model];
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
       } failure:^(int errorCode) {
           [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}


@end
