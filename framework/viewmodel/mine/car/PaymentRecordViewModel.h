//
//  PaymentRecordViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/21.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol PaymentRecordViewDelegate


@end

@interface PaymentRecordViewModel : NSObject

@property(weak, nonatomic)id<PaymentRecordViewDelegate> delegate;



@end
