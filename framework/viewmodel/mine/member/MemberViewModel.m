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
        
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *imageFilePath = [path stringByAppendingPathComponent:@"head.jpg"];
        
        _datas = [[NSMutableArray alloc]init];
        [_datas addObject:[self buildModel:@"张三丰" identify:@"管理员" idNum:@"362402199104190515" avatarUrl:imageFilePath uid:@"1"]];
        [_datas addObject:[self buildModel:@"张翠山" identify:@"" idNum:@"362402199104190515" avatarUrl:imageFilePath uid:@"2"]];
        [_datas addObject:[self buildModel:@"张无忌" identify:@"" idNum:@"362402199104190515" avatarUrl:imageFilePath uid:@"3"]];
        [_datas addObject:[self buildModel:@"张小泉" identify:@"" idNum:@"362402199104190515" avatarUrl:imageFilePath uid:@"4"]];

    }
    return self;
}


-(MemberModel *)buildModel:(NSString *)name identify:(NSString *)identify idNum:(NSString *)idNum avatarUrl:(NSString *)avatarUrl uid:(NSString *)uid{
    MemberModel *model = [[MemberModel alloc]init];
    model.name = name;
    model.identify = identify;
    model.idNum = idNum;
    model.avatarUrl = avatarUrl;
    model.uid = uid;
    return model;
}


-(void)getMemberModels{
    if(_delegate){
        [_delegate onGetMemberModels:_datas];
    }
}


-(void)goAddMemberView{
    if(_delegate){
        [_delegate onGoAddMemberView];
    }
}

-(void)goEditMemberView:(MemberModel *)model{
    if(_delegate){
        [_delegate onGoEditMemberView:model];
    }
}


-(void)deleteMember:(MemberModel *)model{
    if(_delegate){
        if(!IS_NS_COLLECTION_EMPTY(_datas)){
            for(int i = 0 ; i < [_datas count] ; i++){
                MemberModel *tempModel = [_datas objectAtIndex:i];
                if([tempModel.name isEqualToString:model.name]){
                    [_datas removeObjectAtIndex:i];
                    [_delegate onDeleteMember:YES model:model row:i];
                    break;
                }
            }
        }
    }
}

-(void)showWarnPrompt:(MemberModel *)model{
    if(_delegate){
        [_delegate onShowWarnPrompt:model];
    }
}

@end
