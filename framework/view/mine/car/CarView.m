//
//  CarView.m
//  framework
//
//  Created by 黄成实 on 2018/5/19.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "CarView.h"
#import "CarViewCell.h"


@interface CarView()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)CarViewModel *mViewModel;
@property(strong, nonatomic)UIView *noCarView;
@property(strong, nonatomic)UIView *carView;
@property(strong, nonatomic)UITableView *myCarTableView;
@property(strong, nonatomic)UITableView *familyCarTableView;


@end

@implementation CarView{
    NSMutableArray *myCarDatas;
    NSMutableArray *familyCarDatas;
}


-(instancetype)initWithViewModel:(CarViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    //获取数据
    [_mViewModel getCarDatas];
    myCarDatas = [_mViewModel getMyCarDatas];
    familyCarDatas = [_mViewModel getFamilyCarDatas];
    [self initNoCarView];
    [self initCarView];
    if(IS_NS_COLLECTION_EMPTY(_mViewModel.datas)){
        _noCarView.hidden = NO;
        _carView.hidden = YES;
    }else{
        _noCarView.hidden = YES;
        _carView.hidden = NO;
    }
}

-(void)initNoCarView{
    
    _noCarView = [[UIView alloc]init];
    _noCarView.frame= CGRectMake(0, 0, ScreenWidth, ContentHeight);
    [self addSubview:_noCarView];
    
    UILabel *noCarLabel = [[UILabel alloc]initWithFont:STFont(18) text:MSG_CAR_NOCAR textAlignment:NSTextAlignmentCenter textColor:c12 backgroundColor:nil multiLine:NO];
    noCarLabel.frame = CGRectMake(0, STHeight(125), ScreenWidth, STHeight(18));
    [_noCarView addSubview:noCarLabel];
    
    UIButton *noCarBtn = [[UIButton alloc]initWithFont:STFont(18) text:MSG_CAR_ADDCAR textColor:cwhite backgroundColor:c08 corner:STHeight(25) borderWidth:0 borderColor:0];
    noCarBtn.frame = CGRectMake(STWidth(49), STHeight(263), STWidth(276), STHeight(50));
    [noCarBtn addTarget:self action:@selector(OnClickAddCarBtn) forControlEvents:UIControlEventTouchUpInside];
    [_noCarView addSubview:noCarBtn];
}

-(void)initCarView{
    
    _carView = [[UIView alloc]init];
    _carView.frame= CGRectMake(0, 0, ScreenWidth, ContentHeight);
    _carView.backgroundColor = c15;
    [self addSubview:_carView];
    
    UILabel *myCarTitle = [[UILabel alloc]initWithFont:STFont(14) text:MSG_CAR_MYCAR textAlignment:NSTextAlignmentLeft textColor:c12 backgroundColor:nil multiLine:NO];
    myCarTitle.frame = CGRectMake(STWidth(15), STHeight(15), ScreenWidth - STWidth(30), STHeight(14));
    [_carView addSubview:myCarTitle];
    
    
    NSInteger height =  STHeight(60) * [myCarDatas count];
    _myCarTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, STHeight(45), ScreenWidth, height)];
    _myCarTableView.backgroundColor = cwhite;
    _myCarTableView.showsVerticalScrollIndicator = NO;
    _myCarTableView.showsHorizontalScrollIndicator = NO;
    _myCarTableView.delegate = self;
    _myCarTableView.dataSource = self;
    _myCarTableView.scrollEnabled = NO;
    _myCarTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_carView addSubview:_myCarTableView];
    
    UILabel *familyCarTitle = [[UILabel alloc]initWithFont:STFont(14) text:MSG_CAR_FAMILYCAR textAlignment:NSTextAlignmentLeft textColor:c12 backgroundColor:nil multiLine:NO];
    familyCarTitle.frame = CGRectMake(STWidth(15), STHeight(60) + height, ScreenWidth - STWidth(30), STHeight(14));
    [_carView addSubview:familyCarTitle];
    
    _familyCarTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, STHeight(90) + height, ScreenWidth, STHeight(60) * [familyCarDatas count])];
    _familyCarTableView.backgroundColor = cwhite;
    _familyCarTableView.showsVerticalScrollIndicator = NO;
    _familyCarTableView.showsHorizontalScrollIndicator = NO;
    _familyCarTableView.delegate = self;
    _familyCarTableView.dataSource = self;
    _familyCarTableView.scrollEnabled = NO;
    _familyCarTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_carView addSubview:_familyCarTableView];
    
    
    UIButton *recordBtn = [[UIButton alloc]initWithFont:STFont(16) text:MSG_CAR_RECORD textColor:c12 backgroundColor:nil corner:0 borderWidth:0 borderColor:nil
                           ];
    recordBtn.frame = CGRectMake(STWidth(130),STHeight(540), STWidth(115), STHeight(22));
    [recordBtn addTarget:self action:@selector(onClickRecordBtn) forControlEvents:UIControlEventTouchUpInside];
    [_carView addSubview:recordBtn];
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == _myCarTableView){
        return [myCarDatas count];
    }else if(tableView == _familyCarTableView){
        return [familyCarDatas count];
    }
    return 0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return STHeight(60);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CarViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CarViewCell identify]];
    if(!cell){
        cell = [[CarViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[CarViewCell identify]];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    CarModel *model;
    if(tableView == _myCarTableView){
        if(!IS_NS_COLLECTION_EMPTY(myCarDatas)){
            model = [myCarDatas objectAtIndex:indexPath.row];
        }
    }else{
        if(!IS_NS_COLLECTION_EMPTY(familyCarDatas)){
            model = [familyCarDatas objectAtIndex:indexPath.row];
        }
    }
    
    [cell updateData:model];
    return cell;
}


-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == _myCarTableView){
        return YES;
    }
    return NO;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}


-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return MSG_DELETE;
}

- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    
}


-(void)onClickRecordBtn{
    if(_mViewModel){
        [_mViewModel goPaymentRecordsPage];
    }
}

-(void)OnClickAddCarBtn{
    if(_mViewModel){
        [_mViewModel goAddCarPage];
    }
}

@end
