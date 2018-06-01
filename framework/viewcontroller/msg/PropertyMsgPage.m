//
//  PropertyMsgPage.m
//  framework
//
//  Created by 黄成实 on 2018/6/1.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "PropertyMsgPage.h"
#import "PropertyMsgView.h"

@interface PropertyMsgPage()<PropertyMsgViewDelegate>

@property (strong, nonatomic)PropertyMsgView *propertyMsgView;

@end

@implementation PropertyMsgPage

+(void)show:(BaseViewController *)controller{
    PropertyMsgPage *page = [[PropertyMsgPage alloc]init];
    [controller pushPage:page];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = c15;
    [self showSTNavigationBar:MSG_PROPERTYMSG_TITLE needback:YES];
    [self initView];
}


-(void)viewWillAppear:(BOOL)animated{
    [self setStatuBarBackgroud:cwhite];
}

-(void)initView{
    PropertyMsgViewModel *viewModel = [[PropertyMsgViewModel alloc]init];
    viewModel.delegate = self;
    
    _propertyMsgView = [[PropertyMsgView alloc]initWithViewModel:viewModel];
    _propertyMsgView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    _propertyMsgView.backgroundColor = c15;
    [self.view addSubview:_propertyMsgView];
}


-(void)onRequestCallback:(Boolean)success datas:(NSMutableArray *)datas{
    if(success){
        [_propertyMsgView updateView];
    }
}


@end
