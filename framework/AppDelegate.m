//
//  AppDelegate.m
//  framework
//
//  Created by 黄成实 on 2018/4/17.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "AppDelegate.h"
#import "STDataBaseUtil.h"
#import "STRuntimeUtil.h"
#import "LoginPage.h"
#import <iflyMSC/IFlyFaceSDK.h>
#import "UserModel.h"
#import "STUserDefaults.h"
#import <WXApi.h>
#import "STObserverManager.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "STUpdateUtil.h"
#import "MainPage.h"
#import "ByViewController.h"
#import "NextLoginPage.h"
#import "AccountManager.h"
#import "MinePage.h"
#import "AuthUserPage.h"
#import "CommunityPage.h"
#import "MessagePage.h"

@interface AppDelegate ()<JPUSHRegisterDelegate,WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    id controller;
    if([[AccountManager sharedAccountManager]isLogin]){
        controller = [[MainPage alloc]init];
    }else{
        controller = [[LoginPage alloc]init];
    }
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:controller];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];

    [[STObserverManager sharedSTObserverManager]setup];
    [self initIFly];
    [self initDB];
    [self initJPush:launchOptions];
    [self initWechat];
    [self initNet];
    [STUpdateUtil checkUpdate:^(NSString *appname, NSString *url, double version) {
//        [self showUpdateAlert:url version:version];
    }];
    NSString *test =  [NSString stringWithFormat:@"%ld",(1UL << 0)];
    NSString *test1 = [NSString stringWithFormat:@"%ld",(1UL << 1)];
    NSString *test2 = [NSString stringWithFormat:@"%ld",(1UL << 2)];
    NSString *test3 = [NSString stringWithFormat:@"%ld",(1UL << 3)];
    NSString *test4 = [NSString stringWithFormat:@"%ld",(1UL << 4)];
    NSString *test5 = [NSString stringWithFormat:@"%ld",(1UL << 5)];
    [STLog print:test];
    [STLog print:test1];
    [STLog print:test2];
    [STLog print:test3];
    [STLog print:test4];
    [STLog print:test5];
    

    return YES;
}

-(void)initIFly{
    //设置log等级，此处log为默认在app沙盒目录下的msc.log文件
    [IFlySetting setLogFile:LVL_ALL];
    
    //输出在console的log开关
    [IFlySetting showLogcat:YES];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths objectAtIndex:0];
    //设置msc.log的保存路径
    [IFlySetting setLogFilePath:cachePath];
    
    //创建语音配置,appid必须要传入，仅执行一次则可
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@,",IFLY_FACE_APPID];
    
    //所有服务启动前，需要确保执行createUtility
    [IFlySpeechUtility createUtility:initString];
    
}

-(void)initDB{
    [[STDataBaseUtil sharedSTDataBaseUtil]createTable:@"sthl" model:[UserModel class]];
    [[AccountManager sharedAccountManager]getUserModel];
}

-(void)initJPush:(NSDictionary *)launchOptions {

    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    [JPUSHService setupWithOption:launchOptions appKey:JPUSH_APPKEY
                          channel:@"st"
                 apsForProduction:NO
            advertisingIdentifier:nil];
    
    //2.1.9版本新增获取registration id block接口。
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            NSLog(@"registrationID获取成功：%@",registrationID);
            
        }
        else{
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
}

-(void)initWechat{
    BOOL result = [WXApi registerApp:WECHAT_APPID];
    if(result){
        [STLog print:@"微信sdk注册成功"];
    }
}

-(void)initNet{
    NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
    [NSURLCache setSharedURLCache:URLCache];
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
}

#pragma mark 系统自带回调
- (void)applicationWillResignActive:(UIApplication *)application {
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
}


- (void)applicationWillEnterForeground:(UIApplication *)application {}


- (void)applicationDidBecomeActive:(UIApplication *)application {}


- (void)applicationWillTerminate:(UIApplication *)application {}


#pragma mark JPUSH Register

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    [STLog print:@"JPush 注册失败"];
}

#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    //这里处理推送带来的数据
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}



#pragma mark 3D Touch
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
    if ([shortcutItem.type isEqualToString:@"ShortCutOpen"]) {
        [STLog print:@"打开App"];
    }
    
    if ([shortcutItem.type isEqualToString:@"ShortCutShare"]) {
        [STLog print:@"分享"];
    }
    
}


#pragma mark 微信回调
-(void)onReq:(BaseReq *)req{
    
}

-(void)onResp:(BaseResp *)resp{
    //微信登录回调
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        SendAuthResp *authResp = (SendAuthResp *)resp;
        NSString *code =  authResp.code;
        [STLog print:@"微信登录票据" content:code];
        [[STObserverManager sharedSTObserverManager]sendMessage:Notify_WXLogin msg:code];
    }
    //微信支付回调
    if([resp isKindOfClass:[PayResp class]]){
        switch (resp.errCode) {
            case WXSuccess:
//                [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFY_WECAHT_PAY_SUCCESS object:nil];
                break;
            default:
//                [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFY_WECAHT_PAY_FAIL object:nil];
                break;
        }
    }
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    [WXApi handleOpenURL:url delegate:self];
    return YES;
}


-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    NSString *host = url.host;
    if([host isEqualToString:@"oauth"]){
        [WXApi handleOpenURL:url delegate:self];
    }else if([url.host isEqualToString:@"pay"]){
        return  [WXApi handleOpenURL:url delegate:self];
    }
    return YES;
}

//打开更新对话框
-(void)showUpdateAlert:(NSString *)downUrl version:(double)version{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"检测到新版本" message:[NSString stringWithFormat:@"是否更新到新版本v%.2f",version] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {

    }];
    UIAlertAction *updateAction = [UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
           [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/%E5%BE%AE%E4%BF%A1/id414478124?mt=8&v0=WWW-GCCN-ITSTOP100-FREEAPPS&l=&ign-mpt=uo%3D4"]];

    }];

    [alertController addAction:cancelAction];
    [alertController addAction:updateAction];
    [_window.rootViewController presentViewController:alertController animated:YES completion:nil];
}



@end
