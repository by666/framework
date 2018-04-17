//
//  TestViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/4/17.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestViewModelProtocol.h"
#import "TestModel.h"

@interface TestViewModel : NSObject

@property (weak, nonatomic)id<TestViewModelProtocol> viewModelDelegate;

-(instancetype)initWithDelegate:(id<TestViewModelProtocol>)delegate;

-(void)requestModel:(void (^)(id))result;


@end
