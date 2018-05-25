
//
//  CommunityView.m
//  framework
//
//  Created by 黄成实 on 2018/5/25.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "CommunityView.h"

@interface CommunityView()

@property(strong, nonatomic)CommunityViewModel *mViewModel;
@end

@implementation CommunityView

-(instancetype)initWithViewModel:(CommunityViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    
}

@end
