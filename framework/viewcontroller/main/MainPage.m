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
#import "AccountManager.h"
#import "FaceEnterPage2.h"
#import "IDLFaceSDK/IDLFaceSDK.h"
#import "AuthStatuPage.h"

@interface MainPage ()<MainViewDelegate>

@property(strong, nonatomic)MainViewModel *mViewModel;
@property(strong, nonatomic)MainView *mMainView;
@property(strong, nonatomic)STNavigationView *mNavigationView;
@property(strong, nonatomic)UILabel *positionLabel;

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
    [super viewWillAppear:animated];
    [self setStatuBarBackgroud:cwhite];
}

-(void)initView{
    
    _mNavigationView = [[STNavigationView alloc]initWithTitle:@"" needBack:NO];
    [self.view addSubview:_mNavigationView];
    
    UIImageView *positionImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(19), STHeight(12), STWidth(14), STHeight(18))];
    positionImageView.contentMode = UIViewContentModeScaleAspectFill;
    positionImageView.image = [UIImage imageNamed:@"ic_building"];
    [_mNavigationView addSubview:positionImageView];
    
    _positionLabel = [[UILabel alloc]initWithFont:STFont(17) text:@"" textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    [_mNavigationView addSubview:_positionLabel];
    
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
    MainModel *model = [[AccountManager sharedAccountManager]getMainModel];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",model.tel]];
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
    if([respondModel.requestUrl isEqualToString:URL_GETMAININFO]){
        if(_mMainView){
            [_mMainView updateView];
            MainModel *model = data;
            _positionLabel.text = model.detailAddr;
            CGSize labelSize = [model.detailAddr sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(17)]];
            _positionLabel.frame = CGRectMake(STWidth(52), 0, labelSize.width, NavigationBarHeight);

        }
    }else if([respondModel.requestUrl isEqualToString:URL_GETLIVEINFO]){
        if(_mViewModel){
            _mViewModel.statu = STATU_SUCCESS;
        }
    }
}

-(void)onRequestFail:(NSString *)msg{
    if([msg isEqualToString:STATU_LIVEINFO_NO_INFO]){
        [self onOpenCheckInfoAlert];
    }
    _mViewModel.statu = msg;
}


-(void)onOpenCheckInfoAlert{
    WS(weakSelf)
    [STAlertUtil showAlertController:@"" content:MSG_MAIN_CHECKIN controller:self confirm:^{
        [AuthUserPage show:weakSelf];
    }];

}


-(void)onGoAuthStatuPage{
    [AuthStatuPage show:self];
}

@end
