//
//  MemberPage.m
//  framework
//
//  Created by 黄成实 on 2018/5/15.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MemberPage.h"
#import "MemberView.h"
#import "AddMemberPage.h"
@interface MemberPage ()<MemberViewDelegate>

@property(strong, nonatomic)MemberView *memberView;
@end

@implementation MemberPage

+(void)show:(BaseViewController *)controller{
    MemberPage *page = [[MemberPage alloc]init];
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = c15;
    [self showSTNavigationBar:MSG_MEMBER_TITLE needback:YES];
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated{
    [self setStatuBarBackgroud:cwhite];
}



-(UIView *)memberView{
    if(_memberView == nil){
        MemberViewModel *viewModel = [[MemberViewModel alloc]init];
        viewModel.delegate = self;
        _memberView = [[MemberView alloc]initWithViewModel:viewModel];
        _memberView.backgroundColor = cwhite;
        _memberView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight + STHeight(10), ScreenWidth, ContentHeight-STHeight(10));
    }
    return _memberView;
}

-(void)initView{
    [self.view addSubview:[self memberView]];
}


//回调
-(void)onGetMemberModels:(NSMutableArray *)datas{
    if(_memberView){
        [_memberView updateView];
    }
}

-(void)onGoAddMemberView{
    [AddMemberPage show:self];
}

-(void)onDeleteMember:(Boolean)success model:(MemberModel *)model{
    if(_memberView){
        [_memberView updateView];
    }
}



@end
