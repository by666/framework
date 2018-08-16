//
//  STDetailView.m
//  framework
//
//  Created by 黄成实 on 2018/6/8.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "STDetailView.h"
#import "STDetailCell.h"

@interface STDetailView()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)UILabel *titleLabel;
@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)NSMutableArray *datas;
@property(strong, nonatomic)UIButton *cofirmBtn;

@end

@implementation STDetailView

-(instancetype)init{
    if(self == [super init]){
        _datas = [[NSMutableArray alloc]init];
        [self initView];
    }
    return self;
}



-(void)initView{
    self.frame = CGRectMake(0, 0, ScreenWidth, ContentHeight);
    self.backgroundColor = [cblack colorWithAlphaComponent:0.8];
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(OnClickLayerView)];
    [self addGestureRecognizer:recognizer];
    
    UIView *bodyView = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(150), ScreenWidth, ContentHeight - STHeight(150))];
    bodyView.backgroundColor = cwhite;
    CAShapeLayer *bodyLayer = [[CAShapeLayer alloc] init];
    bodyLayer.frame = bodyView.bounds;
//    bodyLayer.path = [UIBezierPath bezierPathWithRoundedRect:bodyView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(STHeight(14), STHeight(14))].CGPath;
//    bodyView.layer.mask = bodyLayer;
    bodyView.userInteractionEnabled = YES;
    [self addSubview:bodyView];
    
    _titleLabel = [[UILabel alloc]initWithFont:STFont(18) text:@"" textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    _titleLabel.frame = CGRectMake(0, 0, ScreenWidth, STHeight(57));
    [bodyView addSubview:_titleLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(57) - LineHeight, ScreenWidth, LineHeight)];
    lineView.backgroundColor = cline;
    [bodyView addSubview:lineView];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, STHeight(57), ScreenWidth, ContentHeight - STHeight(150) - STHeight(147))];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView useDefaultProperty];
    [bodyView addSubview:_tableView];

    
    _cofirmBtn = [[UIButton alloc]initWithFont:STHeight(16) text:MSG_KOWN textColor:c08 backgroundColor:cwhite corner:STHeight(25) borderWidth:LineHeight borderColor:c08];
    [_cofirmBtn setBackgroundColor:c08a forState:UIControlStateHighlighted];
    _cofirmBtn.frame = CGRectMake((ScreenWidth - STWidth(150))/2 , bodyView.size.height - STHeight(65), STWidth(150), STHeight(50));
    [_cofirmBtn addTarget:self action:@selector(OnClickLayerView) forControlEvents:UIControlEventTouchUpInside];
    [bodyView addSubview:_cofirmBtn];
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_datas count];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return STHeight(56.5);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    STDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:[STDetailCell identify]];
    if(!cell){
        cell = [[STDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[STDetailCell identify]];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if(!IS_NS_COLLECTION_EMPTY(_datas)){
        TitleContentModel *model = [_datas objectAtIndex:indexPath.row];
        [cell updateData:model];
    }
    return cell;
}


-(void)setDatas:(NSMutableArray *)datas name:(NSString *)name{
    _titleLabel.text = name;
    _datas = datas;
    [_tableView reloadData];
}

-(void)OnClickLayerView{
    self.hidden = YES;
}


@end
