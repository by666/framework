
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
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "STFileUtil.h"
#import "LocalFaceDetect.h"
#import "WYManager.h"
#import "VideoPage.h"
#import "STNetUtil.h"
#import "STAudioUtil.h"
#import "STTimeUtil.h"
@interface AppDelegate ()<JPUSHRegisterDelegate,WXApiDelegate,UIAlertViewDelegate,WYDelegate>

@property(assign, nonatomic) Boolean isAppEnterBackgroud;
@end

@implementation AppDelegate{
    NSMutableArray *imageDatas;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    imageDatas = [[NSMutableArray alloc]init];
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
    [self initDB];
    [self initJPush:launchOptions];
    [self initWechat];
    [self initNet];
    [self initBaidu];
    [self initWY];
    [[AccountManager sharedAccountManager] clearApplyModel];
    WS(weakSelf)
    [STUpdateUtil checkUpdate:^(NSString *appname, NSString *url, double version) {
        [weakSelf showUpdateAlert:url version:version];
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
   
    
//    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//
//
//    NSString *directryPath = [path stringByAppendingPathComponent:@"degree"];
//    [fileManager createDirectoryAtPath:directryPath withIntermediateDirectories:YES attributes:nil error:nil];
//
//    NSString *directryPath2 = [path stringByAppendingPathComponent:@"error"];
//    [fileManager createDirectoryAtPath:directryPath2 withIntermediateDirectories:YES attributes:nil error:nil];
//
//    NSString *directryPath3 = [path stringByAppendingPathComponent:@"mutiple"];
//    [fileManager createDirectoryAtPath:directryPath3 withIntermediateDirectories:YES attributes:nil error:nil];
//
//    NSString *directryPath4 = [path stringByAppendingPathComponent:@"probility"];
//    [fileManager createDirectoryAtPath:directryPath4 withIntermediateDirectories:YES attributes:nil error:nil];
//
//    NSString *directryPath5 = [path stringByAppendingPathComponent:@"fail"];
//    [fileManager createDirectoryAtPath:directryPath5 withIntermediateDirectories:YES attributes:nil error:nil];
//
//
//    [self getOriginalImages];
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        for(UIImage *image in imageDatas){
//            [self detect:image];
//        }
//    });
    return YES;
}

//
//-(void)detect:(UIImage *)image{
//    [LocalFaceDetect detectLocalImage:image success:^(id respond) {
//        [STLog print:@"成功"];
//    } failure:^(id fail) {
//        [STLog print:fail];
//    }];
//}


-(void)initDB{
    [[STDataBaseUtil sharedSTDataBaseUtil]createTable:ST_TABLENAME model:[UserModel class]];
    [[AccountManager sharedAccountManager]getUserModel];
}



-(void)initJPush:(NSDictionary *)launchOptions {
    [STUserDefaults saveKeyValue:UD_PUSHID value:JPUSH_APPID];

    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    [JPUSHService setupWithOption:launchOptions appKey:JPUSH_APPKEY
                          channel:CHANNELID
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
    }else if(model.serviceType == Push_FACE_ADD){
        if([model.alert containsString:@"失败"]){
            [[STObserverManager sharedSTObserverManager] sendMessage:Notify_Face_Add msg:@NO];
        }else{
            [[STObserverManager sharedSTObserverManager] sendMessage:Notify_Face_Add msg:@YES];
        }
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
    _isAppEnterBackgroud = YES;
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    _isAppEnterBackgroud = NO;
}


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
           [[UIApplication sharedApplication] openURL:[NSURL URLWithString:APPSTORE_DOWNLOAD_URL]];

    }];

    [alertController addAction:cancelAction];
    [alertController addAction:updateAction];
    [_window.rootViewController presentViewController:alertController animated:YES completion:nil];
}

//
//- (void)getOriginalImages
//{
//    // 获得所有的自定义相簿
//    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
//    // 遍历所有的自定义相簿
//    for (PHAssetCollection *assetCollection in assetCollections) {
//        [self enumerateAssetsInAssetCollection:assetCollection original:YES];
//    }
//
//    // 获得相机胶卷
//    PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
//    // 遍历相机胶卷,获取大图
//    [self enumerateAssetsInAssetCollection:cameraRoll original:YES];
//}
//
//- (void)enumerateAssetsInAssetCollection:(PHAssetCollection *)assetCollection original:(BOOL)original
//{
//    NSLog(@"相簿名:%@", assetCollection.localizedTitle);
//
//    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
//    // 同步获得图片, 只会返回1张图片
//    options.synchronous = YES;
//
//    // 获得某个相簿中的所有PHAsset对象
//    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
//    for (PHAsset *asset in assets) {
//        // 是否要原图
//        CGSize size = original ? CGSizeMake(asset.pixelWidth, asset.pixelHeight) : CGSizeZero;
//
//        // 从asset中获得图片
//        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
//            NSLog(@"%@", result);
//            [imageDatas addObject:result];
//        }];
//    }
//}
//



-(void)initWY{
    [[WYManager sharedWYManager]initSDK];
    [WYManager sharedWYManager].delegate = self;
    if([[AccountManager sharedAccountManager]isLogin]){
        WYUserModel *wyUserModel = [[AccountManager sharedAccountManager]getWYUserModel];
        [[WYManager sharedWYManager]doLogin:wyUserModel.accId psw:wyUserModel.token];
    }
}

-(void)onDoLoginCallback:(Boolean)success msg:(NSString *)errorMsg{
    [STLog print:errorMsg];
}

-(void)onDoCallCallback:(Boolean)success msg:(NSString *)errorMsg{
    [STLog print:errorMsg];
}

-(void)onDoRespondCallback:(Boolean)success msg:(NSString *)errorMsg{
    [STLog print:errorMsg];
}

-(void)onRecordCall:(NIMNetCallNotificationContent *)content{
    NSString *caller = [STUserDefaults getKeyValue:UD_CALL_CALLER];
    NSString *callee = [STUserDefaults getKeyValue:UD_CALL_CALLEE];
    NSString *startTime = [STUserDefaults getKeyValue:UD_CALL_STARTTIME];
    NSString *calledTime = [STUserDefaults getKeyValue:UD_CALL_CALLEDTIME];
    NSString *endTime = [STUserDefaults getKeyValue:UD_CALL_ENTTIME];
    LiveModel *liveModel = [[AccountManager sharedAccountManager]getLiveModel];
    NSString *districtUid = liveModel.districtUid;
    NSString *homeLocator =liveModel.homeLocator;
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"callerUserUid"] = caller;
    dic[@"calleeUserUid"] = callee;
    dic[@"startTime"] = startTime;
    dic[@"calledTime"] = calledTime;
    dic[@"endTime"] = endTime;
    dic[@"districtUid"] = districtUid;
    dic[@"homeLocator"] = homeLocator;

    [STNetUtil post:URL_POST_CREATE_RECORD content:[dic mj_JSONString] success:^(RespondModel *respondModel) {
        
    } failure:^(int errorCode) {
        
    }];

}

