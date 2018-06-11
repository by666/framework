//
//  FixHistoryViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/6/8.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FixModel.h"
@protocol FixHistoryViewDelegate

-(void)onRequestDatasCallback:(Boolean)success datas:(NSMutableArray *)datas;

@end

@interface FixHistoryViewModel : NSObject

@property(strong, nonatomic)NSMutableArray *datas;
@property(weak, nonatomic)id <FixHistoryViewDelegate> delegate;

-(instancetype)init;

-(void)requestNew;
-(void)requestMore;

@end
