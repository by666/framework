//
//  SystemMsgViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/6/1.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SystemMsgModel.h"

@protocol SystemMsgViewDelegate

-(void)onRequestCallback:(Boolean)success datas:(NSMutableArray *)datas;
-(void)onBackLastPage;

@end

@interface SystemMsgViewModel : NSObject

@property(weak, nonatomic)id<SystemMsgViewDelegate> delegate;
@property(strong, nonatomic)NSMutableArray *datas;

-(void)requestMoreDatas;
-(void)requestNewDatas;
-(CGFloat)countDynamicHeight;
-(void)backLastPage;

@end
