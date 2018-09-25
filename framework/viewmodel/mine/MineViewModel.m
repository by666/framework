//
//  MineViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/15.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MineViewModel.h"
#import "STNetUtil.h"
#import "AccountManager.h"

@implementation MineViewModel


-(instancetype)init{
    if(self == [super init]){
        _titleArray = @[MSG_MEMBER_TITLE,MSG_VISITORHOME_TITLE,MSG_VISITORHISTORY_TITLE,MSG_REPORTFIX_TITLE,MSG_DEVICESHARE_TITLE,MSG_HABITANT_TITLE,MSG_ABOUT_TITLE,MSG_SETTING_LOGOUT];
        _imageArray = @[@"我_icon_家庭成员",@"我_icon_访客登记",@"我_icon_访客通行记录",@"我_icon_室内保修",@"我_icon_设备共享",@"我_icon_住户管理",@"我_icon_关于我们",@""];
    }
    return self;
}

-(void)goProfilePage{
    if(_delegate){[_delegate onGoProfilePage];}
}

-(void)goMemberPage{
    if(_delegate){[_delegate onGoMemberPage];}
}

-(void)goVictorPage{
    if(_delegate){[_delegate onGoVictorPage];}
}

-(void)goVictorHistoryPage{
    if(_delegate){[_delegate onGoVictorHistoryPage];}
}

-(void)goCarPage{
    if(_delegate){[_delegate onGoCarPage];}
}

-(void)goCarHistoryPage{
    if(_delegate){[_delegate onGoCarHistoryPage];}
}

-(void)goMessageSettingPage{
    if(_delegate){[_delegate onGoMessageSettingPage];}
}

-(void)goAccountManagePage{
    if(_delegate){[_delegate onGoAccountManagePage];}
}

-(void)goSettingPage{
    if(_delegate){[_delegate onGoSettingPage];}
}

-(void)goReportFixPage{
    if(_delegate){[_delegate onGoReportFixPage];}
}

-(void)goDeviceSharePage{
    if(_delegate){[_delegate onGoDeviceSharePage];}
}

-(void)goAboutPage{
    if(_delegate){[_delegate onGoAboutPage];}
}

-(void)doLogout{
    if(_delegate){
        [_delegate onRequestBegin];
        
        WS(weakSelf)
        [STNetUtil post:URL_LOGOUT content:@"" success:^(RespondModel *respondModel) {
            if([respondModel.status isEqualToString:STATU_SUCCESS]){
                [[AccountManager sharedAccountManager] clearUserModel];
                [[AccountManager sharedAccountManager] clearLiveModel];
                [[AccountManager sharedAccountManager] clearMainModel];
                [[AccountManager sharedAccountManager] clearApplyModel];
                [[AccountManager sharedAccountManager] clearWYUserModel];
                [weakSelf.delegate onRequestSuccess:respondModel data:nil];
            }else{
                [weakSelf.delegate onRequestFail:respondModel.msg];
            }
        } failure:^(int errorCode) {
            [weakSelf.delegate onRequestFail:[NSString stringWithFormat:@"%d",errorCode]];
        }];
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

-(void)goBack{
    if(_delegate){[_delegate onGoBack];}
}



@end
