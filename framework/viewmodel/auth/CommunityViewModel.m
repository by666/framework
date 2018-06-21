//
//  CommunityViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/25.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "CommunityViewModel.h"
#import "STNetUtil.h"
#import "CommunityPositionModel.h"

@implementation CommunityViewModel

-(instancetype)init{
    if(self == [super init]){
        _datas = [[NSMutableArray alloc]init];
    }
    return self;
}

#pragma mark 小区模糊查找
-(void)searchCommunity:(NSString *)keyStr{
    if(_delegate){
        if(IS_NS_STRING_EMPTY(keyStr)){
            [_delegate onRequestFail:MSG_COMMUNITY_KEYISEMPTY];
            return;
        }
         [_delegate onRequestBegin];
        [_datas removeAllObjects];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        dic[@"districtName"] = keyStr;
        dic[@"addrCode"] = @"111";
        WS(weakSelf)
        [STNetUtil get:URL_GETCOMMUNITYQUERY parameters:dic success:^(RespondModel *respondModel) {
            if([respondModel.status isEqualToString:STATU_SUCCESS]){
                NSMutableArray *datas = [CommunityPositionModel mj_objectArrayWithKeyValuesArray:respondModel.data];
                weakSelf.datas = datas;
                [weakSelf.delegate onRequestSuccess:respondModel data:datas];
            }else{
                [weakSelf.delegate onRequestFail:respondModel.msg];
            }
        } failure:^(int errorCode) {
            [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
        }];
        
    }
    
}

#pragma mark 小区定位
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
            NSMutableArray *datas = [CommunityPositionModel mj_objectArrayWithKeyValuesArray:respondModel.data];
            if(!IS_NS_COLLECTION_EMPTY(datas)){
                weakSelf.datas = datas;
                [weakSelf.delegate onRequestSuccess:respondModel data:datas];
            }
//            else{
//                [weakSelf.delegate onRequestSuccess:respondModel data:MSG_AUTHUSER_POSITION_ERROR];
//            }
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}

-(void)backLastPage{
    if(_delegate){
        [_delegate onBackLastPage];
    }
}
@end
