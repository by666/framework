//
//  UserInfoViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/8/14.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "UserInfoViewModel.h"
#import "STNetUtil.h"
#import "AccountManager.h"
#import "TitleContentModel.h"

@implementation UserInfoViewModel

-(instancetype)initWithModel:(HabitantModel *)model{
    if(self == [super init]){
        _model = model;
        _datas = [[NSMutableArray alloc]init];
        [self setupDatas];
    }
    return self;
}

-(void)setupDatas{
    [_datas addObject:[TitleContentModel buildModel:MSG_VERIFICATE_HEAD content:_model.headUrl]];
    [_datas addObject:[TitleContentModel buildModel:MSG_VERIFICATE_NAME content:_model.userName]];
    [_datas addObject:[TitleContentModel buildModel:MSG_VERIFICATE_IDENTIFY content:[STPUtil getLiveAttr:_model.liveAttr]]];
    [_datas addObject:[TitleContentModel buildModel:MSG_VERIFICATE_IDNUM content:_model.creid]];
    [_datas addObject:[TitleContentModel buildModel:MSG_VERIFICATE_PHONENUM content:_model.mobile]];
}


-(void)updateHabitant{
    if(_delegate){
        [_delegate onRequestBegin];
        LiveModel *liveModel = [[AccountManager sharedAccountManager]getLiveModel];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        dic[@"districtUid"] = liveModel.districtUid;
        dic[@"homeLocator"] = liveModel.homeLocator;
        dic[@"userUid"] = _model.userUid;
        NSString *overdue = [_model.overdue stringByReplacingOccurrencesOfString:@"年" withString:@"-"];
        overdue = [overdue stringByReplacingOccurrencesOfString:@"月" withString:@"-"];
        overdue = [overdue stringByReplacingOccurrencesOfString:@"日" withString:@""];
        dic[@"overdue"] = overdue;
        WS(weakSelf)
        [STNetUtil post:URL_UPDATE_HABITANT content:dic.mj_JSONString success:^(RespondModel *respondModel) {
            if([respondModel.status isEqualToString:STATU_SUCCESS]){
                [weakSelf.delegate onRequestSuccess:respondModel data:respondModel.data];
            }else{
                [weakSelf.delegate onRequestFail:respondModel.msg];
            }
        } failure:^(int errorCode) {
            [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
            
        }];
    }
}


@end
