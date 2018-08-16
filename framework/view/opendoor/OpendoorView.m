//
//  OpendoorView.m
//  framework
//
//  Created by 黄成实 on 2018/6/6.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "OpendoorView.h"
#import <ZBarSDK/ZBarSDK.h>
#import "LBXScanViewStyle.h"
#import "LBXScanViewController.h"
#import "STUserDefaults.h"
#import "STTimeUtil.h"

@interface OpendoorView()

@property(strong, nonatomic)OpendoorViewModel *mViewModel;
@property(strong, nonatomic)UIView *qrCodeView;
@property(strong, nonatomic)UILabel *tipsLabel;
@property(strong, nonatomic)UIButton *openBtn;
@property(strong, nonatomic)UILabel *codeLabel;

@end

@implementation OpendoorView

-(instancetype)initWithViewModel:(OpendoorViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    
    _tipsLabel = [[UILabel alloc]initWithFont:STFont(14) text:MSG_OPENDOOR_TIPS textAlignment:NSTextAlignmentCenter textColor:c12 backgroundColor:nil multiLine:NO];
    _tipsLabel.frame = CGRectMake(0, STHeight(55), ScreenWidth, STHeight(14));
    [self addSubview:_tipsLabel];
    
    _openBtn = [[UIButton alloc]initWithFont:STFont(16) text:MSG_OPENDOOR_BTN textColor:cwhite backgroundColor:c08 corner:STHeight(25) borderWidth:0 borderColor:nil];
    [_openBtn setBackgroundColor:c19a forState:UIControlStateHighlighted];
    _openBtn.frame = CGRectMake(STWidth(112.5), ContentHeight - STHeight(130), STWidth(152), STHeight(50));
    [_openBtn addTarget:self action:@selector(onClickOpenBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_openBtn];
    
    
    [self addSubview:[self qrCodeView]];
    [self buildQRCodeView];
    
    NSString *dateStr =[STTimeUtil generateDate_CH:[STTimeUtil getCurrentTimeStamp]];
    if([dateStr isEqualToString:[STUserDefaults getKeyValue:@"opendoor"]]){
        NSString *codeStr = [STUserDefaults getKeyValue:@"opencode"];
        _codeLabel.text = codeStr;
        [self onGenerateTempLock:codeStr];
    }
    
}


-(UIView *)qrCodeView{
    if(_qrCodeView == nil){
        _qrCodeView = [[UIView alloc]init];
        _qrCodeView.frame = CGRectMake(0, 0, ScreenWidth, ContentHeight);
        _qrCodeView.hidden = YES;
    }
    return _qrCodeView;
}


-(void)buildQRCodeView{
    
    UIImage *qrCodeImage = [LBXScanNative createQRWithString:@"滴~老年卡" QRSize:CGSizeMake(1024,1024)];
    UIImageView *qrCodeImageView = [[UIImageView alloc]init];
    qrCodeImageView.frame = CGRectMake(STWidth(99), STHeight(74), STWidth(178), STHeight(178));
    qrCodeImageView.backgroundColor = cwhite;
    qrCodeImageView.image = qrCodeImage;
    qrCodeImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_qrCodeView addSubview:qrCodeImageView];
    
    
    UILabel *lockCodeLabel = [[UILabel alloc]initWithFont:STFont(17) text:MSG_OPENDOOR_LOCKCODE textAlignment:NSTextAlignmentCenter textColor:c12 backgroundColor:nil multiLine:NO];
    lockCodeLabel.frame = CGRectMake(0, STHeight(273), ScreenWidth, STHeight(17));
    [_qrCodeView addSubview:lockCodeLabel];
    
    
    NSString *codeStr = [NSString stringWithFormat:@"* %d %d %d %d %d",arc4random() % 5,arc4random() % 5,arc4random() % 5,arc4random() % 5,arc4random() % 5]  ;
    _codeLabel = [[UILabel alloc]initWithFont:STFont(17) text:codeStr textAlignment:NSTextAlignmentCenter textColor:c12 backgroundColor:nil multiLine:NO];
    _codeLabel.frame = CGRectMake(0, STHeight(300), ScreenWidth, STHeight(17));
    [_codeLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:STFont(17)]];
    [_qrCodeView addSubview:_codeLabel];
    
    UIButton *shareBtn = [[UIButton alloc]initWithFont:STFont(16) text:MSG_OPENDOOR_SHAREBTN textColor:cwhite backgroundColor:c08 corner:STHeight(25) borderWidth:0 borderColor:nil];
    shareBtn.frame = CGRectMake(STWidth(112.5), ContentHeight - STHeight(130), STWidth(152), STHeight(50));
    [shareBtn addTarget:self action:@selector(onClickShareBtn) forControlEvents:UIControlEventTouchUpInside];
    [_qrCodeView addSubview:shareBtn];
    
    UILabel *tipsLabel = [[UILabel alloc]initWithFont:STFont(12) text:MSG_OPENDOOR_LOCKCODE_TIPS textAlignment:NSTextAlignmentCenter textColor:c12 backgroundColor:nil multiLine:YES];
    CGSize tipsSize = [MSG_OPENDOOR_LOCKCODE_TIPS sizeWithMaxWidth:(STWidth(300)) font:[UIFont systemFontOfSize:STFont(12)]];
    tipsLabel.frame = CGRectMake((ScreenWidth - STWidth(300))/2, ContentHeight - STHeight(30) - tipsSize.height, STWidth(300), tipsSize.height);
    [_qrCodeView addSubview:tipsLabel];
}

-(void)onClickOpenBtn{
    if(_mViewModel){
        [_mViewModel generateTempLock];
    }
}

-(void)onGenerateTempLock:(NSString *)codeStr{
    _codeLabel.text = codeStr;
    _tipsLabel.hidden = YES;
    _openBtn.hidden = YES;
    _qrCodeView.hidden = NO;
}

-(void)onClickShareBtn{
    if(_mViewModel){
        [_mViewModel doShare:_codeLabel.text];
    }
}


@end
