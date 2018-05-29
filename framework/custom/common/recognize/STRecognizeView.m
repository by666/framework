//
//  STRecognizeView.m
//  framework
//
//  Created by 黄成实 on 2018/5/29.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "STRecognizeView.h"
#import "RecognizeCell.h"

@interface STRecognizeView()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property(copy, nonatomic)NSString *mTitle;
@property(strong, nonatomic)NSMutableArray *mDatas;
@property(strong, nonatomic)UITableView *tableView;

@end

@implementation STRecognizeView


-(instancetype)initWithTitle:(NSString *)title datas:(NSMutableArray *)datas{
    if(self == [super init]){
        _mTitle = title;
        _mDatas = datas;
        [self initView];
    }
    return self;
}


-(void)initView{
    

    self.backgroundColor = [cblack colorWithAlphaComponent:0.65f];
    self.frame = CGRectMake(0, 0, ScreenWidth, ContentHeight);
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(OnClickLayerView)];
    recognizer.delegate = self;
    recognizer.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:recognizer];
    
    UIButton *view = [[UIButton alloc]initWithFrame:CGRectMake(STWidth(52), STHeight(125), ScreenWidth - STWidth(104), STHeight(133))];
    view.backgroundColor = cwhite;
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = STWidth(14);
    [self addSubview:view];
    
    
    UILabel *titleLabel = [[UILabel alloc]initWithFont:STFont(16) text:_mTitle textAlignment:NSTextAlignmentCenter textColor:c20 backgroundColor:nil multiLine:NO];
    titleLabel.frame = CGRectMake(STWidth(52), STHeight(145), ScreenWidth - STWidth(104), STHeight(16));
    [self addSubview:titleLabel];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(STWidth(52), STHeight(175), ScreenWidth - STWidth(104), STHeight(80))];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.layer.masksToBounds = YES;
    _tableView.layer.cornerRadius = STWidth(14);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.contentSize = CGSizeMake(ScreenWidth - STWidth(104), STHeight(40)*[_mDatas count]);
    [self addSubview:_tableView];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_mDatas count];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return STHeight(40);
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RecognizeCell *cell = [tableView dequeueReusableCellWithIdentifier:[RecognizeCell identify]];
    if(!cell){
        cell = [[RecognizeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[RecognizeCell identify]];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    RecognizeModel *model = [_mDatas objectAtIndex:indexPath.row];
    [cell updateData:model];
    return cell;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger position = indexPath.row;
    if(!IS_NS_COLLECTION_EMPTY(_mDatas)){
        for(RecognizeModel *model in _mDatas){
            model.selected = NO;
        }
        RecognizeModel *model = [_mDatas objectAtIndex:position];
        model.selected = YES;
        
        [_tableView reloadData];
        if(_delegate){
            [_delegate onSelectRecognizeResult:model.title];
            self.hidden = YES;
        }
    }
    
}

//防止touch事件截获didSelectRow
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}


-(void)OnClickLayerView{
    self.hidden = YES;
}

-(void)setData : (NSMutableArray *)datas{
    _mDatas = datas;
    [_tableView reloadData];
}

@end
