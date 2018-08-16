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
#import "BuildingModel.h"
#import "RecognizeModel.h"
#import "AccountManager.h"

@interface AuthUserViewModel()


@end

@implementation AuthUserViewModel{
    int count;
}

-(instancetype)init{
    if(self == [super init]){
        _data = [[UserAuthModel alloc]init];
        _userCommitModel =[[UserCommitModel alloc]init];
        _userCommitModel.liveAttr = [NSString stringWithFormat:@"%ld",Live_Owner];
    }
    return self;
}


-(void)goCommunityPage{
    if(_delegate){
        [_delegate onGoCommunity];
    }
}

#pragma mark 提交用户信息
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
        if(![STPUtil isIdNumberValid:_data.idNum]){
            [_delegate submitUserInfo:NO msg:MSG_AUTHUSER_ERROR_ERRORIDNUM];
            return;
        }
        if(IS_NS_STRING_EMPTY(_data.idNum)){
            [_delegate submitUserInfo:NO msg:MSG_AUTHUSER_ERROR_NOIDNUM];
            return;
        }
        
        _userCommitModel.userName = _data.name;
        _userCommitModel.cretype = @"0";
        _userCommitModel.creid = _data.idNum;
        _userCommitModel.districtUid = _districtUid;
        
        [_delegate submitUserInfo:YES msg:MSG_SUCCESS];
    }
}




#pragma mark 小区定位
-(void)getCommunityPosition:(CGFloat)longtitude latitude:(CGFloat)latitude{
    ApplyModel *applyModel = [[AccountManager sharedAccountManager]getApplyModel];
    if(applyModel && !IS_NS_STRING_EMPTY(applyModel.districtUid) && !IS_NS_STRING_EMPTY(applyModel.homeLocator)){
        if(_delegate){
            CommunityPositionModel *model = [[CommunityPositionModel alloc]init];
            model.districtUid = applyModel.districtUid;
            int strCount =  (int)[self countOccurencesOfString:applyModel.homeFullName countStr:@","];
            if(strCount < 1){
                [[AccountManager sharedAccountManager]clearApplyModel];
                [self getCommunityPosition:longtitude latitude:latitude];
            }
            model.layerLevel = (int)[self countOccurencesOfString:applyModel.homeFullName countStr:@","] -1;
            NSString *homeFullName = [applyModel.homeFullName componentsSeparatedByString:@","][0];
            RespondModel *respondModel = [[RespondModel alloc]init];
            respondModel.requestUrl = URL_GETCOMMUNITYPOSITION;
            [_delegate onRequestSuccess:respondModel data:homeFullName];
            [self getCommunityLayer:model];
        }
    }else{
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
                    CommunityPositionModel *data = [datas objectAtIndex:1];
                    [weakSelf.delegate onRequestSuccess:respondModel data:data.districtName];
                    [self getCommunityLayer:data];
                }else{
                    [weakSelf.delegate onRequestSuccess:respondModel data:MSG_AUTHUSER_POSITION_ERROR];
                }
            }else{
                [weakSelf.delegate onRequestFail:respondModel.msg];
            }
        } failure:^(int errorCode) {
            [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
        }];
    }
}

#pragma mark 小区楼栋查询
-(void)getCommunityLayer:(CommunityPositionModel *)model{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"districtUid"] = model.districtUid;
    WS(weakSelf)
    [STNetUtil get:URL_GETCOMMUNITYLAYER parameters:dic success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            weakSelf.districtUid = model.districtUid;
            [weakSelf.delegate onRequestSuccess:respondModel data:[NSString stringWithFormat:@"%d",model.layerLevel]];
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}


#pragma mark 小区门牌查询
-(void)getCommunityDoor:(NSString *)queryString{

    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"districtUid"] = _districtUid;
    dic[@"fatherLocator"] = _fatherLocator ;
    dic[@"queryString"] = queryString;

    NSString *content = [dic mj_JSONString];
    WS(weakSelf)
    [STNetUtil post:URL_GETCOMMUNITYDOOR content:content success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS] || [respondModel.status isEqualToString:STATU_CHECKIN_DOOR_NULL]){
            NSMutableArray *datas = [RecognizeModel mj_objectArrayWithKeyValuesArray:respondModel.data];
            [weakSelf.delegate onRequestSuccess:respondModel data:datas];
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
    
}


- (NSInteger)countOccurencesOfString:(NSString *)originStr countStr:(NSString*)countStr {
    NSInteger strCount = [originStr length] - [[originStr stringByReplacingOccurrencesOfString:countStr withString:@""] length];
    return strCount;
}


@end
