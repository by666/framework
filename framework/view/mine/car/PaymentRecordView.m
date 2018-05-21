//
//  PaymentRecordView.m
//  framework
//
//  Created by 黄成实 on 2018/5/21.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "PaymentRecordView.h"
#import "PaymentRecordViewModel.h"
#import "STSegmentView.h"

@interface PaymentRecordView()

@property(strong, nonatomic)PaymentRecordViewModel *mViewModel;

@end

@implementation PaymentRecordView

-(instancetype)initWithViewModel:(PaymentRecordViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    STSegmentView *segmentView = [[STSegmentView alloc]initWithTitles:@[MSG_PAYMENTRECORD_VISITOR_TAB,MSG_PAYMENTRECORD_MONTH_TAB]];
    [self addSubview:segmentView];
}


@end
