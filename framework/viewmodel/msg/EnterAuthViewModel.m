//
//  EnterAuthViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/30.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "EnterAuthViewModel.h"
#import "TitleContentModel.h"

@implementation EnterAuthViewModel

-(instancetype)initWithData:(MessageModel *)model{
    if(self == [super init]){
        _model = model;
        _datas = [[NSMutableArray alloc]init];
        [self buildDatas:model];
    }
    return self;
}

-(void)buildDatas:(MessageModel *)model{
    if(model.messageType == CarEnter){
        NSArray *array = [model.content componentsSeparatedByString:@"|"];
        [_datas addObject:[TitleContentModel buildModel:MSG_ENTERAUTH_VISITOR content:[array objectAtIndex:0]]];
        [_datas addObject:[TitleContentModel buildModel:MSG_ENTERAUTH_CARNUM content:[array objectAtIndex:1]]];
    }else{
        [_datas addObject:[TitleContentModel buildModel:MSG_ENTERAUTH_VISITOR content:model.content]];
    }
    [_datas addObject:[TitleContentModel buildModel:MSG_ENTERAUTH_TIME content:model.timestamp]];
    [_datas addObject:[TitleContentModel buildModel:MSG_ENTERAUTH_POSITION content:@"小区大门门禁处"]];

}

-(void)doAgree{
    if(_delegate){
        [_delegate onDoAgree:_model];
    }
}


-(void)doReject{
    if(_delegate){
        [_delegate onDoReject:_model];
    }
}

@end
