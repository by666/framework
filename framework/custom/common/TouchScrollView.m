//
//  TouchScrollView.m
//  gogo
//
//  Created by by.huang on 2017/10/26.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "TouchScrollView.h"
#import <MJRefresh/MJRefresh.h>

@implementation TouchScrollView{
    UIView *parentView;
}

-(instancetype)initWithParentView : (UIView *)view delegate:(id<TouchScrollViewDelegate>)delegate{
    if(self == [super init]){
        _touchScollViewDelegate = delegate;
        parentView = view;
        [self initSetting];
    }
    return self;
}

-(void)initSetting{
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
}

-(void)enableHeader{
    MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshNew)];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.mj_header = header;
}


-(void)refreshNew{
    if(_touchScollViewDelegate && [_touchScollViewDelegate respondsToSelector:@selector(refreshNew)]){
        [self.mj_header endRefreshing];
        [_touchScollViewDelegate refreshNew];
    }
}

-(void)enableFooter{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(uploadMore)];
    self.mj_footer = footer;
}

-(void)uploadMore{
    if(_touchScollViewDelegate && [_touchScollViewDelegate respondsToSelector:@selector(uploadMore)]){
        [self.mj_footer endRefreshing];
        [_touchScollViewDelegate uploadMore];
    }
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [parentView touchesBegan:touches withEvent:event];
}


@end
