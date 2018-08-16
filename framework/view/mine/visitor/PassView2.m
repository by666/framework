//
//  PassView2.m
//  framework
//
//  Created by 黄成实 on 2018/8/9.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "PassView2.h"
#import <ZBarSDK/ZBarSDK.h>
#import "LBXScanViewStyle.h"
#import "LBXScanViewController.h"
#import "AccountManager.h"
#import "STTimeUtil.h"

@interface PassView2()

@property(strong, nonatomic)PassViewModel *mViewModel;
@property(strong, nonatomic)UIView *cardView;
@property(strong, nonatomic)UIView *bottomView;
@property(strong, nonatomic)UIView *bigQrCodeView;
@end

@implementation PassView2

-(instancetype)initWithViewModel:(PassViewModel *)viewModel{
    if(self ==[super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    self.backgroundColor = c08;
    
    NSString *nameStr = [NSString stringWithFormat:MSG_PASSVIEW_NAME,_mViewModel.mVisitorModel.name];
    UILabel *nameLabel = [[UILabel alloc]initWithFont:STFont(24) text:nameStr textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    CGSize nameSize = [nameStr sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(24)]];
    nameLabel.frame = CGRectMake(STWidth(35), STHeight(33), nameSize.width, STHeight(24));
    [self addSubview:nameLabel];
    
    NSString *dateStr = [NSString stringWithFormat:MSG_PASSVIEW_DATE,_mViewModel.mVisitorModel.visitDate];
    UILabel *dateLabel = [[UILabel alloc]initWithFont:STFont(14) text:dateStr textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    CGSize dateSize = [dateStr sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(14)]];
    dateLabel.frame = CGRectMake(STWidth(35), STHeight(69), dateSize.width, STHeight(14));
    [self addSubview:dateLabel];
    
    
    
    //cardview
    _cardView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(27), STHeight(130), STWidth(322), STHeight(344))];
    _cardView.backgroundColor = cwhite;
    _cardView.layer.masksToBounds = YES;
    _cardView.layer.cornerRadius = STHeight(4);
    [self addSubview:_cardView];
    
    
  
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(251), STWidth(322), STHeight(93))];
    _bottomView.backgroundColor = c37;
    [_cardView addSubview:_bottomView];
    
    UILabel *codeTitleLabel = [[UILabel alloc]initWithFont:STFont(14) text:@"" textAlignment:NSTextAlignmentCenter textColor:c20 backgroundColor:nil multiLine:NO];
    [_bottomView addSubview:codeTitleLabel];
    
 
    NSString *codeStr = _mViewModel.mPassModel.password;
    NSString *qrCodeStr = codeStr;
    UIImage *qrCodeImage = [LBXScanNative createQRWithString:qrCodeStr QRSize:CGSizeMake(1024,1024)];
    
    _cardView.clipsToBounds = YES;
    

    NSString *tipsTxt = @"";
    NSString *mycodeTxt = @"";
    if(!IS_NS_STRING_EMPTY(_mViewModel.mVisitorModel.faceUrl)){
        mycodeTxt = MSG_PASSVIEW_MYFACE;
        tipsTxt = MSG_PASSVIEW_TIPS2;
        codeTitleLabel.text = MSG_PASSVIEW_OTHER;
        codeTitleLabel.frame = CGRectMake(0, STHeight(11), STWidth(322), STHeight(14));
        
        [self setHasFaceCardView:codeStr image:qrCodeImage];

    }else{
        mycodeTxt = MSG_PASSVIEW_MYQRCODE;
        tipsTxt = MSG_PASSVIEW_TIPS;
        codeTitleLabel.text = MSG_PASSVIEW_LOCKCODE;
        codeTitleLabel.frame = CGRectMake(0, STHeight(25), STWidth(322), STHeight(14));

        [self setNoFaceCardView:codeStr image:qrCodeImage];
        
    }
    
    UILabel *mycodeLabel = [[UILabel alloc]initWithFont:STFont(17) text:mycodeTxt textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    mycodeLabel.frame = CGRectMake(0, STHeight(33), STWidth(322), STHeight(17));
    [_cardView addSubview:mycodeLabel];
    
    UILabel *tipsLabel = [[UILabel alloc]initWithFont:STFont(12) text:tipsTxt textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:YES];
    CGSize tipSize = [tipsTxt sizeWithMaxWidth:ScreenWidth - STWidth(120) font:[UIFont systemFontOfSize:STFont(12)]];
    tipsLabel.frame = CGRectMake(STWidth(60), STHeight(508), ScreenWidth - STWidth(120), tipSize.height);
    [self addSubview:tipsLabel];
    
    [self initBigQrCodeView:qrCodeImage];
    
    NSString *btnStr = MSG_PASSVIEW_SHAREBTN;
    if(![self isVaildDate]){
        self.backgroundColor = c38;
        btnStr = MSG_PASSVIEW_REGENERATEBTN;
        
        UIImageView *invalidImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(260), STHeight(10), STWidth(50), STHeight(40))];
        invalidImageView.image = [UIImage imageNamed:@"ic_invalid"];
        invalidImageView.contentMode = UIViewContentModeScaleAspectFill;
        [_cardView addSubview:invalidImageView];
        
        UIView *layerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0 ,ScreenWidth, ContentHeight)];
        layerView.backgroundColor = c38a;
        [self addSubview:layerView];
        
    }
 
    
    UIButton *shareBtn = [[UIButton alloc]initWithFont:STFont(16) text:btnStr textColor:c08 backgroundColor:cwhite corner:STHeight(25) borderWidth:0 borderColor:nil];
    shareBtn.frame = CGRectMake(ScreenWidth - STWidth(151), STHeight(32), STWidth(136), STHeight(50));
    [shareBtn addTarget:self action:@selector(onClickShareBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:shareBtn];
    

}

