//
//  MainPage.m
//  framework
//
//  Created by 黄成实 on 2018/5/9.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MainPage.h"
#import "MainViewModel.h"
#import "MainView2.h"
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
#import "VerificateUserPage.h"
#import "EnterAuthPage.h"
#import "MemberPage.h"
#import "AddMemberPage.h"

@interface MainPage ()<MainViewDelegate>

@property(strong, nonatomic)MainViewModel *mViewModel;
@property(strong, nonatomic)MainView2 *mMainView;
@property(strong, nonatomic)UIView *mNavigationView;
@property(strong, nonatomic)UILabel *positionLabel;


@property(strong, nonatomic)UIImageView *positionImageView;
@property(strong, nonatomic)UIButton *mineBtn;
@property(strong, nonatomic)UIButton *msgBtn;
@property(assign, nonatomic)CGFloat mAlpha;

@end

@implementation MainPage

+(void)show:(BaseViewController *)controller{
    MainPage *page = [[MainPage alloc]init];
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _mAlpha = 1.0f;
    _mViewModel = [[MainViewModel alloc]init];
    _mViewModel.delegate = self;
    [self initView];
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setStatuBarBackgroud:[UIColor clearColor]];
    [self onUpdateNavigationBarColor:_mAlpha];
    [_mViewModel getUserInfo];
    [_mViewModel getLiveInfo];
}

-(void)initView{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, StatuNavHeight)];
    view.backgroundColor = cwhite;
    [self.view addSubview:view];
    
    _mNavigationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, StatuNavHeight)];
    _mNavigationView.backgroundColor = c34;
    [self.view addSubview:_mNavigationView];
    
    _positionImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(16), StatuBarHeight +  STHeight(15), STWidth(14), STHeight(18))];
    _positionImageView.contentMode = UIViewContentModeScaleAspectFill;
    _positionImageView.image = [UIImage imageNamed:@"首页_icon_定位"];
    [_mNavigationView addSubview:_positionImageView];
    
    _positionLabel = [[UILabel alloc]initWithFont:STFont(14) text:@"" textAlignment:NSTextAlignmentLeft textColor:cwhite backgroundColor:nil multiLine:NO];
    _positionLabel.frame = CGRectMake(STWidth(39),StatuBarHeight +  STHeight(14),ScreenWidth/2, STHeight(20));
    [_mNavigationView addSubview:_positionLabel];
    
    _mineBtn = [[UIButton alloc]initWithFrame:CGRectMake(STWidth(306), StatuBarHeight +  STHeight(14), STWidth(20), STWidth(20))];
    [_mineBtn setImage:[UIImage imageNamed:@"首页_icon_个人中心"] forState:UIControlStateNormal];
    [_mineBtn addTarget:self action:@selector(onGoMinePage) forControlEvents:UIControlEventTouchUpInside];
    [_mNavigationView addSubview:_mineBtn];
    
    _msgBtn = [[UIButton alloc]initWithFrame:CGRectMake(STWidth(340), StatuBarHeight +  STHeight(14), STWidth(20), STWidth(20))];
    [_msgBtn setImage:[UIImage imageNamed:@"首页_icon_消息"] forState:UIControlStateNormal];
    [_msgBtn addTarget:self action:@selector(onGoMessagePage) forControlEvents:UIControlEventTouchUpInside];
    [_mNavigationView addSubview:_msgBtn];
    
    _mMainView = [[MainView2 alloc]initWithViewModel:_mViewModel];
    _mMainView.frame = CGRectMake(0, StatuBarHeight+NavigationBarHeight, ScreenWidth, ContentHeight);
    _mMainView.backgroundColor = c15;
    [self.view addSubview:_mMainView];
    
    

    
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

-(void)onGoMessageDetailPage:(MessageModel *)msgModel{
    MessageType type = [MessageModel translateType:msgModel.applyType];
    if(type == UserAuth){
        [VerificateUserPage show:self model:msgModel];
    }else if(type == CarEnter || type == VisitorEnter){
        [EnterAuthPage show:self model:msgModel];
    }
}

