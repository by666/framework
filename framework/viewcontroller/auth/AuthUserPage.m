//
//  AuthUserPage.m
//  framework
//
//  Created by 黄成实 on 2018/5/24.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "AuthUserPage.h"
#import "AuthUserView.h"
#import "CommunityPage.h"
#import "AuthFacePage.h"
#import "STObserverManager.h"
#import "TitleContentModel.h"
#import "STLocationManager.h"
#import "RecognizeModel.h"

@interface AuthUserPage ()<AuthUserViewDelegate,STObserverProtocol>

@property(strong, nonatomic)AuthUserView *authUserView;
@property(assign, nonatomic)Boolean once;
@property(strong, nonatomic)AuthUserViewModel *viewModel;

@end

@implementation AuthUserPage

+(void)show:(BaseViewController *)controller{
    AuthUserPage *page = [[AuthUserPage alloc]init];
    [controller pushPage:page];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = c15;
    [self initView];
    [self showSTNavigationBar:MSG_AUTHUSER_TITLE needback:YES];
    [[STObserverManager sharedSTObserverManager]registerSTObsever:Notify_UpdateAddress delegate:self];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setStatuBarBackgroud:cwhite];
}

-(void)dealloc{
    [[STObserverManager sharedSTObserverManager]removeSTObsever:Notify_UpdateAddress];
    if(_authUserView){
        [_authUserView removeView];
    }
}

-(void)initView{
    _viewModel = [[AuthUserViewModel alloc]init];
    _viewModel.delegate = self;
    
    _authUserView = [[AuthUserView alloc]initWithViewModel:_viewModel];
    _authUserView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    _authUserView.backgroundColor = c15;
    [self.view addSubview:_authUserView];

    WS(weakSelf)
    [[STLocationManager sharedSTLocationManager]getMoLocationWithSuccess:^(double lat, double lng) {
        if(!weakSelf.once){
            weakSelf.once = YES;
            [weakSelf.viewModel getCommunityPosition:lng latitude:lat];
        }
    } Failure:^(NSError *error) {
        
    }];
}


-(void)onGoCommunity{
    [CommunityPage show:self];
}


-(void)submitUserInfo:(Boolean)success msg:(NSString *)errorMsg{
    [_authUserView onSubmitResult:success errorMsg:errorMsg];
    if(success){
        [AuthFacePage show:self model:_viewModel.userCommitModel];
    }
}


-(void)onReciveResult:(NSString *)key msg:(id)msg{
    if([key isEqualToString:Notify_UpdateAddress]){
        if([msg isKindOfClass:[CommunityPositionModel class]]){
            CommunityPositionModel *model = msg;
            [_viewModel getCommunityLayer:model];
            [_authUserView updateAddress:model.districtName];
        }
    }
}

-(void)onRequestBegin{
    WS(weakSelf)
    dispatch_main_async_safe(^{
        [MBProgressHUD showHUDAddedTo:weakSelf.view animated:YES];
    });
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    if([respondModel.requestUrl isEqualToString:URL_GETCOMMUNITYPOSITION]){
        if([data isEqualToString:MSG_AUTHUSER_POSITION_ERROR]){
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
        if(_authUserView){
            [_authUserView updateAddress:data];
        }
    }else if([respondModel.requestUrl isEqualToString:URL_GETCOMMUNITYLAYER]){
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if(_authUserView){
            [_authUserView updateBuildLayerView:respondModel.data level:[data intValue]];
        }
    }else if([respondModel.requestUrl isEqualToString:URL_GETCOMMUNITYDOOR]){
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            NSMutableArray *datas = data;
            if(!IS_NS_COLLECTION_EMPTY(datas)){
                RecognizeModel *model = [datas objectAtIndex:0];
                _viewModel.userCommitModel.homeLocator = model.homeLocator;
            }
        }
        if([respondModel.status isEqualToString:STATU_CHECKIN_DOOR_NULL]){
            if(_authUserView){
                [_authUserView updateDoorDatas:data];
            }
        }
    }

}

-(void)onRequestFail:(NSString *)msg{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [STToastUtil showTips:msg];
}

@end
