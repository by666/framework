//
//  VisitorHomeViewModel.h
//  framework
//
//  Created by by.huang on 2018/5/23.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol VisitorHomeViewDelegate

-(void)onGoVisitorPage:(VisitorType)type;

@end

@interface VisitorHomeViewModel : NSObject
@property(weak, nonatomic)id<VisitorHomeViewDelegate> delegate;

-(void)goVisitorPeople;
-(void)goVisitorCar;

@end
