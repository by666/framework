//
//  AddMemberViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/17.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MemberModel.h"

@protocol AddMemberViewDelegate<BaseRequestDelegate>

-(void)onDoTakePhoto;
-(void)onGoLastPage;
-(void)onCheckUpdate:(MemberModel *)model changePhoto:(Boolean)changePhoto;

@end

@interface AddMemberViewModel : NSObject

@property(weak, nonatomic)id<AddMemberViewDelegate> delegate;
@property(strong, nonatomic)MemberModel *model;

-(instancetype)initWithData:(MemberModel *)model;
-(void)addMemberModel;
-(void)deleteMemberModel:(MemberModel *)model;
-(void)checkUpdateMemberModel:(MemberModel *)model changePhoto:(Boolean)changePhoto;
-(void)updateMemberModel:(MemberModel *)model changePhoto:(Boolean)changePhoto;
-(void)goLastPage;
-(void)doTakePhoto;

@end
