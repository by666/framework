//
//  MainViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/9.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MainViewDelegate

-(void)onGoMinePage;

@end

@interface MainViewModel : NSObject

@property(weak, nonatomic)id <MainViewDelegate>delegate;

-(void)goMinePage;

@end
