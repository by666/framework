//
//  OnePaymentViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/22.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CarHistoryModel.h"
@protocol OnePaymentViewDelegate

-(void)onPayResult:(Boolean)success;

@end

@interface OnePaymentViewModel : NSObject
@property(strong, nonatomic)CarHistoryModel *model;
@property(weak, nonatomic)id<OnePaymentViewDelegate> delegate;

-(void)doPay;

@end
