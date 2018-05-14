//
//  MainView.m
//  framework
//
//  Created by 黄成实 on 2018/5/9.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MainView.h"
#import "STTableView.h"
#import "MainCell.h"

@interface MainView()<STTableViewDelegate>

@property(strong, nonatomic) MainViewModel *mViewModel;
@property(strong, nonatomic) STTableView *tableView;
@property(strong, nonatomic) MainCell *mainCell;


@end

@implementation MainView

-(instancetype)initWithViewModel:(MainViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    NSMutableArray *datas = [[NSMutableArray alloc]init];
    for(int i = 0 ; i < 10 ; i ++){
        [datas addObject:@"123"];
    }
    _mainCell = [[MainCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([MainCell class])];

    _tableView = [[STTableView alloc]initWithFrame:CGRectMake(0,0, ScreenWidth, ContentHeight) delegate:self];
    [_tableView setDataAndCell:datas cell:_mainCell height:STHeight(100) identify:NSStringFromClass([MainCell class])];
    [self addSubview:_tableView];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = @"测试";
    return cell;
}


@end
