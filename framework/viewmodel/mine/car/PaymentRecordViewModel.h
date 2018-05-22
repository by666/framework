//
//  PaymentRecordViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/21.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol PaymentRecordViewDelegate

-(void)onGetMonthPaymentDatas:(Boolean)success;
-(void)onGetVisitorPaymentDatas:(Boolean)success;

@end

@interface PaymentRecordViewModel : NSObject

@property(weak, nonatomic)id<PaymentRecordViewDelegate> delegate;
@property(strong, nonatomic)NSMutableArray *monthPaymentDatas;
@property(strong, nonatomic)NSMutableArray *visitorPaymentDatas;

-(void)getMonthPaymentDatas;
-(void)getVisitorPaymentDatas;

@end
