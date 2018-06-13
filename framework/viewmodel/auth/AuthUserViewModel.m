//
//  AuthUserViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/24.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "AuthUserViewModel.h"
#import "STNetUtil.h"
#import "BuildingRespondModel.h"

@implementation AuthUserViewModel

-(instancetype)init{
    if(self == [super init]){
        _data = [[UserAuthModel alloc]init];
    }
    return self;
}


-(void)goCommunityPage{
    if(_delegate){
        [_delegate onGoCommunity];
    }
}

-(void)submitUserInfo{
    if(_delegate){
        if(IS_NS_STRING_EMPTY(_data.communityName)){
            [_delegate submitUserInfo:NO msg:MSG_AUTHUSER_ERROR_NOCOMMUNITY];
            return;
        }
        if(IS_NS_STRING_EMPTY(_data.building)){
            [_delegate submitUserInfo:NO msg:MSG_AUTHUSER_ERROR_NOBUILDING];
            return;
        }
        if(IS_NS_STRING_EMPTY(_data.doorNum)){
            [_delegate submitUserInfo:NO msg:MSG_AUTHUSER_ERROR_NODOORNUM];
            return;
        }
        if(IS_NS_STRING_EMPTY(_data.name)){
            [_delegate submitUserInfo:NO msg:MSG_AUTHUSER_ERROR_NONAME];
            return;
        }
        if(IS_NS_STRING_EMPTY(_data.idNum)){
            [_delegate submitUserInfo:NO msg:MSG_AUTHUSER_ERROR_NOIDNUM];
            return;
        }
        [_delegate submitUserInfo:YES msg:MSG_SUCCESS];
    }
}


-(void)getCommunityPosition:(CGFloat)longtitude latitude:(CGFloat)latitude{
    if(_delegate){
        [_delegate onRequestBegin];
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"longtitude"] = @(longtitude);
    dic[@"latitude"] = @(latitude);
    WS(weakSelf)
    [STNetUtil get:URL_GETCOMMUNITYPOSITION parameters:dic success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            CommunityPositionModel *data = [CommunityPositionModel mj_objectWithKeyValues:respondModel.data];
            [weakSelf.delegate onRequestSuccess:respondModel data:data];
            [self getCommunityLayer:data];
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}

-(void)getCommunityLayer:(CommunityPositionModel *)model{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"districtUid"] = model.districtUid;
    WS(weakSelf)
    [STNetUtil get:URL_GETCOMMUNITYLAYER parameters:dic success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            [self formatData:respondModel.data];
        }else{\
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}

-(void)formatData:(id)data{
    NSMutableArray *array = [NSMutableArray mj_objectArrayWithKeyValuesArray:data];
    for(int i = 0 ; i < [array count] ; i ++) {
        BuildingRespondModel *model = [BuildingRespondModel mj_objectWithKeyValues:[array objectAtIndex:i]];
        NSMutableArray *array1 = [NSMutableArray mj_objectArrayWithKeyValuesArray:model.subLayerInfo];
        for(int j = 0 ; j < [array1 count] ; j ++){
            BuildingRespondModel *model1 = [BuildingRespondModel mj_objectWithKeyValues:[array1 objectAtIndex:i]];
            NSMutableArray *array2 = [NSMutableArray mj_objectArrayWithKeyValuesArray:model1.subLayerInfo];
            for(int m = 0 ; m < [array2 count] ; m ++){
                BuildingRespondModel *model2 = [BuildingRespondModel mj_objectWithKeyValues:[array2 objectAtIndex:i]];

                [STLog print:[NSString stringWithFormat:@"%@,%@,%@",model.layerInfo.layerName,model1.layerInfo.layerName,model2.layerInfo.layerName]];
                
                
            }
        }
    }
}

@end
