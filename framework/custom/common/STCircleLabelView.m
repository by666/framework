//
//  STCircleLabelView.m
//  framework
//
//  Created by 黄成实 on 2018/6/7.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "STCircleLabelView.h"


@interface STCircleLabelView()<UIScrollViewDelegate>

@property(strong, nonatomic)UIScrollView *scrollView;
@property(strong, nonatomic)NSMutableArray *mDatas;
@property(assign, nonatomic)NSInteger position;

@end
@implementation STCircleLabelView

-(instancetype)initWithTitles:(NSMutableArray *)datas{
    if(self == [super init]){
        if(IS_NS_COLLECTION_EMPTY(datas)){
            return self;
        }
        _mDatas = [[NSMutableArray alloc]init];
        NSString *lastStr = [datas objectAtIndex:([datas count] - 1)];
        [_mDatas addObject:lastStr];
        [_mDatas addObjectsFromArray:datas];
        _position = 1;
        [self initView];
    }
    return self;
}

-(void)initView{
    self.frame  = CGRectMake(STWidth(95), 0, STWidth(225), STHeight(32));
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, STWidth(225), STHeight(32))];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(STWidth(225), STHeight(32) * ([_mDatas count] + 2));
    [self addSubview:_scrollView];
    
    
    
    for(int i = 0 ; i < [_mDatas count] ; i ++){
        UILabel *msgLabel = [[UILabel alloc]initWithFont:STFont(12) text:[_mDatas objectAtIndex:i] textAlignment:NSTextAlignmentLeft textColor:c16 backgroundColor:nil multiLine:NO];
        msgLabel.frame = CGRectMake(0, i * STHeight(32), STWidth(225), STHeight(32));
        msgLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        msgLabel.tag = i;
        [_scrollView addSubview:msgLabel];
    }

    if([_mDatas count] == 2){
        return;
    }
    [_scrollView setContentOffset:CGPointMake(0,_position * STHeight(32)) animated:YES];
    [self startScroll];
    
}

-(void)startScroll{
    _position ++;
    WS(weakSelf)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.scrollView setContentOffset:CGPointMake(0,weakSelf.position * STHeight(32)) animated:YES];
            if(weakSelf.position + 1  == [weakSelf.mDatas count]){
                weakSelf.position = 0;
                [self test];
                return;
            }
            [self startScroll];
        });
    });
}


-(void)test{
    WS(weakSelf)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.scrollView setContentOffset:CGPointMake(0,weakSelf.position * STHeight(32)) animated:NO];
            [weakSelf startScroll];
        });
    });
}

@end
