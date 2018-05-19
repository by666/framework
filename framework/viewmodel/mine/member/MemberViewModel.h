//
//  MemberViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/17.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MemberModel.h"

@protocol MemberViewDelegate

-(void)onGoAddMemberView;
-(void)onGoEditMemberView:(MemberModel *)model;
-(void)onDeleteMember:(Boolean)success model:(MemberModel *)model;
-(void)onGetMemberModels:(NSMutableArray *)datas;

@end

@interface MemberViewModel : NSObject

@property(weak, nonatomic)id<MemberViewDelegate> delegate;
@property(strong, nonatomic)NSMutableArray *datas;

-(void)getMemberModels;
-(void)goAddMemberView;
-(void)goEditMemberView:(MemberModel *)model;
-(void)deleteMember:(MemberModel *)model;

@end
