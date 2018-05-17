//
//  AddMemberPage.m
//  framework
//
//  Created by 黄成实 on 2018/5/17.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "AddMemberPage.h"
#import "AddMemberView.h"

@interface AddMemberPage ()<AddMemberViewDelegate>

@property(strong, nonatomic)AddMemberView *addMemberView;

@end

@implementation AddMemberPage

+(void)show:(BaseViewController *)controller{
    AddMemberPage *page = [[AddMemberPage alloc]init];
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = c15;
    [self showSTNavigationBar:MSG_ADDMEMBER_TITLE needback:YES];
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated{
    [self setStatuBarBackgroud:cwhite];
}



-(UIView *)addMemberView{
    if(_addMemberView == nil){
        AddMemberViewModel *viewModel = [[AddMemberViewModel alloc]init];
        viewModel.delegate = self;
        _addMemberView = [[AddMemberView alloc]initWithViewModel:viewModel];
        _addMemberView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    }
    return _addMemberView;
}

-(void)initView{
    [self.view addSubview:[self addMemberView]];
}

-(void)onAddMemberModel:(Boolean)success model:(MemberModel *)model{
    
}



@end
