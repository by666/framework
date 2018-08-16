//
//  MainViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/9.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainModel.h"
#import "MessageModel.h"

@protocol MainViewDelegate<BaseRequestDelegate>
-(void)onGoOpendoorPage;
-(void)onGoCarPage;
-(void)onGoVisitorPage;
-(void)onGoVisitorHistoryPage;
-(void)onGoReportFixPage;
-(void)onGoDeviceSharePage;
-(void)onDoCallProperty;
-(void)onGoMessagePage;
-(void)onGoMinePage;
-(void)onGoMessageDetailPage:(MessageModel *)msgModel;
-(void)onGoAddMemberPage;
-(void)onGoMemberPage;
-(void)onGoAuthUserPage;

-(void)onOpenCheckInfoAlert;
-(void)onGoAuthStatuPage;
-(void)onShowAuthFailDialog;
-(void)onUpdateNavigationBarColor:(CGFloat )alpha;
@end

@interface MainViewModel : NSObject

@property(weak, nonatomic)id <MainViewDelegate>delegate;
@property(strong, nonatomic)MainModel *model;
@property(strong, nonatomic)NSMutableArray *memberDatas;
@property(strong, nonatomic)NSMutableArray *msgDatas;
@property(strong, nonatomic)NSMutableArray *propertyDatas;


//跳转
-(void)goOpendoorPage;

-(void)goCarPage;

-(void)goVisitorPage;

-(void)goVisitorHistoryPage;

-(void)goReportFixPage;

-(void)goDeviceSharePage;

-(void)goMessagePage;

-(void)goMinePage;

-(void)doCallProperty;

-(void)goMessageDetailPage:(MessageModel *)msgModel;

-(void)goAddMemberPage;

-(void)goMemberPage;

-(void)goAuthUserPage;



//弹框
-(void)openCheckInfoAlert;

-(void)goAuthStatuPage;

-(void)showAuthFailDialog;



//网络请求
-(void)getUserInfo;

-(void)getLiveInfo;

-(void)requestMemberDatas;

-(void)requestMessageList;

//导航条颜色
-(void)updateNavigationBarColor:(CGFloat )alpha;


@end
