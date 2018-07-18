//
//  PassPage.m
//  framework
//
//  Created by 黄成实 on 2018/6/27.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "PassPage.h"
#import "PassView.h"
#import "PassViewModel.h"
#import "STObserverManager.h"
#import "VisitorPage.h"
#import "PassHistoryPage.h"
@interface PassPage ()<PassViewDelegate>

@property(strong, nonatomic)PassView *passView;
@property(strong, nonatomic)PassModel *mPassModel;
@property(strong, nonatomic)VisitorModel *mVisitorModel;
@property(strong, nonatomic)PassViewModel *mPassViewModel;
@property(assign, nonatomic)Boolean needDelete;

@end

@implementation PassPage

+(void)show:(BaseViewController *)controller passModel:(PassModel*)passModel visitorModel:(VisitorModel *)visitorModel needDelete:(Boolean)needDelete{
    PassPage *page = [[PassPage alloc]init];
    page.mPassModel = passModel;
    page.mVisitorModel = visitorModel;
    page.needDelete = needDelete;
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = cwhite;
    WS(weakSelf)
    if(_needDelete){
        [self showSTNavigationBar:MSG_PASSPAGE_TITLE needback:YES rightBtn:MSG_DELETE block:^{
            [weakSelf showWarnDialog];
        }];
    }else{
        [self showSTNavigationBar:MSG_PASSPAGE_TITLE needback:YES];
    }

    [self initView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setStatuBarBackgroud:cwhite];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}


-(void)initView{
    _mPassViewModel = [[PassViewModel alloc]init];
    _mPassViewModel.mPassModel = _mPassModel;
    _mPassViewModel.mVisitorModel = _mVisitorModel;
    _mPassViewModel.delegate = self;
    
    _passView = [[PassView alloc]initWithViewModel:_mPassViewModel];
    _passView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    [self.view addSubview:_passView];
}

-(void)showWarnDialog{
    WS(weakSelf)
    [STAlertUtil showAlertController:MSG_PROMPT content:MSG_PASSPAGE_DELETE_TIPS controller:self confirm:^{
        [weakSelf.mPassViewModel deletePass:weakSelf.mPassModel.userUid checkId:weakSelf.mPassModel.checkId];
    }];
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
    [[STObserverManager sharedSTObserverManager]sendMessage:Notify_DeleteCheck msg:nil];
    [self backLastPage];
}

-(void)onGoVisitorPage:(VisitorModel *)visitorModel{
    if(IS_NS_STRING_EMPTY(visitorModel.carNum)){
        [VisitorPage show:self type:People model:visitorModel];
    }else{
        [VisitorPage show:self type:Car model:visitorModel];
    }
}

-(void)backLastPage{
    if(_needDelete){
        [super backLastPage];
    }else{
        [PassHistoryPage show:self backHome:YES];
    }
}
@end
