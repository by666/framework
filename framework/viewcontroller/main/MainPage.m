//
//  MainPage.m
//  framework
//
//  Created by 黄成实 on 2018/5/9.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MainPage.h"
#import "MainViewModel.h"
#import "MainView.h"
#import "STNavigationView.h"
#import "MinePage.h"
#import "AuthUserPage.h"
#import "MessagePage.h"
#import "OpendoorPage.h"
#import "ReportFixPage.h"
#import "CarHistoryPage.h"
#import "VisitorHomePage.h"
#import "VisitorHistoryPage.h"
#import "DeviceSharePage.h"

@interface MainPage ()<MainViewDelegate>

@property(strong, nonatomic)MainViewModel *mViewModel;
@property(strong, nonatomic)MainView *mMainView;
@property(strong, nonatomic)STNavigationView *mNavigationView;

@end

@implementation MainPage

+(void)show:(BaseViewController *)controller{
    MainPage *page = [[MainPage alloc]init];
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _mViewModel = [[MainViewModel alloc]init];
    _mViewModel.delegate = self;
    [self initView];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}


-(void)viewWillAppear:(BOOL)animated{
    [self setStatuBarBackgroud:cwhite];
}

-(void)initView{
    
    _mNavigationView = [[STNavigationView alloc]initWithTitle:@"" needBack:NO];
    [self.view addSubview:_mNavigationView];
    
    UIImageView *positionImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(19), STHeight(12), STWidth(14), STHeight(18))];
    positionImageView.contentMode = UIViewContentModeScaleAspectFill;
    positionImageView.image = [UIImage imageNamed:@"ic_building"];
    [_mNavigationView addSubview:positionImageView];
    
    UILabel *positionLabel = [[UILabel alloc]initWithFont:STFont(17) text:@"武当山" textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    CGSize labelSize = [@"武当山" sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(17)]];
    positionLabel.frame = CGRectMake(STWidth(52), 0, labelSize.width, NavigationBarHeight);
    [_mNavigationView addSubview:positionLabel];
    
    _mMainView = [[MainView alloc]initWithViewModel:_mViewModel];
    _mMainView.frame = CGRectMake(0, StatuBarHeight+NavigationBarHeight, ScreenWidth, ContentHeight);
    _mMainView.backgroundColor = c15;
    [self.view addSubview:_mMainView];
    
    
    [_mViewModel getUserInfo];
    [_mViewModel getLiveInfo];
    
}

-(void)onGoOpendoorPage{
    [OpendoorPage show:self];
}

-(void)onGoCarPage{
    [CarHistoryPage show:self];
}

-(void)onGoVisitorPage{
    [VisitorHomePage show:self];
}

-(void)onGoVisitorHistoryPage{
    [VisitorHistoryPage show:self];
}

-(void)onGoReportFixPage{
    [ReportFixPage show:self];
}

-(void)onGoDeviceSharePage{
    [DeviceSharePage show:self];
}

-(void)onDoCallProperty{
    NSURL *url = [NSURL URLWithString:@"tel://0755-80123456"];
    [[UIApplication sharedApplication] openURL:url];
}

-(void)onGoMessagePage{
    [MessagePage show:self];
}

-(void)onGoMinePage{
    [MinePage show:self];
}

-(void)onRequestBegin{
    
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    
}

-(void)onRequestFail:(NSString *)msg{
    //信息未录入
    if([msg isEqualToString:STATU_LIVEINFO_NULL]){
        WS(weakSelf)
        [STAlertUtil showAlertController:@"" content:@"请先认证身份信息" controller:self confirm:^{
            [AuthUserPage show:weakSelf];
        }];
    }
}

@end
