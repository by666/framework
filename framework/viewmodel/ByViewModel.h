//
//  ByViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/4/18.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ByModel.h"


@protocol ByViewModelProtocol

-(void)updateView:(ByModel *)model;

@end

@interface ByViewModel : NSObject

@property (weak, nonatomic) id <ByViewModelProtocol> delegate;

//初始化
-(instancetype)init;

//数据请求
-(ByModel *)requestData;

//数据变更
-(void)changeData : (id<ByViewModelProtocol>) delegate;

@end
