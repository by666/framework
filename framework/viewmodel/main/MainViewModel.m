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
#import "MemberModel.h"
#import "MessageModel.h"
#import "TitleContentModel.h"

@implementation MainViewModel


-(instancetype)init{
    if(self == [super init]){
        _memberDatas = [[NSMutableArray alloc]init];
        _msgDatas = [[NSMutableArray alloc]init];
        _propertyDatas = [[NSMutableArray alloc]init];
        [self setupDatas];
    }
    return self;
}


-(void)setupDatas{
    NSArray *titles = [MSG_MAIN_TITLE_ARRAY2 componentsSeparatedByString:@"|"];
    NSArray *contents = @[@"首页_icon_手机开门",@"首页_icon_访客登记",@"首页_icon_最近来访",@"首页_icon_设备共享",@"首页_icon_室内保修",@"首页_icon_物管",@"首页_icon_物管"];
    for(int i = 0 ; i < 6 ; i ++){
       [_propertyDatas addObject:[TitleContentModel buildModel:titles[i] content:contents[i]]];
    }
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

-(void)goMessageDetailPage:(MessageModel *)msgModel{
    if(_delegate){
        [_delegate onGoMessageDetailPage:msgModel];
    }
}

-(void)goAddMemberPage{
    if(_delegate){
        [_delegate onGoAddMemberPage];
    }
}

-(void)goMemberPage{
    if(_delegate){
        [_delegate onGoMemberPage];
    }
}

-(void)goAuthUserPage{
    if(_delegate){
        [_delegate onGoAuthUserPage];
    }
}

-(void)openCheckInfoAlert{
    if(_delegate){
        [_delegate onOpenCheckInfoAlert];
    }
}

-(void)goAuthStatuPage{
    if(_delegate){
        [_delegate onGoAuthStatuPage];
    }
}

-(void)showAuthFailDialog{
    if(_delegate){
        [_delegate onShowAuthFailDialog];
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
                if(IS_NS_STRING_EMPTY(data.headUrl)){
                    data.headUrl = @"";
                }
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
           //存储长住信息
           LiveModel *model = [LiveModel mj_objectWithKeyValues:respondModel.data];
           [[AccountManager sharedAccountManager]saveLiveModel:model];
           //存储申请信息
           ApplyModel *applyModel = [[AccountManager sharedAccountManager]getApplyModel];
           applyModel.statu = APPLY_PASS;
           [[AccountManager sharedAccountManager]saveApplyModel:applyModel];
           [weakSelf.delegate onRequestSuccess:respondModel data:respondModel.data];
           [self getMainInfo:model.districtUid];
       }else{
           //存储申请状态信息
           ApplyModel *model = [[ApplyModel alloc]init];
           if([respondModel.status isEqualToString:STATU_LIVEINFO_NO_INFO]){
               model.statu = APPLY_DEFAULT;
           }else if([respondModel.status isEqualToString:STATU_LIVEINFO_HAS_REVIEW_INFO]){
               model = [ApplyModel mj_objectWithKeyValues:respondModel.data];
               if(model.applyState == Reject){
                   model.statu = APPLY_REJECT;
               }else{
                   model.statu = APPLYING;
               }
           }
           [[AccountManager sharedAccountManager]saveApplyModel:model];
           [weakSelf.delegate onRequestSuccess:respondModel data:respondModel.data];
       }
   } failure:^(int errorCode) {
       [weakSelf.delegate onRequestFail:[NSString stringWithFormat:@"%d",errorCode]];
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



-(void)requestMemberDatas{
    if(_delegate){
        WS(weakSelf)
        [_delegate onRequestBegin];
        LiveModel *model =  [[AccountManager sharedAccountManager]getLiveModel];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        dic[@"districtUid"] = model.districtUid;
        dic[@"homeLocator"] = model.homeLocator;
        [STNetUtil get:URL_GETFAMILY_MEMBER parameters:dic success:^(RespondModel *respondModel) {
            if([respondModel.status isEqualToString:STATU_SUCCESS]){
                weakSelf.memberDatas = [MemberModel mj_objectArrayWithKeyValuesArray:respondModel.data];
              
                //添加自己
                UserModel *userModel = [[AccountManager sharedAccountManager]getUserModel];
                MemberModel *memberModel = [MemberModel buildModel:MSG_MEMBER_ME homeLocator:model.homeLocator cretype:userModel.cretype creid:userModel.creid faceUrl:userModel.headUrl districtUid:model.districtUid userUid:model.userUid];
                memberModel.identify = MSG_MEMBER_ROOT;
                [weakSelf.memberDatas insertObject:memberModel atIndex:0];
                
                //添加add按钮
                MemberModel *model = [[MemberModel alloc]init];
                model.nickname = MSG_ADD;
                model.faceUrl = @"首页_icon_添加";
                [weakSelf.memberDatas insertObject:model atIndex:0];
                [weakSelf.delegate onRequestSuccess:respondModel data:weakSelf.memberDatas];
            }else{
                [weakSelf.delegate onRequestFail:respondModel.msg];
            }
        } failure:^(int errorCode) {
            [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
        }];
    }
}


-(void)requestMessageList{
    if(!_delegate){
        return;
    }

    [_delegate onRequestBegin];

    LiveModel *liveModel = [[AccountManager sharedAccountManager] getLiveModel];
    NSString *districtUid = liveModel.districtUid;
    NSString *homeLocator = liveModel.homeLocator;
    if(IS_NS_STRING_EMPTY(liveModel.districtUid) || IS_NS_STRING_EMPTY(liveModel.homeLocator)){
        ApplyModel *applyModel = [[AccountManager sharedAccountManager]getApplyModel];
        districtUid = applyModel.districtUid;
        homeLocator = applyModel.homeLocator;
    }
    if(IS_NS_STRING_EMPTY(districtUid) || IS_NS_STRING_EMPTY(homeLocator)){
        [_delegate onRequestFail:@""];
        return;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"messageType"] = @"1";
    dic[@"districtUid"] = districtUid;
    dic[@"homeLocator"] = homeLocator;
    dic[@"pageId"] = @(0);
    WS(weakSelf)
    [STNetUtil get:URL_GET_MESSAGELIST parameters:dic success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            id data = respondModel.data;
            id rows = [data objectForKey:@"rows"];
            weakSelf.msgDatas= [MessageModel mj_objectArrayWithKeyValuesArray:rows];
            [weakSelf.delegate onRequestSuccess:respondModel data:weakSelf.msgDatas];
            
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}


-(void)updateNavigationBarColor:(CGFloat )alpha{
    if(_delegate){
        [_delegate onUpdateNavigationBarColor:alpha];
    }
}

@end
