//
//  PassHistoryViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/6/27.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PassHistoryModel.h"

@protocol PassHistoryViewDelegate<BaseRequestDelegate>

-(void)onGoPassPage:(PassHistoryModel *)model;

@end

@interface PassHistoryViewModel : NSObject

@property(weak, nonatomic)id<PassHistoryViewDelegate> delegate;
@property(strong, nonatomic)NSMutableArray *datas;

-(instancetype)init;
-(void)requestDatas;
-(void)goPassPage:(PassHistoryModel *)model;

@end
