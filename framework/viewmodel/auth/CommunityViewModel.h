//
//  CommunityViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/25.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommunityModel.h"

@protocol CommunityViewDelegate<BaseRequestDelegate>

-(void)onSearchCommunity:(Boolean)success datas:(NSMutableArray *)datas errorMsg:(NSString *)errorMsg;
-(void)onBackLastPage;

@end

@interface CommunityViewModel : NSObject

@property(weak, nonatomic)id<CommunityViewDelegate> delegate;
@property(strong, nonatomic)NSMutableArray *datas;

-(void)searchCommunity:(NSString *)keyStr;
-(void)backLastPage;
-(void)getCommunityPosition:(CGFloat)longtitude latitude:(CGFloat)latitude;


@end
