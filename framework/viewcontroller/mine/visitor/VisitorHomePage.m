//
//  VisitorHomePage.m
//  framework
//
//  Created by by.huang on 2018/5/23.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "VisitorHomePage.h"
#import "VisitorHomeView.h"
#import "VisitorPage.h"

@interface VisitorHomePage ()<VisitorHomeViewDelegate>

@property(strong, nonatomic)VisitorHomeView *visitorHomeView;
@end

@implementation VisitorHomePage

+(void)show:(BaseViewController *)controller{
    VisitorHomePage *page = [[VisitorHomePage alloc]init];
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = cwhite;
    [self showSTNavigationBar:MSG_VISITORHOME_TITLE needback:YES];
    [self initView];
}

-(void)initView{
    VisitorHomeViewModel *viewModel = [[VisitorHomeViewModel alloc]init];
    viewModel.delegate = self;
    
    _visitorHomeView = [[VisitorHomeView alloc]initWithViewModel:viewModel];
    _visitorHomeView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    [self.view addSubview:_visitorHomeView];
}

-(void)viewWillAppear:(BOOL)animated{
    [self setStatuBarBackgroud:cwhite];
}


-(void)onGoVisitorPage:(VisitorType)type{
    [VisitorPage show:self type:type];
}

@end