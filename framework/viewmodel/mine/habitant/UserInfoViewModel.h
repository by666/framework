//
//  UserInfoViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/8/14.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HabitantModel.h"


@protocol UserInfoViewDelegate<BaseRequestDelegate>


@end

@interface UserInfoViewModel : NSObject

@property(strong, nonatomic)HabitantModel *model;
@property(strong, nonatomic)NSMutableArray *datas;
@property(weak, nonatomic)id<UserInfoViewDelegate> delegate;

-(instancetype)initWithModel:(HabitantModel *)model;
-(void)updateHabitant;

@end
