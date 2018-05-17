//
//  MemberViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/17.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MemberViewModel.h"

@implementation MemberViewModel


-(instancetype)init{
    if(self == [super init]){
        _datas = [[NSMutableArray alloc]init];
        [_datas addObject:[self buildModel:@"张三丰" identify:@"管理员"]];
        [_datas addObject:[self buildModel:@"张翠山" identify:@""]];
        [_datas addObject:[self buildModel:@"张无忌" identify:@""]];
        [_datas addObject:[self buildModel:@"张小泉" identify:@""]];

    }
    return self;
}


-(MemberModel *)buildModel:(NSString *)name identify:(NSString *)identify{
    MemberModel *model = [[MemberModel alloc]init];
    model.name = name;
    model.identify = identify;
    return model;
}


-(void)getMemberModels{
    if(_delegate){
        [_delegate onGetMemberModels:_datas];
    }
}


-(void)goEditMemberView{
    if(_delegate){
        [_delegate onGoAddMemberView];
    }
}


-(void)deleteMember:(MemberModel *)model{
    if(_delegate){
        [_delegate onDeleteMember:YES model:model];
    }
}

@end
