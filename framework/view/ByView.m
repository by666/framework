//
//  ByView.m
//  framework
//
//  Created by 黄成实 on 2018/4/18.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "ByView.h"
#import "STDataBaseUtil.h"
#import "TouchScrollView.h"
@interface ByView()<TouchScrollViewDelegate>

@property (strong, nonatomic)ByViewModel *mByViewModel;
@property (strong, nonatomic)ByModel *mByModel;
@property (strong, nonatomic)TouchScrollView *scrollView;

@end

@implementation ByView

-(instancetype)initWithViewModel:(ByViewModel *)byViewModel{
    if(self == [super init]){
        _mByViewModel = byViewModel;
        [self initView];
    }
    return self;
}


-(void)initView{
    self.frame = CGRectMake(0, StatuBarHeight, ScreenWidth, ScreenHeight - StatuBarHeight);
    self.backgroundColor = c02;

    _mByModel = [_mByViewModel requestData];
    
    
    _scrollView = [[TouchScrollView alloc]initWithParentView:self delegate:self];
    _scrollView.frame = CGRectMake(0, StatuBarHeight, ScreenWidth, ScreenHeight - StatuBarHeight);
    _scrollView.backgroundColor = [UIColor redColor];
    _scrollView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight *2);
    [self addSubview:_scrollView];
}

-(void)uploadMore{
    
}

-(void)refreshNew{
    
}

@end
