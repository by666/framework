//
//  PassView.m
//  framework
//
//  Created by by.huang on 2018/5/23.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "PassView.h"
#import <ZBarSDK/ZBarSDK.h>
#import "LBXScanViewStyle.h"
#import "LBXScanViewController.h"
#import "AccountManager.h"
#import "STTimeUtil.h"
#import "VisitorPage.h"

@interface PassView()

@property(strong, nonatomic)PassViewModel *mViewModel;

@end

@implementation PassView

-(instancetype)initWithViewModel:(PassViewModel *)viewModel{
    if(self ==[super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    self.backgroundColor = cwhite;
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, STHeight(137))];
    topView.backgroundColor = c25;
    [self addSubview:topView];
    

    UIImageView *avatarImageView = [[UIImageView alloc]init];
    avatarImageView.frame = CGRectMake(STWidth(280), STHeight(38), STWidth(60), STHeight(60));
    avatarImageView.backgroundColor = cwhite;
    avatarImageView.layer.masksToBounds = YES;
    avatarImageView.layer.cornerRadius = STHeight(8);
    avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:avatarImageView];
    
    
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
    
    
    NSString *carNumStr = [NSString stringWithFormat:MSG_PASSVIEW_CARNUM,_mViewModel.mVisitorModel.carNum];
    UILabel *carNumLabel = [[UILabel alloc]initWithFont:STFont(14) text:carNumStr textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    CGSize carNumSize = [carNumStr sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(14)]];
    carNumLabel.frame = CGRectMake(STWidth(35), STHeight(89), carNumSize.width, STHeight(14));
    [self addSubview:carNumLabel];
    
    
    if(!IS_NS_STRING_EMPTY(_mViewModel.mVisitorModel.faceUrl)){
        NSURL *url = [[STUploadImageUtil sharedSTUploadImageUtil]getRealUrl:_mViewModel.mVisitorModel.faceUrl];
        [avatarImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"ic_head"]];
        avatarImageView.hidden = NO;
        if(IS_NS_STRING_EMPTY(_mViewModel.mVisitorModel.carNum)){
            carNumLabel.hidden = YES;
            nameLabel.frame = CGRectMake(STWidth(35), STHeight(40), nameSize.width, STHeight(24));
            dateLabel.frame = CGRectMake(STWidth(35), STHeight(76), dateSize.width, STHeight(14));
        }
        else{
            carNumLabel.hidden = NO;
            nameLabel.frame = CGRectMake(STWidth(35), STHeight(33), nameSize.width, STHeight(24));
            dateLabel.frame = CGRectMake(STWidth(35), STHeight(69), dateSize.width, STHeight(14));
            carNumLabel.frame = CGRectMake(STWidth(35), STHeight(89), carNumSize.width, STHeight(14));
        }
    }else{
        avatarImageView.hidden = YES;
        if(IS_NS_STRING_EMPTY(_mViewModel.mVisitorModel.carNum)){
            carNumLabel.hidden = YES;
            nameLabel.frame = CGRectMake(0, STHeight(40), ScreenWidth, STHeight(24));
            dateLabel.frame = CGRectMake(0, STHeight(76), ScreenWidth, STHeight(14));
        }else{
            carNumLabel.hidden = NO;
            nameLabel.frame = CGRectMake(0, STHeight(33), ScreenWidth, STHeight(24));
            dateLabel.frame = CGRectMake(0, STHeight(69), ScreenWidth, STHeight(14));
            carNumLabel.frame = CGRectMake(0, STHeight(89), ScreenWidth, STHeight(14));
            
        }
    }
    
    
    
    UserModel *userModel = [[AccountManager sharedAccountManager]getUserModel];
    NSString *qrCodeStr = [NSString stringWithFormat:@"%@&%@",userModel.userUid,_mViewModel.mPassModel.userUid];
    UIImage *qrCodeImage = [LBXScanNative createQRWithString:qrCodeStr QRSize:CGSizeMake(1024,1024)];
    UIImageView *qrCodeImageView = [[UIImageView alloc]init];
    qrCodeImageView.frame = CGRectMake(STWidth(99), STHeight(181), STWidth(178), STHeight(178));
    qrCodeImageView.backgroundColor = cwhite;
    qrCodeImageView.image = qrCodeImage;
    qrCodeImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:qrCodeImageView];
    
    
    UILabel *lockCodeLabel = [[UILabel alloc]initWithFont:STFont(18) text:MSG_PASSVIEW_LOCKCODE textAlignment:NSTextAlignmentCenter textColor:c20 backgroundColor:nil multiLine:NO];
    lockCodeLabel.frame = CGRectMake(0, STHeight(368), ScreenWidth, STHeight(18));
    [self addSubview:lockCodeLabel];
    
    
    NSString *codeStr = @"";
    for(int i = 0 ; i < _mViewModel.mPassModel.password.length ; i++){
        NSString *codeChar = [_mViewModel.mPassModel.password substringWithRange:NSMakeRange(i, 1)];
        codeStr = [codeStr stringByAppendingString:codeChar];
        codeStr = [codeStr stringByAppendingString:@" "];
    }
    codeStr = [codeStr substringWithRange:NSMakeRange(0, codeStr.length - 1)];
    UILabel *codeLabel = [[UILabel alloc]initWithFont:STFont(18) text:codeStr textAlignment:NSTextAlignmentCenter textColor:c25 backgroundColor:nil multiLine:NO];
    codeLabel.frame = CGRectMake(0, STHeight(396), ScreenWidth, STHeight(18));
    [codeLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:STFont(18)]];
    [self addSubview:codeLabel];
    
    NSString *tipsStr = [NSString stringWithFormat:MSG_PASSVIEW_TIPS,_mViewModel.mVisitorModel.name];
    UILabel *tipsLabel = [[UILabel alloc]initWithFont:STFont(12) text:tipsStr textAlignment:NSTextAlignmentCenter textColor:c12 backgroundColor:nil multiLine:YES];
    CGSize tipSize = [tipsStr sizeWithMaxWidth:ScreenWidth - STWidth(138) font:[UIFont systemFontOfSize:STFont(12)]];
    tipsLabel.frame = CGRectMake(STWidth(69), STHeight(427), ScreenWidth - STWidth(138), tipSize.height);
    [self addSubview:tipsLabel];
    
    
    if([self isVaildDate]){
        UIButton *shareBtn = [[UIButton alloc]initWithFont:STFont(14) text:MSG_PASSVIEW_SHAREBTN textColor:cwhite backgroundColor:c23 corner:STHeight(8) borderWidth:0 borderColor:nil];
        shareBtn.frame = CGRectMake(STWidth(127), STHeight(478), ScreenWidth- STWidth(254), STHeight(38));
        [shareBtn addTarget:self action:@selector(onClickShareBtn) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:shareBtn];
    }else{
        
        topView.backgroundColor = c12;
        UILabel *invalidLabel = [[UILabel alloc]initWithFont:STFont(14) text:MSG_PASSVIEW_INVAILD textAlignment:NSTextAlignmentCenter textColor:c18 backgroundColor:nil multiLine:NO];
        invalidLabel.frame = CGRectMake(0, STHeight(475), ScreenWidth, STHeight(14));
        [self addSubview:invalidLabel];
        
        UIButton *reGenerateBtn = [[UIButton alloc]initWithFont:STFont(14) text:MSG_PASSVIEW_REGENERATEBTN textColor:cwhite backgroundColor:c21 corner:STHeight(8) borderWidth:0 borderColor:nil];
        reGenerateBtn.frame = CGRectMake(STWidth(127), STHeight(504), ScreenWidth- STWidth(254), STHeight(38));
        [reGenerateBtn addTarget:self action:@selector(onClickGenerateBtn) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:reGenerateBtn];
        
        lockCodeLabel.textColor = [c20 colorWithAlphaComponent:0.33f];
        codeLabel.textColor = [c20 colorWithAlphaComponent:0.33f];
        
        UIImageView *invalidImageView = [[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth - STWidth(61))/2, STHeight(380), STWidth(61), STHeight(38))];
        invalidImageView.image = [UIImage imageNamed:@"ic_invalid"];
        [self addSubview:invalidImageView];
        
        qrCodeImageView.alpha = 0.33f;
    }
    
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
    
}

-(void)onClickGenerateBtn{
    if(_mViewModel){
        [_mViewModel goVisitorPage];
    }
}






@end
