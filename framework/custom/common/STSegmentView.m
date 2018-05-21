//
//  STSegmentView.m
//  framework
//
//  Created by 黄成实 on 2018/5/21.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "STSegmentView.h"
@interface STSegmentView()

@property(strong, nonatomic)NSArray *mTitles;

@end

@implementation STSegmentView


-(instancetype)initWithTitles:(NSArray *)titles{
    if(self == [super init]){
        _mTitles = titles;
        [self initView];
    }
    return self;
}

-(void)initView{
    UISegmentedControl *control = [[UISegmentedControl alloc]initWithItems:_mTitles];
    control.backgroundColor = cwhite;
//    control.selectedSegmentIndex = 1;
    [control setWidth:(ScreenWidth/[_mTitles count]) forSegmentAtIndex:0];
    [control setWidth:(ScreenWidth/[_mTitles count]) forSegmentAtIndex:1];
    [control setHeight:STHeight(60)];
    control.tintColor = [UIColor clearColor];

    //未选中字体颜色
    NSDictionary *normalDic = [NSDictionary dictionaryWithObjectsAndKeys:c12,
                               NSForegroundColorAttributeName,cwhite,NSBackgroundColorAttributeName,
                               [UIFont systemFontOfSize:STFont(16)],
                               NSFontAttributeName,nil];
    [control setTitleTextAttributes:normalDic forState:UIControlStateNormal];
    
    //选中字体颜色
    NSDictionary *selectDic = [NSDictionary dictionaryWithObjectsAndKeys:c19,
                               NSForegroundColorAttributeName,cwhite,NSBackgroundColorAttributeName,
                               [UIFont systemFontOfSize:STFont(16)],
                               NSFontAttributeName,nil];
    [control setTitleTextAttributes:selectDic forState:UIControlStateSelected];
    
    [control addTarget:self action:@selector(onClickSegment:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:control];
    
}

-(void)onClickSegment:(UISegmentedControl*)segmentsCon{
    switch (segmentsCon.selectedSegmentIndex) {
        case 0:
            NSLog(@"点击了left");
            break;
        case 1:
            NSLog(@"点击了middle");
            break;

            
        default:
            break;
    }
}



@end
