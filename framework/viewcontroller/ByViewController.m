 //
//  ByViewController.m
//  framework
//
//  Created by 黄成实 on 2018/4/20.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "ByViewController.h"
#import "ByViewModel.h"
#import "ByView.h"
#import "SystemFacePage.h"
#import "IFlyOnlineFaceDetectPage.h"
#import "IFlyOfflineFaceDetectPage.h"
#import "IFlyOfflineVedioDetectPage.h"


@interface ByViewController ()<ByViewDelegate>
@property (strong, nonatomic)ByViewModel *mByViewModel;

@end

@implementation ByViewController


-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)viewDidLoad{
    [self hideNavigationBar:NO];
    self.navigationItem.title = @"人脸识别测试";
    [self.view setBackgroundColor:c01];
    [self initBodyView];
}



-(void)initBodyView{
    _mByViewModel = [[ByViewModel alloc]init];
    ByView *byView = [[ByView alloc]initWithViewModel:_mByViewModel];
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

@end
