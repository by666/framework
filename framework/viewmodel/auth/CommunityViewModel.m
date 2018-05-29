//
//  CommunityViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/25.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "CommunityViewModel.h"

@implementation CommunityViewModel

-(instancetype)init{
    if(self == [super init]){
        _datas = [[NSMutableArray alloc]init];
    }
    return self;
}

-(void)searchCommunity:(NSString *)keyStr{
    if(_delegate){
        if(IS_NS_STRING_EMPTY(keyStr)){
            [_delegate onSearchCommunity:NO datas:nil errorMsg:MSG_COMMUNITY_KEYISEMPTY];
            return;
        }
        _datas = [CommunityModel getTestDatas];
        [_delegate onSearchCommunity:YES datas:_datas errorMsg:MSG_SUCCESS];
    }
}

-(void)backLastPage{
    if(_delegate){
        [_delegate onBackLastPage];
    }
}
@end
