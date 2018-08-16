
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
#import "UserModel.h"
#import "STUserDefaults.h"
#import <WXApi.h>
#import <Bugly/Bugly.h>
#import "STObserverManager.h"
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>
#import "STUpdateUtil.h"
#import "MainPage.h"
#import "NextLoginPage.h"
#import "AccountManager.h"
#import "MinePage.h"
#import "AuthUserPage.h"
#import "CommunityPage.h"
#import "MessagePage.h"
#import "IDLFaceSDK/IDLFaceSDK.h"
#import "FaceParameterConfig.h"
#import "PageManager.h"
#import "STNetUtil.h"
#import "STUploadImageUtil.h"
#import "FaceLoginPage.h"
#import "LocalFaceDetect.h"
#import "TestModelManager.h"
#import "MessagePage.h"
#import "PageManager.h"
#import "PushMsgModel.h"
#import "LoginPage.h"
#import "AuthStatuPage.h"
#import "PageManager.h"

@interface AppDelegate ()<JPUSHRegisterDelegate,WXApiDelegate,UIAlertViewDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    id controller;
    if([[AccountManager sharedAccountManager]isLogin]){
        controller = [[NextLoginPage alloc]init];
    }else{
        controller = [[LoginPage alloc]init];
    }
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:controller];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];

    [[STObserverManager sharedSTObserverManager]setup];
    [self initDB];
    [self initJPush:launchOptions];
    [self initWechat];
    [self initNet];
    [self initBaidu];
    [[AccountManager sharedAccountManager] clearApplyModel];
    [STUpdateUtil checkUpdate:^(NSString *appname, NSString *url, double version) {
//        [self showUpdateAlert:url version:version];
    }];
    
    [[PageManager sharedPageManager]initManager];
    
    [STNetUtil startListenNetWork:^(AFNetworkReachabilityStatus status) {
//        if(status == AFNetworkReachabilityStatusNotReachable){
//            [[[PageManager sharedPageManager]getCurrentPage] addNoNetView];
//        }
    }];
    [[STUploadImageUtil sharedSTUploadImageUtil]initOSS];

    [[TestModelManager sharedTestModelManager]initTestDatas];
    
    [Bugly startWithAppId:BUGLY_APPID];
    return YES;
}



-(void)initDB{
    [[STDataBaseUtil sharedSTDataBaseUtil]createTable:@"sthl" model:[UserModel class]];
    [[AccountManager sharedAccountManager]getUserModel];
}



-(void)initJPush:(NSDictionary *)launchOptions {
    [STUserDefaults saveKeyValue:UD_PUSHID value:@"171976fa8adb6fd285d"];

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
            [STUserDefaults saveKeyValue:UD_PUSHID value:registrationID];
            NSLog(@"registrationID获取成功：%@",registrationID);
        }
        else{
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
}


- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary * userInfo = [notification userInfo];
    NSString *content = [userInfo valueForKey:@"content"];
    NSString *messageID = [userInfo valueForKey:@"_j_msgid"];
    
    PushMsgModel *model = [PushMsgModel mj_objectWithKeyValues:content];
    model.messageId = messageID;
    
    if(model.serviceType == Push_Other_Login){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:model.title message:model.alert delegate:self cancelButtonTitle:MSG_CONFIRM otherButtonTitles:nil, nil];
        alert.tag = model.serviceType;
        [alert show];
    }else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:model.title message:model.alert delegate:self cancelButtonTitle:MSG_CANCEL otherButtonTitles:MSG_SEE, nil];
        alert.tag = model.serviceType;
        [alert show];
    }

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSInteger tag = alertView.tag;
    BaseViewController *page = [[PageManager sharedPageManager]getCurrentPage];
    if(page != nil){
        switch (tag) {
            case Push_Other_Login:
                [[PageManager sharedPageManager] popToLoginPage:page];
                break;
            default:
                if(buttonIndex == 1){
                    [MessagePage show:page];
                }
                break;
        }
    }
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

-(void)initBaidu{
    //获取百度access_token
    [LocalFaceDetect requestBaiduToken];
    //初始化百度人脸识别sdk
    if ([[FaceSDKManager sharedInstance] canWork]) {
        NSString* licensePath = [[NSBundle mainBundle] pathForResource:FACE_LICENSE_NAME ofType:FACE_LICENSE_SUFFIX];
        [[FaceSDKManager sharedInstance] setLicenseID:FACE_LICENSE_ID andLocalLicenceFile:licensePath];
    }
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
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler  API_AVAILABLE(ios(10.0)){
    NSDictionary * userInfo = notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            [JPUSHService handleRemoteNotification:userInfo];
        }
        completionHandler(UNNotificationPresentationOptionSound);
    }
//    id aps = [userInfo objectForKey:@"aps"];
}



- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler  API_AVAILABLE(ios(10.0)){
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            [JPUSHService handleRemoteNotification:userInfo];
        }
    }
    completionHandler();
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
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
        if([authResp.state isEqualToString:@"wxLogin"]){
            NSString *code =  authResp.code;
            [STLog print:@"微信登录票据" content:code];
            [[STObserverManager sharedSTObserverManager]sendMessage:Notify_WXLogin msg:code];
        }
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
