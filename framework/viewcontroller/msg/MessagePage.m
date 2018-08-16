//
//  MessagePage.m
//  framework
//
//  Created by 黄成实 on 2018/5/29.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MessagePage.h"
#import "MessageView.h"
#import "EnterAuthPage.h"
#import "VerificateUserPage.h"
#import "STObserverManager.h"
#import "SystemMsgPage.h"
#import "PropertyMsgPage.h"
#import "AuthUserPage.h"

@interface MessagePage ()<MessageViewDelegate,STObserverProtocol>

@property(strong, nonatomic)MessageView *messageView;
@property(strong, nonatomic)MessageViewModel *viewModel;

@end

@implementation MessagePage

+(void)show:(BaseViewController *)controller{
    MessagePage *page = [[MessagePage alloc]init];
    [controller pushPage:page];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = c15;
    [self showSTNavigationBar:MSG_MESSAGE_TITLE needback:YES];
    [self initView];
    [[STObserverManager sharedSTObserverManager] registerSTObsever:Notify_Message_Statu_Change delegate:self];

}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setStatuBarBackgroud:cwhite];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}


-(void)dealloc{
    [[STObserverManager sharedSTObserverManager] removeSTObsever:Notify_Message_Statu_Change];
}

-(void)initView{
    _viewModel = [[MessageViewModel alloc]init];
    _viewModel.delegate = self;

    _messageView = [[MessageView alloc]initWithViewModel:_viewModel];
    _messageView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    _messageView.backgroundColor = c15;
    [self.view addSubview:_messageView];
    
    if(_viewModel){
        [_viewModel requestMessageList:NO];
    }
    
}

-(void)onGoSystemPage{
    [SystemMsgPage show:self];
}

-(void)onGoPropertyPage{
    [PropertyMsgPage show:self];
}

-(void)onGoMessageDetailPage:(MessageModel *)model{
    MessageType type = [MessageModel translateType:model.applyType];
    if(type == UserAuth){
        [VerificateUserPage show:self model:model];
    }else if(type == CarEnter || type == VisitorEnter){
        [EnterAuthPage show:self model:model];
    }
}


#pragma mark 接收到消息状态变化
-(void)onReciveResult:(NSString *)key msg:(id)msg{
    if([key isEqualToString:Notify_Message_Statu_Change]){
        MessageModel *model = msg;
        if(_viewModel){
            if(model.applyState == Granted){
                [_viewModel doAgree:model];
            }else if(model.applyState == Reject){
                [_viewModel doReject:model];
            }
        }
    }
 
}


#pragma mark 网络请求回调
-(void)onRequestBegin{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if(_messageView){
        [_messageView updateView:[data boolValue]];
    }

}

-(void)onRequestFail:(NSString *)msg{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if(!IS_NS_STRING_EMPTY(msg)){
        [STToastUtil showFailureAlertSheet:msg];
    }
    if(_messageView){
        [_messageView updateView:NO];
    }
}


#pragma mark 数据变化，更新UI
-(void)onDataChange{
    if(_messageView){
        [_messageView updateView:YES];
    }
}

-(void)onGoAuthUserPage{
    [AuthUserPage show:self];
}



@end
