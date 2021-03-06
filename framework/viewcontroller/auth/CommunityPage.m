//
//  CommunityPage.m
//  framework
//
//  Created by 黄成实 on 2018/5/28.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "CommunityPage.h"
#import "CommunityView.h"

@interface CommunityPage()<CommunityViewDelegate>

@property(strong, nonatomic)CommunityView *communityView;

@end

@implementation CommunityPage

+(void)show:(BaseViewController *)controller{
    CommunityPage *page = [[CommunityPage alloc]init];
    [controller pushPage:page];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = c15;
    [self initView];
    [self showSTNavigationBar:MSG_COMMUNITY_TITLE needback:YES];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setStatuBarBackgroud:cwhite];
}

-(void)initView{
    CommunityViewModel *viewModel = [[CommunityViewModel alloc]init];
    viewModel.delegate = self;
    
    _communityView = [[CommunityView alloc]initWithViewModel:viewModel];
    _communityView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    _communityView.backgroundColor = c15;
    [self.view addSubview:_communityView];
}

-(void)onSearchCommunity:(Boolean)success datas:(NSMutableArray *)datas errorMsg:(NSString *)errorMsg{
    [_communityView updateView];
}

-(void)onBackLastPage{
    [self backLastPage];
}

-(void)onRequestBegin{
    WS(weakSelf)
    dispatch_main_async_safe(^{
        [MBProgressHUD showHUDAddedTo:weakSelf.view animated:YES];
    });
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if(_communityView){
        [_communityView updateView];
    }
}

-(void)onRequestFail:(NSString *)msg{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [STToastUtil showTips:msg];
}
@end
