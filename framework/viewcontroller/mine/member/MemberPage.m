//
//  MemberPage.m
//  framework
//
//  Created by 黄成实 on 2018/5/15.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MemberPage.h"
#import "MemberView.h"
#import "AddMemberPage.h"
#import "STObserverManager.h"
#import "BaseNoNetView.h"
#import "STNetUtil.h"
@interface MemberPage ()<MemberViewDelegate,STObserverProtocol>

@property(strong, nonatomic)MemberView *memberView;
@property(strong, nonatomic)MemberViewModel *viewModel;
@property(strong, nonatomic)BaseNoNetView *noNetView;
@end

@implementation MemberPage

+(void)show:(BaseViewController *)controller{
    MemberPage *page = [[MemberPage alloc]init];
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = c15;
    [self showSTNavigationBar:MSG_MEMBER_TITLE needback:YES];
    [self initView];
    [[STObserverManager sharedSTObserverManager] registerSTObsever:Notify_AddMember delegate:self];
    [[STObserverManager sharedSTObserverManager] registerSTObsever:Notify_DeleteMember delegate:self];
    [[STObserverManager sharedSTObserverManager] registerSTObsever:Notify_UpdateMember delegate:self];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setStatuBarBackgroud:cwhite];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

-(void)dealloc{
    [[STObserverManager sharedSTObserverManager]removeSTObsever:Notify_AddMember];
    [[STObserverManager sharedSTObserverManager]removeSTObsever:Notify_DeleteMember];
    [[STObserverManager sharedSTObserverManager]removeSTObsever:Notify_UpdateMember];
}




-(void)initView{
    _viewModel = [[MemberViewModel alloc]init];
    _viewModel.delegate = self;
    _memberView = [[MemberView alloc]initWithViewModel:_viewModel];
    _memberView.frame = CGRectMake(0, StatuNavHeight, ScreenWidth, ContentHeight);
    [self.view addSubview:_memberView];
    if([STNetUtil isNetAvailable]){
        _memberView.hidden = NO;
        if(_viewModel){
            [_viewModel requestMemberDatas];
        }
    }else{
        _memberView.hidden = YES;
        WS(weakSelf)
        _noNetView = [[BaseNoNetView alloc]initWithBlock:^{
            if(weakSelf.viewModel){
                [weakSelf.viewModel requestMemberDatas];
            }
        }];
        [self.view addSubview:_noNetView];
    }
}



-(void)onRequestBegin{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

-(void)onRequestFail:(NSString *)msg{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [STToastUtil showFailureAlertSheet:msg];
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    _memberView.hidden = NO;
    _noNetView.hidden = YES;
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if(_memberView){
        [_memberView updateView];
    }
}

-(void)onGoAddMemberView{
    [AddMemberPage show:self];
}

-(void)onGoEditMemberView:(MemberModel *)model{
    [AddMemberPage show:self model:model];
}



-(void)onReciveResult:(NSString *)key msg:(id)msg{
    if([key isEqualToString:Notify_AddMember]){
        [_viewModel.datas addObject:msg];
        [_memberView updateView];
        return;
    }
    if([key isEqualToString:Notify_DeleteMember] || [key isEqualToString:Notify_UpdateMember]){
        if(_viewModel){
            [_viewModel requestMemberDatas];
        }
        return;
    }
}


-(void)onShowWarnPrompt:(MemberModel *)model{
    WS(weakSelf)
    [STAlertUtil showAlertController:MSG_WARN content:MSG_MEMBER_DELETE_TIPS controller:self confirm:^{
        [weakSelf.viewModel deleteMember:model];
    }];
}


@end
