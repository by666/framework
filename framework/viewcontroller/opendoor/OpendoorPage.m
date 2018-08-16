//
//  OpendoorPage.m
//  framework
//
//  Created by 黄成实 on 2018/6/6.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "OpendoorPage.h"
#import "OpendoorView.h"
#import "WeChatManager.h"
#import "STTimeUtil.h"
#import "AccountManager.h"
#import "STConvertUtil.h"

@interface OpendoorPage ()<OpendoorViewDelegate>

@property(strong, nonatomic)OpendoorView *opendoorView;

@end

@implementation OpendoorPage

+(void)show:(BaseViewController *)controller{
    OpendoorPage *page = [[OpendoorPage alloc]init];
    [controller pushPage:page];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = cwhite;
    [self showSTNavigationBar:MSG_OPENDOOR_TITLE needback:YES];
    [self initView];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setStatuBarBackgroud:cwhite];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}


-(void)initView{
    OpendoorViewModel *viewModel = [[OpendoorViewModel alloc]init];
    viewModel.delegate = self;
    
    _opendoorView = [[OpendoorView alloc]initWithViewModel:viewModel];
    _opendoorView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    _opendoorView.backgroundColor = cwhite;
    [self.view addSubview:_opendoorView];
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
    [_opendoorView onGenerateTempLock:data];
}



-(void)onDoShare:(NSString *)codeStr{
    
    UserModel *userModel = [[AccountManager sharedAccountManager]getUserModel];
    NSString *name = userModel.userName;
    NSString *date = [STTimeUtil generateDate_EN:[STTimeUtil getCurrentTimeStamp]];
    NSString *code = codeStr;
    NSString *head = [[STUploadImageUtil sharedSTUploadImageUtil]getRealUrl2:userModel.headUrl];
    head = [STConvertUtil base64Encode:head];
    NSString *title =  [NSString stringWithFormat:@"【智慧家】您的开锁码为：%@",codeStr];
    UIImage *image = [UIImage imageNamed:@"ic_head"];
    NSString *url = [NSString stringWithFormat:@"http://www.santaihulian.com/share.html?name=%@&date=%@&code=%@&head=%@",name,date,code,head];
    [[WeChatManager sharedWeChatManager]doShare:title content:@"" image:image url:url controller:self];
    
}
@end

