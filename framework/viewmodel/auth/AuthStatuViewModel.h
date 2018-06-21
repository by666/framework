//
//  AuthStatuViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/24.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AuthStatuViewDelegate<BaseRequestDelegate>


@end

@interface AuthStatuViewModel : NSObject


@property(weak, nonatomic)id<AuthStatuViewDelegate> delegate;


-(void)doHurryRequest;

@end
