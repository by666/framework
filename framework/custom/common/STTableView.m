//
//  STTableView.m
//  framework
//
//  Created by 黄成实 on 2018/5/14.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "STTableView.h"

@interface STTableView()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic)UITableView *tableView;
@property (strong, nonatomic)id cell;
@property (strong, nonatomic)NSMutableArray *datas;
@property (assign, nonatomic)CGFloat height;
@property (copy, nonatomic)NSString *identify;

@end

@implementation STTableView

-(instancetype)initWithFrame:(CGRect)frame delegate:(id)delegate{
    if(self == [super initWithFrame:frame]){
        self.stDelegate = delegate;
        [self initView:frame];
    }
    return self;
}

-(void)initView:(CGRect)frame{
    _tableView = [[UITableView alloc]initWithFrame:frame];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_tableView];
}

-(void)setDataAndCell:(NSMutableArray *)datas cell:(id)cell height:(CGFloat)height identify:(NSString *)identify{
    self.datas = datas;
    self.cell = cell;
    self.height = height;
    self.identify = identify;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(IS_NS_COLLECTION_EMPTY(_datas)){
        return 0;
    }
    return [self.datas count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.height;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Class class = NSClassFromString(self.identify);
    id cell=[tableView dequeueReusableCellWithIdentifier:self.identify];
    if (!cell) {
        cell=[[class alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.identify];
    }
    [cell setDatas:_datas];
    return cell;
}


@end
