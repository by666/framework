//
//  VisitorView.m
//  framework
//
//  Created by 黄成实 on 2018/5/22.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "VisitorView.h"

@implementation VisitorView

-(instancetype)init{
    if(self == [super init]){
        [self initView];
    }
    return self;
}

-(void)initView{
    
    UIButton *peopleVisitorBtn = [[UIButton alloc]initWithFont:STFont(18) text:MSG_VISITOR_PEOPLE_BUTTON textColor:cwhite backgroundColor:c19 corner:STHeight(25) borderWidth:0 borderColor:nil];
    peopleVisitorBtn.frame = CGRectMake(STWidth(50), STHeight(179), STWidth(276), STHeight(50));
    [peopleVisitorBtn addTarget:self action:@selector(onClickPeopleBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:peopleVisitorBtn];
    
    UIButton *carVisitorBtn = [[UIButton alloc]initWithFont:STFont(18) text:MSG_VISITOR_CAR_BUTTON textColor:cwhite backgroundColor:c13 corner:STHeight(25) borderWidth:0 borderColor:nil];
    carVisitorBtn.frame = CGRectMake(STWidth(50), STHeight(239), STWidth(276), STHeight(50));
    [carVisitorBtn addTarget:self action:@selector(onClickCarBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:carVisitorBtn];
}

-(void)onClickPeopleBtn{
    
}

-(void)onClickCarBtn{
    
}


@end
