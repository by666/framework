//
//  HabitantViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/15.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HabitantModel.h"
#import "BaseViewController.h"

@protocol HabitantViewDelegate<BaseRequestDelegate>


@end


@interface HabitantViewModel : NSObject

@property(weak, nonatomic)id delegate;
@property(strong, nonatomic)NSMutableArray *datas;
@property(strong, nonatomic)BaseViewController *controller;

-(instancetype)initWithController:(BaseViewController *)controller;
-(void)requestDatas;
-(void)deleteHabitant:(HabitantModel *)model;
-(void)updateHabitant:(HabitantModel *)model;

@end
