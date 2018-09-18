//
//  VideoPage.m
//  framework
//
//  Created by by.huang on 2018/9/18.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "VideoPage.h"
#import "VideoView.h"

@interface VideoPage ()<VideoViewDelegate>

@property(strong, nonatomic)VideoView *videoView;

@end

@implementation VideoPage


+(void)show:(BaseViewController *)controller{
    VideoPage *page = [[VideoPage alloc]init];
    [controller presentViewController:page animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setStatuBarBackgroud:c39];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}


-(void)initView{
    VideoViewModel *viewModel = [[VideoViewModel alloc]init];
    viewModel.delegate = self;
    
    _videoView = [[VideoView alloc]initWithViewModel:viewModel];
    _videoView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    _videoView.backgroundColor =c39;
    [self.view addSubview:_videoView];
}

-(void)onDoReject{
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