-(void)setHasFaceCardView:(NSString *)codeStr image:(UIImage *)qrCodeImage{
    UIImageView *faceImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(106), STHeight(75) + STWidth(10), STWidth(110), STWidth(110))];
    faceImageView.layer.masksToBounds = YES;
    faceImageView.layer.cornerRadius = STHeight(10);
    NSURL *url = [[STUploadImageUtil sharedSTUploadImageUtil]getRealUrl:_mViewModel.mVisitorModel.faceUrl];
    [faceImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"ic_head"]];
    faceImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_cardView addSubview:faceImageView];
    
    UIImageView *layerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(96), STHeight(75), STWidth(130), STWidth(130))];
    layerImageView.image = [UIImage imageNamed:@"访客登记_icon_人脸识别"];
    layerImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_cardView addSubview:layerImageView];
    
    
    UILabel *codeLabel = [[UILabel alloc]initWithFont:STFont(16) text:codeStr textAlignment:NSTextAlignmentLeft textColor:c20 backgroundColor:nil multiLine:NO];
    CGSize codeSize = [codeStr sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    codeLabel.frame = CGRectMake(STWidth(50), STHeight(40), codeSize.width, STHeight(16));
    [_bottomView addSubview:codeLabel];
    
    
    UILabel *codeTitleLabel = [[UILabel alloc]initWithFont:STFont(12) text:MSG_PASSVIEW_LOCKCODE textAlignment:NSTextAlignmentLeft textColor:c20 backgroundColor:nil multiLine:NO];
    CGSize codeTitleSize = [MSG_PASSVIEW_LOCKCODE sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(12)]];
    codeTitleLabel.frame = CGRectMake(STWidth(60), STHeight(66), codeTitleSize.width, STHeight(12));
    [_bottomView addSubview:codeTitleLabel];
    
    
    UIButton *qrCodeImageView = [[UIButton alloc]initWithFrame:CGRectMake(STWidth(243),STHeight(35), STWidth(24), STWidth(24))];
    [qrCodeImageView setImage:qrCodeImage forState:UIControlStateNormal];
    qrCodeImageView.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_bottomView addSubview:qrCodeImageView];
    
    [qrCodeImageView addTarget:self action:@selector(onClickQrCode) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UILabel *qrcodeLabel = [[UILabel alloc]initWithFont:STFont(12) text:MSG_PASSVIEW_QRCODE textAlignment:NSTextAlignmentLeft textColor:c20 backgroundColor:nil multiLine:NO];
    CGSize qrcodeSize = [MSG_PASSVIEW_QRCODE sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(12)]];
    qrcodeLabel.frame = CGRectMake(STWidth(236), STHeight(66), qrcodeSize.width, STHeight(12));
    [_bottomView addSubview:qrcodeLabel];
    
    

}

-(void)initBigQrCodeView:(UIImage *)qrcodeImage{
    _bigQrCodeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ContentHeight)];
    _bigQrCodeView.hidden = YES;
    _bigQrCodeView.backgroundColor = [cblack colorWithAlphaComponent:0.8f];
    [self addSubview:_bigQrCodeView];
    
    UITapGestureRecognizer *recongnizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickBigQrCodeView)];
    [_bigQrCodeView addGestureRecognizer:recongnizer];
    
    UIImageView *bigImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(60), (STHeight(344) - STWidth(250))/2 + STHeight(130), STWidth(250), STWidth(250))];
    bigImageView.image =qrcodeImage;
    bigImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_bigQrCodeView addSubview:bigImageView];

}

-(void)setNoFaceCardView:(NSString *)codeStr image:(UIImage *)qrCodeImage{
    
    UIButton *qrCodeImageView = [[UIButton alloc]initWithFrame:CGRectMake(STWidth(96), STHeight(75), STWidth(130), STWidth(130))];
    [qrCodeImageView setImage:qrCodeImage forState:UIControlStateNormal];
    qrCodeImageView.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_cardView addSubview:qrCodeImageView];
    
    [qrCodeImageView addTarget:self action:@selector(onClickQrCode) forControlEvents:UIControlEventTouchUpInside];

    
    UILabel *codeLabel = [[UILabel alloc]initWithFont:STFont(16) text:codeStr textAlignment:NSTextAlignmentCenter textColor:c20 backgroundColor:nil multiLine:NO];
    codeLabel.frame = CGRectMake(0, STHeight(53), STWidth(322), STHeight(16));
    [_bottomView addSubview:codeLabel];
    
}



-(Boolean)isVaildDate{
    long nowTimeStamp = [[STTimeUtil getCurrentTimeStamp] longLongValue] / 1000;
    NSString *formatDateStr = [NSString stringWithFormat:@"%@ 23:59:59",_mViewModel.mVisitorModel.visitDate];
    long visitTimeStamp = [STTimeUtil getTimeStamp:formatDateStr format:@"yyyy.MM.dd HH:mm:ss"];
    if(visitTimeStamp - nowTimeStamp >= 0){
        return YES;
    }
    return NO;
}


-(void)onClickShareBtn{
    if(_mViewModel){
        if([self isVaildDate]){
            [_mViewModel doShare];
        }else{
            [_mViewModel goVisitorPage];
        }
    }
}

-(void)onClickQrCode{
    _bigQrCodeView.hidden = NO;
}

-(void)onClickBigQrCodeView{
    _bigQrCodeView.hidden = YES;
}

@end
