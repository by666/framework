//
//  ByView.m
//  framework
//
//  Created by 黄成实 on 2018/4/18.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "ByView.h"
#import "STDataBaseUtil.h"
@interface ByView()

@property (strong, nonatomic)ByViewModel *mByViewModel;
@property (strong, nonatomic)UILabel *mTestLabel;
@property (strong, nonatomic)ByModel *mByModel;

@end

@implementation ByView

-(instancetype)initWithViewModel:(ByViewModel *)byViewModel{
    if(self == [super init]){
        _mByViewModel = byViewModel;
        [self initView];
    }
    return self;
}


-(void)initView{
    self.frame = CGRectMake(0, StatuBarHeight, ScreenWidth, ScreenHeight - StatuBarHeight);
    self.backgroundColor = [UIColor redColor];

    _mByModel = [_mByViewModel requestData];
    
    _mTestLabel = [[UILabel alloc]init];
    _mTestLabel.frame = CGRectMake(20, StatuBarHeight+30, ScreenWidth-40, 30);
    _mTestLabel.font = [UIFont systemFontOfSize:24];
    _mTestLabel.textColor = [UIColor yellowColor];
    _mTestLabel.text = _mByModel.test1;
    [self addSubview:_mTestLabel];
    
    UIButton *button = [[UIButton alloc]init];
    button.frame = CGRectMake(20, StatuBarHeight + 100, ScreenWidth - 40, 60);
    button.backgroundColor = [UIColor blueColor];
    [button setTitle:@"改变数据" forState:UIControlStateNormal];
    [self addSubview:button];
    
    [button addTarget:self action:@selector(OnClicked) forControlEvents:UIControlEventTouchUpInside];
}

-(void)OnClicked{
//    [_mByViewModel changeData:self];
}



-(void)updateView:(ByModel *)model{
    _mTestLabel.text = _mByModel.test1;

}

@end
