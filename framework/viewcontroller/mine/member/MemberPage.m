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
@interface MemberPage ()<MemberViewDelegate,STObserverProtocol>

@property(strong, nonatomic)MemberView *memberView;
@property(strong, nonatomic)MemberViewModel *viewModel;
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
}

-(void)dealloc{
    [[STObserverManager sharedSTObserverManager]removeSTObsever:Notify_AddMember];
    [[STObserverManager sharedSTObserverManager]removeSTObsever:Notify_DeleteMember];
    [[STObserverManager sharedSTObserverManager]removeSTObsever:Notify_UpdateMember];
}


-(UIView *)memberView{
    if(_memberView == nil){
        _viewModel = [[MemberViewModel alloc]init];
        _viewModel.delegate = self;
        _memberView = [[MemberView alloc]initWithViewModel:_viewModel];
        _memberView.backgroundColor = cwhite;
        _memberView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight + STHeight(10), ScreenWidth, ContentHeight-STHeight(10));
    }
    return _memberView;
}

-(void)initView{
    [self.view addSubview:[self memberView]];
    if(_viewModel){
        [_viewModel requestMemberDatas];
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
    if([key isEqualToString:Notify_AddMember] || [key isEqualToString:Notify_DeleteMember] || [key isEqualToString:Notify_UpdateMember]){
        if(_viewModel){
            [_viewModel requestMemberDatas];
        }
    }
}


-(void)onShowWarnPrompt:(MemberModel *)model{
    WS(weakSelf)
    [STAlertUtil showAlertController:MSG_WARN content:MSG_MEMBER_DELETE_TIPS controller:self confirm:^{
        [weakSelf.viewModel deleteMember:model];
    }];
}


@end
