//
//  MineViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/15.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MineViewModel.h"

@implementation MineViewModel


-(instancetype)init{
    if(self == [super init]){
        _titleArray = @[MSG_MEMBER_TITLE,MSG_VISITORHOME_TITLE,MSG_VISITORHISTORY_TITLE,MSG_CAR_TITLE,MSG_CARHISTORY_TITLE,MSG_MESSAGESETTING_TITLE,MSG_HABITANT_TITLE];
        _imageArray = @[@"ic_member",@"ic_visitor",@"ic_visitor_history",@"ic_car",@"ic_car_history",@"ic_message_setting",@"ic_habitant"];
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

-(void)goBack{
    if(_delegate){[_delegate onGoBack];}
}



@end
