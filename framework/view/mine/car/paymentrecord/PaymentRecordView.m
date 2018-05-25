//
//  PaymentRecordView.m
//  framework
//
//  Created by 黄成实 on 2018/5/21.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "PaymentRecordView.h"
#import "PaymentRecordViewModel.h"
#import "MainPage.h"
#import "STTabBarView.h"
#import "VisitorPaymentView.h"
#import "MonthPaymentView.h"

@interface PaymentRecordView()<UIScrollViewDelegate>

@property(strong, nonatomic)PaymentRecordViewModel *mViewModel;
@property(strong, nonatomic)STTabBarView *tabBarView;
@property(strong, nonatomic)VisitorPaymentView *visitorPaymentView;
@property(strong, nonatomic)MonthPaymentView *monthPaymentView;
@property(strong, nonatomic)UIScrollView *scrollView;
@property(assign, nonatomic)NSInteger mIndex;

@end

@implementation PaymentRecordView

-(instancetype)initWithViewModel:(PaymentRecordViewModel *)viewModel index:(NSInteger)index{
    if(self == [super init]){
        _mViewModel = viewModel;
        _mIndex = index;
        [self initView];
    }
    return self;
}

-(void)initView{
    NSArray *titles = @[MSG_PAYMENTRECORD_VISITOR_TAB,MSG_PAYMENTRECORD_MONTH_TAB];
    _tabBarView = [[STTabBarView alloc]initWithTitles:titles];
    [_tabBarView setData:c12 SelectColor:c19 Font:[UIFont systemFontOfSize:STFont(16)]];
    [_tabBarView setLineHeight:1];
    [self addSubview:_tabBarView];
    
    WS(weakSelf)
    [_tabBarView getViewIndex:^(NSString *title, NSInteger index) {
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.scrollView.contentOffset = CGPointMake(index * ScreenWidth, 0);
        }];
    }];
  
    [_tabBarView setIndexBlock:^(NSString *title, NSInteger index) {
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.scrollView.contentOffset = CGPointMake(index * ScreenWidth, 0);
        }];
    }];
    
    [_tabBarView setViewIndex:_mIndex];
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, STHeight(44), ScreenWidth, ContentHeight - STHeight(44))];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake([titles count]*ScreenWidth, 0);
    [self addSubview:_scrollView];
    
    _visitorPaymentView = [[VisitorPaymentView alloc]initWithViewModel:_mViewModel];
    _visitorPaymentView.frame = CGRectMake(0, 0, ScreenWidth, ContentHeight - STHeight(44));
    
    _monthPaymentView = [[MonthPaymentView alloc]initWithViewModel:_mViewModel];
    _monthPaymentView.frame = CGRectMake(ScreenWidth, 0, ScreenWidth, ContentHeight - STHeight(44));
    
    [_scrollView addSubview:_visitorPaymentView];
    [_scrollView addSubview:_monthPaymentView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / ScreenWidth;
    [_tabBarView setViewIndex:index];
}

@end
