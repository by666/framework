//
//  AddMemberView.m
//  framework
//
//  Created by 黄成实 on 2018/5/17.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "AddMemberView.h"
#import "AddMemberViewModel.h"


@interface AddMemberView()

@property(strong, nonatomic) AddMemberViewModel *mViewModel;
@property(strong, nonatomic) UIButton *takePhotoBTN;

@end

@implementation AddMemberView

-(instancetype)initWithViewModel:(AddMemberViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    
    UILabel *tipsLabel = [[UILabel alloc]initWithFont:STFont(14) text:MSG_ADDMEMBER_TIPS textAlignment:NSTextAlignmentCenter textColor:c20 backgroundColor:nil multiLine:NO];
    tipsLabel.frame = CGRectMake(0, STHeight(28), ScreenWidth, STHeight(14));
    [self addSubview:tipsLabel];
    
    _takePhotoBTN = [[UIButton alloc]initWithFont:STFont(14) text:MSG_ADDMEMBER_TAKEPHOTO textColor:c12 backgroundColor:cwhite corner:STHeight(57) borderWidth:0 borderColor:nil];
    _takePhotoBTN.frame = CGRectMake(STWidth(131), STHeight(70), STHeight(114), STHeight(114));
    _takePhotoBTN.titleLabel.numberOfLines = 0;
    _takePhotoBTN.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _takePhotoBTN.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_takePhotoBTN];

    
}

-(void)updateView{
    
}

@end
