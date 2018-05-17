//
//  AddMemberViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/17.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MemberModel.h"

@protocol AddMemberViewDelegate

-(void)onAddMemberModel:(Boolean)success model:(MemberModel *)model;

@end

@interface AddMemberViewModel : NSObject

@property(weak, nonatomic)id<AddMemberViewDelegate> delegate;
@property(strong, nonatomic)MemberModel *model;

-(void)addMemberModel;


@end
