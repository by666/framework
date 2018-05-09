 //
//  ByViewController.m
//  framework
//
//  Created by 黄成实 on 2018/4/20.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "ByViewController.h"
#import "ByView.h"
#import "SystemFacePage.h"
#import "IFlyOnlineFaceDetectPage.h"
#import "IFlyOfflineFaceDetectPage.h"
#import "IFlyOfflineVedioDetectPage.h"
#import "MasonryPage.h"
#import "STObserverManager.h"
#import "QRCodePage.h"


@interface ByViewController ()<ByViewDelegate>

@end

@implementation ByViewController


-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)viewDidLoad{
    [self hideNavigationBar:NO];
    self.navigationItem.title = @"demo";
    [self.view setBackgroundColor:c01];
    [self initBodyView];
}


-(void)initBodyView{
    ByView *byView = [[ByView alloc]init];
    byView.byViewDelegate = self;
    [self.view addSubview:byView];
}


-(void)goSystemFacePage{
    SystemFacePage *page = [[SystemFacePage alloc]init];
    [self pushPage:page];
}

-(void)goIFlyOnlineFaceDetectPage{
    IFlyOnlineFaceDetectPage *page = [[IFlyOnlineFaceDetectPage alloc]init];
    [self pushPage:page];
}

-(void)goIFlyOfflineFaceDetectPage{
    IFlyOfflineFaceDetectPage *page = [[IFlyOfflineFaceDetectPage alloc]init];
    [self pushPage:page];
}

-(void)goIFlyOfflineVedioDetectPage{
    IFlyOfflineVedioDetectPage *page = [[IFlyOfflineVedioDetectPage alloc]init];
    [self pushPage:page];
}

-(void)goMasonryPage{
    
    MasonryPage *page = [[MasonryPage alloc]init];
    [self pushPage:page];
}

-(void)goQRPage{
    QRCodePage *vc = [QRCodePage new];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
