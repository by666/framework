//
//  PassPage.m
//  framework
//
//  Created by 黄成实 on 2018/6/27.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "PassPage.h"
#import "PassView2.h"
#import "PassViewModel.h"
#import "STObserverManager.h"
#import "VisitorPage.h"
#import "PassHistoryPage.h"
#import "WeChatManager.h"
#import "STConvertUtil.h"
@interface PassPage ()<PassViewDelegate>

@property(strong, nonatomic)PassView2 *passView;
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
    
    _passView = [[PassView2 alloc]initWithViewModel:_mPassViewModel];
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

-(void)onDoShare:(VisitorModel *)visitorModel passModel:(PassModel *)passModel{
    NSString *name = visitorModel.name;
    NSString *carnum = visitorModel.carNum;
    NSString *date = visitorModel.visitDate;
    NSString *code = passModel.password;
    
    NSString *title =  [NSString stringWithFormat:@"【智慧家】您的开锁码为：%@",code];
    NSString *url = nil;
    if(IS_NS_STRING_EMPTY(visitorModel.faceUrl)){
        if(IS_NS_STRING_EMPTY(carnum)){
            url = [NSString stringWithFormat:@"http://www.santaihulian.com/share.html?name=%@&date=%@&code=%@",name,date,code];
        }else{
            url = [NSString stringWithFormat:@"http://www.santaihulian.com/share.html?name=%@&carnum=%@&date=%@&code=%@",name,carnum,date,code];
        }
    }else{
        NSString *head = [[STUploadImageUtil sharedSTUploadImageUtil]getRealUrl2:visitorModel.faceUrl];
        head = [STConvertUtil base64Encode:head];
        if(IS_NS_STRING_EMPTY(carnum)){
            url = [NSString stringWithFormat:@"http://www.santaihulian.com/share.html?name=%@&date=%@&code=%@&head=%@",name,date,code,head];
        }else{
            url = [NSString stringWithFormat:@"http://www.santaihulian.com/share.html?name=%@&carnum=%@&date=%@&code=%@&head=%@",name,carnum,date,code,head];
        }
    }
    
    [[WeChatManager sharedWeChatManager]doShare:title content:@"这里是分享内容" image:[UIImage imageNamed:@"ic_head"] url:url controller:self];
    
}


- (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength {
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return image;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    if (data.length < maxLength) return resultImage;
    
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    
    return resultImage;
}



@end
