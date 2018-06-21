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

-(HabitantModel *)buildModel:(NSString *)name identify:(NSString *)identify validDate:(NSString *)validDate{
    HabitantModel *model = [[HabitantModel alloc]init];
    model.name = name;
    model.identify = identify;
    model.validDate = validDate;
    return model;
}



-(void)requestDatas{
    if(_delegate){
        [_delegate onRequestBegin];
    }
    LiveModel *liveModel = [[AccountManager sharedAccountManager]getLiveModel];
    WS(weakSelf)
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"homeLocator"] = liveModel.homeLocator;
    dic[@"districtUid"] = liveModel.districtUid;
    [STNetUtil get:URL_GET_HABITANT parameters:dic success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            [weakSelf.delegate onRequestSuccess:respondModel data:nil];
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
    

}


-(void)deleteHabitant:(HabitantModel *)model{
    
}

-(void)updateHabitant:(HabitantModel *)model{
    
}

@end
