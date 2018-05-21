//
//  PaymentViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/21.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CarModel.h"
#import "TitleContentModel.h"

@protocol PaymentViewDelegate

-(void)onWechatPay:(Boolean)success;

@end

@interface PaymentViewModel : NSObject

@property(weak, nonatomic)id<PaymentViewDelegate> delegate;
@property(strong, nonatomic)CarModel *data;
@property(strong, nonatomic)NSMutableArray *titleDatas;

-(instancetype)initWithModel:(CarModel *)data;

-(void)doWechatPay;

@end