-(void)onCallStatuCallback:(CallStatu)statu callId:(UInt64)callID caller:(NSString *)caller callee:(NSString *)callee type:(NIMNetCallMediaType)type accept:(Boolean)accept{
    switch (statu) {
        case ReciveCall:
            [STLog print:@"接收到来电邀请"];
            [self handleReciveCall:caller callID:callID];
            break;
            //被叫接听或拒接主叫来电
        case RespondCall:
            [STLog print: accept ? @"接听" : @"拒绝"];
            if(accept){
                [[STObserverManager sharedSTObserverManager] sendMessage:Notify_CALL_ACCEPT msg:[NSString stringWithFormat:@"%llu",callID]];
            }else{
                [[STObserverManager sharedSTObserverManager] sendMessage:Notify_CALL_REJECT msg:[NSString stringWithFormat:@"%llu",callID]];
            }
            break;
            //被叫正在通话中
        case Calling:
            [STLog print:@"被叫正在通话中"];
            [[STObserverManager sharedSTObserverManager] sendMessage:Notify_CALL_CALLING msg:[NSString stringWithFormat:@"%llu",callID]];
            break;
            //通话建立成功
        case ConnectSuccess:
            [STLog print:@"通话成功"];
            [self handleConnectSuccess:callID];
            break;
            //通话挂断
        case Hangup:
            [STLog print:@"通话挂断"];
            [self handleHungup:callID];
            break;
            //连接异常挂断
        case Disconnect:
            [STLog print:@"通话被动或异常挂断"];
            [self handleDisconnect:callID];
            break;
        default:
            break;
    }

    
}


