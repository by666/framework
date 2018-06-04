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

@interface PassView()

@property(strong, nonatomic)VisitorViewModel *mViewModel;

@end

@implementation PassView

-(instancetype)initWithFrame:(CGRect)frame model:(VisitorViewModel *)model{
    if(self ==[super initWithFrame:frame]){
        _mViewModel = model;
        self.frame = frame;
        [self initView];
    }
    return self;
}

-(void)initView{
    self.backgroundColor = [cblack colorWithAlphaComponent:0.65];
    
    UIView *cardView = [[UIView alloc]init];
    cardView.frame = CGRectMake(STWidth(28), STHeight(26), ScreenWidth - STWidth(56), STHeight(508));
    cardView.backgroundColor = cwhite;
    cardView.layer.masksToBounds = YES;
    cardView.layer.cornerRadius = STHeight(4);
    [self addSubview:cardView];
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, cardView.width, STHeight(139))];
    topView.backgroundColor = c25;
    [cardView addSubview:topView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFont:STFont(18) text:MSG_PASSVIEW_TITLE textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    titleLabel.frame = CGRectMake(0, 0, cardView.width, STHeight(50));
    [cardView addSubview:titleLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(50), cardView.width,LineHeight)];
    lineView.backgroundColor = c26;
    [cardView addSubview:lineView];
    
    UIImageView *avatarImageView = [[UIImageView alloc]init];
    avatarImageView.frame = CGRectMake(STWidth(30), STHeight(65), STWidth(60), STHeight(60));
    avatarImageView.backgroundColor = cwhite;
    avatarImageView.layer.masksToBounds = YES;
    avatarImageView.layer.cornerRadius = STHeight(8);
    avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    [cardView addSubview:avatarImageView];
    
    if(!IS_NS_STRING_EMPTY(_mViewModel.data.imagePath)){
        UIImage *avatarImage = [UIImage imageWithContentsOfFile:_mViewModel.data.imagePath];
        avatarImageView.image = avatarImage;
        avatarImageView.hidden = NO;
    }else{
        avatarImageView.hidden = YES;
    }
    
    NSString *nameStr = [NSString stringWithFormat:MSG_PASSVIEW_NAME,_mViewModel.data.name];
    UILabel *nameLabel = [[UILabel alloc]initWithFont:STFont(14) text:nameStr textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    CGSize nameSize = [nameStr sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(14)]];
    nameLabel.frame = CGRectMake(cardView.width - nameSize.width - STWidth(21), STHeight(69), nameSize.width, STHeight(14));
    [cardView addSubview:nameLabel];
    
    NSString *dateStr = [NSString stringWithFormat:MSG_PASSVIEW_DATE,_mViewModel.data.visitDate];
    UILabel *dateLabel = [[UILabel alloc]initWithFont:STFont(14) text:dateStr textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    CGSize dateSize = [dateStr sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(14)]];
    dateLabel.frame = CGRectMake(cardView.width - dateSize.width - STWidth(21), STHeight(94), dateSize.width, STHeight(14));
    [cardView addSubview:dateLabel];
    
    
    NSString *qrCodeStr = [NSString stringWithFormat:@"%@|%@|%@",_mViewModel.data.name,_mViewModel.data.visitDate,_mViewModel.data.imagePath];
    UIImage *qrCodeImage = [LBXScanNative createQRWithString:qrCodeStr QRSize:CGSizeMake(1024,1024)];
    UIImageView *qrCodeImageView = [[UIImageView alloc]init];
    qrCodeImageView.frame = CGRectMake(STWidth(70), STHeight(155), STWidth(178), STHeight(178));
    qrCodeImageView.backgroundColor = cwhite;
    qrCodeImageView.image = qrCodeImage;
    qrCodeImageView.contentMode = UIViewContentModeScaleAspectFill;
    [cardView addSubview:qrCodeImageView];
    
    
    UILabel *lockCodeLabel = [[UILabel alloc]initWithFont:STFont(18) text:MSG_PASSVIEW_LOCKCODE textAlignment:NSTextAlignmentCenter textColor:c20 backgroundColor:nil multiLine:NO];
    lockCodeLabel.frame = CGRectMake(0, STHeight(342), cardView.width, STHeight(18));
    [cardView addSubview:lockCodeLabel];
    
    
    NSString *codeStr = [NSString stringWithFormat:@"%d %d %d %d",arc4random() % 5,arc4random() % 5,arc4random() % 5,arc4random() % 5];
    UILabel *codeLabel = [[UILabel alloc]initWithFont:STFont(18) text:codeStr textAlignment:NSTextAlignmentCenter textColor:c25 backgroundColor:nil multiLine:NO];
    codeLabel.frame = CGRectMake(0, STHeight(370), cardView.width, STHeight(18));
    [codeLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:STFont(18)]];
    [cardView addSubview:codeLabel];
    
    NSString *tipsStr = [NSString stringWithFormat:MSG_PASSVIEW_TIPS,_mViewModel.data.name];
    UILabel *tipsLabel = [[UILabel alloc]initWithFont:STFont(12) text:tipsStr textAlignment:NSTextAlignmentCenter textColor:c12 backgroundColor:nil multiLine:YES];
    CGSize tipSize = [tipsStr sizeWithMaxWidth:cardView.width - STWidth(82) font:[UIFont systemFontOfSize:STFont(12)]];
    tipsLabel.frame = CGRectMake(STWidth(41), STHeight(401), cardView.width - STWidth(82), tipSize.height);
    [cardView addSubview:tipsLabel];
    
    
    UIButton *shareBtn = [[UIButton alloc]initWithFont:STFont(14) text:MSG_PASSVIEW_SHAREBTN textColor:cwhite backgroundColor:c23 corner:STHeight(8) borderWidth:0 borderColor:nil];
    shareBtn.frame = CGRectMake(STWidth(98.5), STHeight(452), cardView.width - STWidth(98.5 * 2), STHeight(38));
    [shareBtn addTarget:self action:@selector(onClickShareBtn) forControlEvents:UIControlEventTouchUpInside];
    [cardView addSubview:shareBtn];
}

-(void)onClickShareBtn{
    
}

@end
