//
//  VisitorHistoryViewModel.h
//  framework
//
//  Created by by.huang on 2018/5/23.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VisitorHistoryModel.h"
#import "VisitorModel.h"

@protocol VisitorHistoryViewDelegate<BaseRequestDelegate>

-(void)onGoVisitorPage:(VisitorModel *)model;

@end

@interface VisitorHistoryViewModel : NSObject

@property(weak, nonatomic)id<VisitorHistoryViewDelegate> delegate;
@property(strong, nonatomic)NSMutableArray *datas;

-(void)getVisitoryHistoryDatas;
-(void)goVisitorPage:(VisitorModel *)model;


@end
