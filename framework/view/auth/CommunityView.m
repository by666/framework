
//
//  CommunityView.m
//  framework
//
//  Created by 黄成实 on 2018/5/25.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "CommunityView.h"
#import "STAddressLayerView.h"
#import "CommunityCell.h"
#import "STObserverManager.h"
@interface CommunityView()<AddressLayerViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property(strong, nonatomic)CommunityViewModel *mViewModel;
@property(strong, nonatomic)UIButton *cityBtn;
@property(strong, nonatomic)UIImageView *arrowImageview;
@property(strong, nonatomic)STAddressLayerView *addressLayerView;
@property(strong, nonatomic)UITextField *addressTF;
@property(strong, nonatomic)UIButton *searchBtn;
@property(strong, nonatomic)UILabel *currentLabel;
@property(strong, nonatomic)UITableView *tableView;

@end

@implementation CommunityView

-(instancetype)initWithViewModel:(CommunityViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    [self initPart1];
    [self initPart2];
    
    _addressLayerView = [[STAddressLayerView alloc]initWithColumn:2];
    _addressLayerView.delegate = self;
    _addressLayerView.hidden = YES;
    [self addSubview:_addressLayerView];
    
   
}

-(void)initPart1{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(10), ScreenWidth, STHeight(100))];
    view.backgroundColor = cwhite;
    [self addSubview:view];
    
    UIImageView *positionImageView = [[UIImageView alloc]init];
    positionImageView.frame = CGRectMake(STWidth(19), STHeight(17), STWidth(14), STHeight(18));
    positionImageView.contentMode =UIViewContentModeScaleAspectFill;
    positionImageView.image = [UIImage imageNamed:@"ic_position"];
    [view addSubview:positionImageView];
    
    _cityBtn = [[UIButton alloc]initWithFont:STFont(16) text:@"深圳" textColor:c16 backgroundColor:nil corner:0 borderWidth:0 borderColor:nil];
    CGSize citySize = [@"深圳" sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _cityBtn.frame = CGRectMake(STWidth(43), 0, citySize.width, STHeight(50));
    _cityBtn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [_cityBtn addTarget:self action:@selector(OnClickCityBtn) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_cityBtn];
    
    _arrowImageview = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(48)+citySize.width, STHeight(23), STWidth(11), STHeight(7))];
    _arrowImageview.image = [UIImage imageNamed:@"ic_bottom_arrow"];
    [view addSubview:_arrowImageview];
    
    _addressTF = [[UITextField alloc]initWithFont:STFont(16) textColor:c16 backgroundColor:c28 corner:2 borderWidth:0 borderColor:nil padding:STWidth(43)];
    _addressTF.frame = CGRectMake(STWidth(70)+citySize.width, STHeight(8), STWidth(211), STHeight(34));
    _addressTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [view addSubview:_addressTF];
    
    UIImageView *searchImageView  =[[UIImageView alloc]init];
    searchImageView.frame = CGRectMake(STWidth(10), STHeight(7), STWidth(20), STHeight(20));
    searchImageView.image = [UIImage imageNamed:@"ic_search"];
    [_addressTF addSubview:searchImageView];
    
    _searchBtn = [[UIButton alloc]initWithFont:STFont(16) text:MSG_SEARCH textColor:c19 backgroundColor:nil corner:0 borderWidth:0 borderColor:nil];
    _searchBtn.frame = CGRectMake(ScreenWidth -  STWidth(50), STHeight(18),STWidth(40) ,STHeight(15));
    [_searchBtn setBackgroundColor:c19a forState:UIControlStateHighlighted];
    [_searchBtn addTarget:self action:@selector(onClickSearchBtn) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_searchBtn];
    
    _currentLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"光明顶" textAlignment:NSTextAlignmentLeft textColor:c16 backgroundColor:nil multiLine:NO];
    CGSize currentSize = [@"光明顶" sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _currentLabel.frame = CGRectMake(STWidth(19), STHeight(67), currentSize.width, STHeight(16));
    [view addSubview:_currentLabel];
    
    UIImageView *locationImageView = [[UIImageView alloc]init];
    locationImageView.frame = CGRectMake(STWidth(257), STHeight(68), STWidth(14), STHeight(14));
    locationImageView.contentMode =UIViewContentModeScaleAspectFill;
    locationImageView.image = [UIImage imageNamed:@"ic_location"];
    [view addSubview:locationImageView];
    
    UILabel *locationLabel = [[UILabel alloc]initWithFont:STFont(14) text:MSG_COMMUNITY_CURRENTPOSITION textAlignment:NSTextAlignmentLeft textColor:c09 backgroundColor:nil multiLine:NO];
    CGSize locationSize = [MSG_COMMUNITY_CURRENTPOSITION sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(14)]];
    locationLabel.frame = CGRectMake(STWidth(276), STHeight(67), locationSize.width, STHeight(14));
    [view addSubview:locationLabel];
    
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(50), ScreenWidth, 1)];
    lineView.backgroundColor = c17;
    [view addSubview:lineView];
}


