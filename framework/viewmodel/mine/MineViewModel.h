//
//  MineViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/15.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol MineViewDelegate<BaseRequestDelegate>

-(void)onGoProfilePage;
-(void)onGoMemberPage;
-(void)onGoVictorPage;
-(void)onGoVictorHistoryPage;
-(void)onGoCarPage;
-(void)onGoCarHistoryPage;
-(void)onGoMessageSettingPage;
-(void)onGoAccountManagePage;
-(void)onGoSettingPage;
-(void)onGoReportFixPage;
-(void)onGoDeviceSharePage;
-(void)onGoAboutPage;
-(void)onDoLogout;
-(void)onOpenCheckInfoAlert;
-(void)onGoAuthStatuPage;
-(void)onShowAuthFailDialog;
-(void)onGoBack;

@end

@interface MineViewModel : NSObject
@property(weak, nonatomic) id<MineViewDelegate> delegate;
@property(strong, nonatomic) NSArray *titleArray;
@property(strong, nonatomic) NSArray *imageArray;


//跳转到资料修改页
-(void)goProfilePage;

//跳转到家庭成员页
-(void)goMemberPage;

//跳转到访客登记页
-(void)goVictorPage;

//跳转到访客登录历史页
-(void)goVictorHistoryPage;

//跳转到我的车辆页
-(void)goCarPage;

//跳转到车辆历史记录
-(void)goCarHistoryPage;

//跳转到消息设置页面
-(void)goMessageSettingPage;

//跳转到账号管理页面
-(void)goAccountManagePage;

//跳转到设置页面
-(void)goSettingPage;

//跳转到室内报修页面
-(void)goReportFixPage;

//跳转到设备共享页面
-(void)goDeviceSharePage;

//跳转到关于页面
-(void)goAboutPage;

//退出登录
-(void)doLogout;

//未审核弹框
-(void)openCheckInfoAlert;

//审核中弹框
-(void)goAuthStatuPage;

//审核失败弹框
-(void)showAuthFailDialog;


-(void)goBack;



@end
