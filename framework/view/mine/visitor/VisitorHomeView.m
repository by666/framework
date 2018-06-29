//
//  VisitorHomeView.m
//  framework
//
//  Created by by.huang on 2018/5/23.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "VisitorHomeView.h"

@interface VisitorHomeView()

@property(strong, nonatomic)VisitorHomeViewModel *mViewModel;

@end

@implementation VisitorHomeView

-(instancetype)initWithViewModel:(VisitorHomeViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    
    UIButton *peopleVisitorBtn = [[UIButton alloc]initWithFont:STFont(18) text:@"" textColor:cwhite backgroundColor:c13 corner:STHeight(5) borderWidth:0 borderColor:nil];
    peopleVisitorBtn.frame = CGRectMake(STWidth(15), STHeight(30), ScreenWidth - STWidth(30), STHeight(174));
    [peopleVisitorBtn addTarget:self action:@selector(onClickPeopleBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:peopleVisitorBtn];
    
    [self buildBtnContent:peopleVisitorBtn title:MSG_VISITORHOME_PEOPLE_BUTTON imageStr:@"ic_people_visit"];
    
    UIButton *carVisitorBtn = [[UIButton alloc]initWithFont:STFont(18) text:@"" textColor:cwhite backgroundColor:c08 corner:STHeight(5) borderWidth:0 borderColor:nil];
    carVisitorBtn.frame = CGRectMake(STWidth(15), STHeight(227), ScreenWidth - STWidth(30), STHeight(174));
    [carVisitorBtn addTarget:self action:@selector(onClickCarBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:carVisitorBtn];
    
    [self buildBtnContent:carVisitorBtn title:MSG_VISITORHOME_CAR_BUTTON imageStr:@"ic_car_visit"];

}

-(void)buildBtnContent:(UIButton *)button title:(NSString *)title imageStr:(NSString *)imageStr{
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:imageStr];
    imageView.frame = CGRectMake((ScreenWidth - STWidth(60))/2, STHeight(54), STWidth(30), STWidth(30));
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [button addSubview:imageView];
    
    UILabel *label = [[UILabel alloc]initWithFont:STFont(24) text:title textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    label.frame = CGRectMake(0, STHeight(95), ScreenWidth - STWidth(30), STHeight(24));
    [button addSubview:label];
}

-(void)onClickPeopleBtn{
    if(_mViewModel){
        [_mViewModel goVisitorPeople];
    }
}

-(void)onClickCarBtn{
    if(_mViewModel){
        [_mViewModel goVisitorCar];
    }
}
@end