-(void)initPart2{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(120), ScreenWidth, ContentHeight -  STHeight(120))];
    view.backgroundColor = cwhite;
    [self addSubview:view];
    
    UIImageView *houseImageView = [[UIImageView alloc]init];
    houseImageView.frame = CGRectMake(STWidth(16), STHeight(14), STWidth(14), STHeight(14));
    houseImageView.contentMode =UIViewContentModeScaleAspectFill;
    houseImageView.image = [UIImage imageNamed:@"ic_house"];
    [view addSubview:houseImageView];
    
    UILabel *listLabel = [[UILabel alloc]initWithFont:STFont(14) text:MSG_COMMUNITY_LISTTITLE textAlignment:NSTextAlignmentLeft textColor:c20 backgroundColor:nil multiLine:NO];
    CGSize listSize = [MSG_COMMUNITY_LISTTITLE sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(14)]];
    listLabel.frame = CGRectMake(STWidth(36), STHeight(14), listSize.width, STHeight(14));
    [view addSubview:listLabel];
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, STHeight(40), ScreenWidth, ContentHeight -  STHeight(160))];
    _tableView.backgroundColor = cwhite;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [view addSubview:_tableView];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_mViewModel.datas count];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return STHeight(58);
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommunityCell *cell = [tableView dequeueReusableCellWithIdentifier:[CommunityCell identify]];
    if(!cell){
        cell = [[CommunityCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[CommunityCell identify]];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    CommunityModel *model = [_mViewModel.datas objectAtIndex:indexPath.row];
    [cell updateData:model key:_addressTF.text];
    return cell;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(!IS_NS_COLLECTION_EMPTY(_mViewModel.datas)){
        CommunityModel *model = [_mViewModel.datas objectAtIndex:indexPath.row];
        [[STObserverManager sharedSTObserverManager]sendMessage:Notify_UpdateAddress msg:model.name];
        if(_mViewModel){
            [_mViewModel backLastPage];
        }
    }
    
}


-(void)OnClickCityBtn{
    [_addressTF resignFirstResponder];
    _addressLayerView.hidden = NO;
}


-(void)onClickSearchBtn{
    [_addressTF resignFirstResponder];
    if(_mViewModel){
        [_mViewModel searchCommunity:_addressTF.text];
    }
}

-(void)onSelectAddressResult:(NSString *)city{
    CGFloat width = STWidth(80);
    if(city.length < 5){
        CGSize citySize = [city sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
        width = citySize.width;
    }
    [_cityBtn setTitle:city forState:UIControlStateNormal];
    _cityBtn.frame = CGRectMake(STWidth(43), 0, width, STHeight(50));
    _arrowImageview.frame = CGRectMake(STWidth(48)+width, STHeight(23), STWidth(11), STHeight(7));
    
    _addressTF.frame = CGRectMake(STWidth(70)+width, STHeight(8), STWidth(211) -(width - STWidth(32)), STHeight(34));

}

-(void)updateView{
    _tableView.contentSize = CGSizeMake(ScreenWidth, STHeight(58)*[_mViewModel.datas count]);
    [_tableView reloadData];
}

@end
