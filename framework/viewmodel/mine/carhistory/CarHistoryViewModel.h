//
//  CarHistoryViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/22.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CarHistoryModel.h"

@protocol CarHistoryViewDelegate

-(void)onGetCarHistoryDatas:(Boolean)success;
-(void)onGoOnePaymentPage:(CarHistoryModel *)model;
@end

@interface CarHistoryViewModel : NSObject

@property(strong,nonatomic)NSMutableArray *datas;
@property(weak, nonatomic)id<CarHistoryViewDelegate> delegate;

-(void)getCarHistoryDatas;
-(void)goOnePaymentPage:(CarHistoryModel *)model;

@end