-(void)onGoMemberPage{
    [MemberPage show:self];
}

-(void)onGoAddMemberPage{
    [AddMemberPage show:self];
}

-(void)onRequestBegin{
    
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    if([respondModel.requestUrl isEqualToString:URL_GETMAININFO]){
        if(_mMainView){
//            [_mMainView updateView];
            MainModel *model = data;
            _positionLabel.text = model.districtName;

        }
    }else if([respondModel.requestUrl isEqualToString:URL_GETLIVEINFO]){
            ApplyModel *applyModel = [[AccountManager sharedAccountManager] getApplyModel];
            if(applyModel && (applyModel.statu == APPLY_DEFAULT || applyModel.statu == APPLYING|| applyModel.statu == APPLY_REJECT)){
                [_mViewModel.memberDatas removeAllObjects];
                MemberModel *model = [[MemberModel alloc]init];
                model.nickname = MSG_ADD;
                model.faceUrl = @"首页_icon_添加";
                [_mViewModel.memberDatas addObject:model];
                [_mMainView updateMemberView];
                [_mMainView updateMsgView];
                return;
            }
            [_mViewModel requestMemberDatas];
        
        }else if([respondModel.requestUrl isEqualToString:URL_GETFAMILY_MEMBER]){
            if(_mMainView){
                [_mMainView updateMemberView];
            }
        [_mViewModel requestMessageList];
    }else if([respondModel.requestUrl isEqualToString:URL_GET_MESSAGELIST]){
        if(_mMainView){
            [_mMainView updateMsgView];
        }
    }
}

-(void)onRequestFail:(NSString *)msg{
    if([msg isEqualToString:STATU_LIVEINFO_NO_INFO]){
        [self onOpenCheckInfoAlert];
    }
}


-(void)onOpenCheckInfoAlert{
    WS(weakSelf)
    [STAlertUtil showAlertController:@"" content:MSG_MAIN_CHECKIN controller:self confirm:^{
        [AuthUserPage show:weakSelf];
    }];

}

-(void)onGoAuthUserPage{
    [AuthUserPage show:self];
}


-(void)onGoAuthStatuPage{
    [AuthStatuPage show:self];
}

-(void)onShowAuthFailDialog{
    WS(weakSelf)
    [STAlertUtil showAlertController:@"" content:MSG_MESSAGE_AUTH_FAIL_CONTENT controller:self confirm:^{
        [AuthUserPage show:weakSelf];
    } cancel:^{
        
    } confirmStr:MSG_REAUTH cancelStr:MSG_CANCEL];
}

-(void)onUpdateNavigationBarColor:(CGFloat )alpha{
    
    _mAlpha = alpha;
    _mNavigationView.backgroundColor = [c34 colorWithAlphaComponent:alpha];
    if(alpha > 0.5f){
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        _positionLabel.textColor = cwhite;
        _positionImageView.image = [UIImage imageNamed:@"首页_icon_定位"];
        [_mineBtn setImage:[UIImage imageNamed:@"首页_icon_个人中心"] forState:UIControlStateNormal];
        [_msgBtn setImage:[UIImage imageNamed:@"首页_icon_消息"] forState:UIControlStateNormal];
    }else{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        _positionLabel.textColor = c11;
        _positionImageView.image = [UIImage imageNamed:@"首页_首页_icon_定位_黑"];
        [_mineBtn setImage:[UIImage imageNamed:@"首页_icon_个人中心_黑"] forState:UIControlStateNormal];
        [_msgBtn setImage:[UIImage imageNamed:@"首页_icon_消息_黑"] forState:UIControlStateNormal];
    }
    
    LiveModel *liveModel = [[AccountManager sharedAccountManager]getLiveModel];
    NSArray *array =  [liveModel.homeFullName componentsSeparatedByString:@","];
    if(!IS_NS_COLLECTION_EMPTY(array)){
        _positionLabel.text = [array objectAtIndex:0];
    }
    
}


@end
