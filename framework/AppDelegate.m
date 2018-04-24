//
//  AppDelegate.m
//  framework
//
//  Created by 黄成实 on 2018/4/17.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "AppDelegate.h"
#import "STDataBaseUtil.h"
#import "ByModel.h"
#import "STRuntimeUtil.h"
#import "ByViewController.h"
#import <iflyMSC/IFlyFaceSDK.h>
#import "UserModel.h"
#import "STUserDefaults.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    ByViewController *controller = [[ByViewController alloc]init];
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:controller];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
    [self initIFly];
    [self initDB];
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
    [[STDataBaseUtil sharedSTDataBaseUtil]createTable:@"by666" model:[ByModel class]];
    
    
    UserModel *model = [[UserModel alloc]init];
    model.uid = 123124;
    model.age = 12;
    model.nickName = @"by";
    model.gender = @"male";
    model.avatarUrl = @"http://www.baidu.com";
    model.phoneNum = @"18680686420";
    [STUserDefaults saveModel:@"usermodel" model:model];

    UserModel *testModel = [STUserDefaults getModel:@"usermodel"];
    
    UIImage *image = [UIImage imageNamed:@"test"];
    [STUserDefaults saveImage:@"testImg" image:image];

}


- (void)applicationWillResignActive:(UIApplication *)application {
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
}


- (void)applicationWillEnterForeground:(UIApplication *)application {}


- (void)applicationDidBecomeActive:(UIApplication *)application {}


- (void)applicationWillTerminate:(UIApplication *)application {}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
    if ([shortcutItem.type isEqualToString:@"ShortCutOpen"]) {
        [STLog print:@"打开App"];
    }
    
    if ([shortcutItem.type isEqualToString:@"ShortCutShare"]) {
        [STLog print:@"分享"];
    }
    
}

@end
