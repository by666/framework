//
//  HabitantViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/15.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "HabitantViewModel.h"
#import "STNetUtil.h"
#import "AccountManager.h"

@implementation HabitantViewModel

-(instancetype)initWithController:(BaseViewController *)controller{
    if(self == [super init]){
        self.controller = controller;
        _datas = [[NSMutableArray alloc]init];
    }
    return self;
}




-(void)requestDatas{
    if(_delegate){
        [_delegate onRequestBegin];

        LiveModel *liveModel = [[AccountManager sharedAccountManager]getLiveModel];
        WS(weakSelf)
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        dic[@"homeLocator"] = liveModel.homeLocator;
        dic[@"districtUid"] = liveModel.districtUid;
        [STNetUtil get:URL_GET_HABITANT parameters:dic success:^(RespondModel *respondModel) {
            if([respondModel.status isEqualToString:STATU_SUCCESS]){
                weakSelf.datas = [HabitantModel mj_objectArrayWithKeyValuesArray:respondModel.data];
                [weakSelf formatDates];
                [weakSelf.delegate onRequestSuccess:respondModel data:weakSelf.datas];
            }else{
                [weakSelf.delegate onRequestFail:respondModel.msg];
            }
        } failure:^(int errorCode) {
            [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
        }];
      }
    
}

-(void)formatDates{
    if(!IS_NS_COLLECTION_EMPTY(_datas)){
        @synchronized(self){
            for(HabitantModel *model in _datas){
                NSString *year = [model.overdue substringWithRange:NSMakeRange(0, 4)];
                NSString *month = [model.overdue substringWithRange:NSMakeRange(5, 2)];
                NSString *day = [model.overdue substringWithRange:NSMakeRange(8, 2)];
                model.overdue = [NSString stringWithFormat:@"%@年%@月%@日",year,month,day];
            }
        }
    }
}


-(void)deleteHabitant:(HabitantModel *)model{
    if(_delegate){
        [_delegate onRequestBegin];
        LiveModel *liveModel = [[AccountManager sharedAccountManager]getLiveModel];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        dic[@"districtUid"] = liveModel.districtUid;
        dic[@"homeLocator"] = liveModel.homeLocator;
        dic[@"userUid"] = model.userUid;
        NSString *overdue = [model.overdue stringByReplacingOccurrencesOfString:@"年" withString:@"-"];
        overdue = [overdue stringByReplacingOccurrencesOfString:@"月" withString:@"-"];
        overdue = [overdue stringByReplacingOccurrencesOfString:@"日" withString:@""];
        dic[@"overdue"] = overdue;
        WS(weakSelf)
        [STNetUtil post:URL_DELETE_HABITANT content:dic.mj_JSONString success:^(RespondModel *respondModel) {
            if([respondModel.status isEqualToString:STATU_SUCCESS]){
                [weakSelf.datas removeObject:model];
                [weakSelf.delegate onRequestSuccess:respondModel data:respondModel.data];
            }else{
                [weakSelf.delegate onRequestFail:respondModel.msg];
            }
        } failure:^(int errorCode) {
            [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
            
        }];
    }
}


-(void)goUserInfoPage:(HabitantModel *)model{
    if(_delegate){
        [_delegate onGoUserInfoPage:model];
    }
}


@end
