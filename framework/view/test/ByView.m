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

@property (strong, nonatomic)TouchScrollView *scrollView;
@property (strong, nonatomic)UITableView *tableView;

@end

@implementation ByView{
    NSArray *titles;
}

-(instancetype)init{
    if(self == [super init]){
        titles = [[NSArray alloc]initWithObjects:@"系统人脸识别",@"ifly在线图片识别",@"ify离线图片识别",@"ify离线视频识别",@"Massory测试",@"二维码识别",nil];
        [self initView];
    }
    return self;
}


-(void)initView{
    self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    self.backgroundColor = c02;
    
    _scrollView = [[TouchScrollView alloc]initWithParentView:self delegate:self];
    _scrollView.frame = CGRectMake(0, StatuBarHeight, ScreenWidth, ScreenHeight - StatuBarHeight);
    [_scrollView enableHeader];
    [_scrollView enableFooter];
    _scrollView.contentSize = CGSizeMake(ScreenWidth, 50 *[titles count]);
    [self addSubview:_scrollView];


    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50 *[titles count])];
    _tableView.delegate = self;
    _tableView.scrollEnabled = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.dataSource = self;
    [_scrollView addSubview:_tableView];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [titles count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"test"];
    NSString *title = [titles objectAtIndex:indexPath.row];
    [cell.textLabel setText:title];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_byViewDelegate){
        switch (indexPath.row) {
            case 0:
                [_byViewDelegate goSystemFacePage];
                break;
            case 1:
                [_byViewDelegate goIFlyOnlineFaceDetectPage];
                break;
            case 2:
                [_byViewDelegate goIFlyOfflineFaceDetectPage];
                break;
            case 3:
                [_byViewDelegate goIFlyOfflineVedioDetectPage];
                break;
            case 4:
                [_byViewDelegate goMasonryPage];
                break;
            case 5:
                [_byViewDelegate goQRPage];
                break;
                
            default:
                break;
        }
    }
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
