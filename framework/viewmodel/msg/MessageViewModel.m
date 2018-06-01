//
//  MessageViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/29.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MessageViewModel.h"

@implementation MessageViewModel

-(instancetype)init{
    if(self == [super init]){
        _datas = [[NSMutableArray alloc]init];
        _datas = [MessageModel getTestDatas];
    }
    return self;
}

-(void)goSystemPage{
    if(_delegate){
        [_delegate onGoSystemPage];
    }
}

-(void)goPropertyPage{
    if(_delegate){
        [_delegate onGoPropertyPage];
    }
}

-(void)goMessageDetailPage:(MessageModel *)model{
    if(_delegate){
        [_delegate onGoMessageDetailPage:model];
    }
}


-(void)doAgree:(MessageModel *)model{
    if(IS_NS_COLLECTION_EMPTY(_datas)){
        return;
    }
    //之后要换成mid
    for(MessageModel *data in _datas){
        if([model.content isEqualToString:data.content]){
            data.messageStatu = Granted;
        }
    }
    if(_delegate){
        [_delegate onDataChange];
    }
}


-(void)doReject:(MessageModel *)model{
    if(IS_NS_COLLECTION_EMPTY(_datas)){
        return;
    }
    //之后要换成mid
    for(MessageModel *data in _datas){
        if([model.content isEqualToString:data.content]){
            data.messageStatu = Reject;
        }
    }
    if(_delegate){
        [_delegate onDataChange];
    }
}
@end