-(void)handleReciveCall:(NSString *)caller callID:(UInt64)callID{
    //记录接收到通话的时间
    NSString *recordStr = [STTimeUtil generateDate:[STTimeUtil getCurrentTimeStamp] format:@"YYYY-MM-dd HH:mm:ss"];
    [STUserDefaults saveKeyValue:UD_CALL_STARTTIME value:recordStr];
    
    //记录被叫
    UserModel *userModel = [[AccountManager sharedAccountManager]getUserModel];
    [STUserDefaults saveKeyValue:UD_CALL_CALLEE value:userModel.userUid];

    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"accId"] = caller;
    WS(weakSelf)
    [STNetUtil get:URL_GET_USER_BY_ACCID parameters:dic success:^(RespondModel *respondModel) {
        id user = [respondModel.data objectForKey:@"user"];
        UserModel *userModel = [UserModel mj_objectWithKeyValues:user];
        //记录主叫
        [STUserDefaults saveKeyValue:UD_CALL_CALLER value:userModel.userUid];
        [VideoPage show:[[PageManager sharedPageManager]getCurrentPage] callID:callID userModel:userModel];
        [[STAudioUtil sharedSTAudioUtil]startPlay:@"ring"];
        if(weakSelf.isAppEnterBackgroud){
            [self sendLocalNotification:userModel];
        }
    } failure:^(int errorCode) {
        [STLog print:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}

-(void)handleConnectSuccess:(UInt64)callID{
    //记录接通时间
    NSString *recordStr = [STTimeUtil generateDate:[STTimeUtil getCurrentTimeStamp] format:@"YYYY-MM-dd HH:mm:ss"];
    [STUserDefaults saveKeyValue:UD_CALL_CALLEDTIME value:recordStr];
    [[STObserverManager sharedSTObserverManager] sendMessage:Notify_CALL_CONNECTED msg:[NSString stringWithFormat:@"%llu",callID]];
}


-(void)handleHungup:(UInt64)callID{
    //记录结束时间
    NSString *recordStr = [STTimeUtil generateDate:[STTimeUtil getCurrentTimeStamp] format:@"YYYY-MM-dd HH:mm:ss"];
    [STUserDefaults saveKeyValue:UD_CALL_ENTTIME value:recordStr];
    [[STObserverManager sharedSTObserverManager] sendMessage:Notify_CALL_HUNGUP msg:[NSString stringWithFormat:@"%llu",callID]];
}

-(void)handleDisconnect:(UInt64)callID{
    //记录结束时间
    NSString *recordStr = [STTimeUtil generateDate:[STTimeUtil getCurrentTimeStamp] format:@"YYYY-MM-dd HH:mm:ss"];
    [STUserDefaults saveKeyValue:UD_CALL_ENTTIME value:recordStr];
    [[STObserverManager sharedSTObserverManager] sendMessage:Notify_CALL_DISCONNECT msg:[NSString stringWithFormat:@"%llu",callID]];

}


-(void)sendLocalNotification:(UserModel *)userModel{
    NSString *content = [NSString stringWithFormat:@"您有一个%@的来电",userModel.userName];
    UILocalNotification *localNote = [[UILocalNotification alloc] init];
    localNote.fireDate = [NSDate dateWithTimeIntervalSinceNow:30];
    localNote.alertBody = content;
    localNote.alertAction = content; // 锁屏状态下显示: 滑动来快点啊
    localNote.alertTitle = @"来电请求";
    localNote.soundName = @"notify_ring.wav";
    localNote.userInfo = @{@"type":@1};
    [[UIApplication sharedApplication] scheduleLocalNotification:localNote];
}

@end
