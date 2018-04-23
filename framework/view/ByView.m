//
//  ByView.m
//  framework
//
//  Created by 黄成实 on 2018/4/18.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "ByView.h"
#import "STDataBaseUtil.h"
#import "TouchScrollView.h"
@interface ByView()<TouchScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic)ByViewModel *mByViewModel;
@property (strong, nonatomic)ByModel *mByModel;
@property (strong, nonatomic)TouchScrollView *scrollView;
@property (strong, nonatomic)UITableView *tableView;

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
    self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    self.backgroundColor = c02;

    _mByModel = [_mByViewModel requestData];
    
    _scrollView = [[TouchScrollView alloc]initWithParentView:self delegate:self];
    _scrollView.frame = CGRectMake(0, StatuBarHeight, ScreenWidth, ScreenHeight - StatuBarHeight);
    [_scrollView enableHeader];
    [_scrollView enableFooter];
//    _scrollView.backgroundColor = [UIColor redColor];
    _scrollView.contentSize = CGSizeMake(ScreenWidth, 200+50 *20);
    [self addSubview:_scrollView];
    
    

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 200, ScreenWidth, 50 *20)];
    _tableView.delegate = self;
    _tableView.scrollEnabled = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.dataSource = self;
    [_scrollView addSubview:_tableView];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"test"];
    [cell.textLabel setText:@"测试"];
    return cell;
}

-(void)uploadMore{
    [STLog print:@"加载更多"];
    [self performSelector:@selector(uploadCompelete) withObject:nil afterDelay:2.0f];

}

-(void)uploadCompelete{
    [STLog print:@"加载结束"];
    [_scrollView endUploadMore];
}

-(void)refreshNew{
    [STLog print:@"刷新最新"];
    [self performSelector:@selector(refreshCompelete) withObject:nil afterDelay:2.0f];
}

-(void)refreshCompelete{
    [_scrollView endRefreshNew];
    [STLog print:@"刷新结束"];

}



@end
