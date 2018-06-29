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

@interface MessagePage ()<MessageViewDelegate,STObserverProtocol>

@property(strong, nonatomic)MessageView *messageView;

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
    [[STObserverManager sharedSTObserverManager] registerSTObsever:Notify_MESSAGE_AGREE delegate:self];
    [[STObserverManager sharedSTObserverManager] registerSTObsever:Notify_MESSAGE_REJECT delegate:self];

}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setStatuBarBackgroud:cwhite];
}


-(void)dealloc{
    [[STObserverManager sharedSTObserverManager] removeSTObsever:Notify_MESSAGE_AGREE];
    [[STObserverManager sharedSTObserverManager] removeSTObsever:Notify_MESSAGE_REJECT];
}

-(void)initView{
    MessageViewModel *viewModel = [[MessageViewModel alloc]init];
    viewModel.delegate = self;

    _messageView = [[MessageView alloc]initWithViewModel:viewModel];
    _messageView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    _messageView.backgroundColor = c15;
    [self.view addSubview:_messageView];
}

-(void)onGoSystemPage{
    [SystemMsgPage show:self];
}

-(void)onGoPropertyPage{
    [PropertyMsgPage show:self];
}

-(void)onGoMessageDetailPage:(MessageModel *)model{
    if(model.messageType == UserAuth){
        [VerificateUserPage show:self model:model];
    }else if(model.messageType == CarEnter || model.messageType == VisitorEnter){
        [EnterAuthPage show:self model:model];
    }
}

-(void)onReciveResult:(NSString *)key msg:(id)msg{
    if([key isEqualToString:Notify_MESSAGE_AGREE]){
        MessageModel *model = msg;
        if(_messageView){
            [_messageView onAgreeCallback:model];
        }
    }
    else if([key isEqualToString:Notify_MESSAGE_REJECT]){
        MessageModel *model = msg;
        if(_messageView){
            [_messageView onRejectCallback:model];
        }
    }
}

-(void)onDataChange{
    if(_messageView){
        [_messageView updateView];
    }
}

@end
