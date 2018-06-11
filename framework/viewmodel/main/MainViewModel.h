//
//  MainViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/9.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MainViewDelegate
-(void)onGoOpendoorPage;
-(void)onGoCarPage;
-(void)onGoVisitorPage;
-(void)onGoVisitorHistoryPage;
-(void)onGoReportFixPage;
-(void)onGoDeviceSharePage;
-(void)onDoCallProperty;
-(void)onGoMessagePage;
-(void)onGoMinePage;

@end

@interface MainViewModel : NSObject

@property(weak, nonatomic)id <MainViewDelegate>delegate;


-(void)goOpendoorPage;

-(void)goCarPage;

-(void)goVisitorPage;

-(void)goVisitorHistoryPage;

-(void)goReportFixPage;

-(void)goDeviceSharePage;

-(void)doCallProperty;

-(void)goMessagePage;

-(void)goMinePage;

@end
