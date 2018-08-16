//
//  MainView.m
//  framework
//
//  Created by 黄成实 on 2018/5/9.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MainView.h"
#import "MainCell.h"
#import "MessagePage.h"
#import "OpendoorPage.h"
#import "CarPage.h"
#import "STCircleLabelView.h"
#import "AccountManager.h"
#import "STNetUtil.h"

@interface MainView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(strong, nonatomic) MainViewModel *mViewModel;
@property(strong, nonatomic) UICollectionView *collectionView;
@property(strong, nonatomic) STCircleLabelView *circleLabelView;
@end

@implementation MainView{
    NSArray *titles;
    NSArray *images;
}

-(instancetype)initWithViewModel:(MainViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
 
    titles = [MSG_MAIN_TITLE_ARRAY componentsSeparatedByString:@"|"];
    images = @[@"ic_main_opendoor",@"ic_main_car",@"ic_main_visitor",@"ic_main_visitor_history",@"ic_main_fix",@"ic_main_share",@"ic_main_call",@"ic_main_msg",@"ic_main_mine"];
    
    UIImageView *bannerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, STHeight(166))];
    bannerImageView.image = [UIImage imageNamed:@"test"];
    bannerImageView.contentMode = UIViewContentModeScaleAspectFill;
    bannerImageView.clipsToBounds = YES;
    [self addSubview:bannerImageView];
    
    
    UIView *msgView = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(176), ScreenWidth, STHeight(32))];
    msgView.backgroundColor = cwhite;
    [self addSubview:msgView];
    
    UILabel *propertyLabel = [[UILabel alloc]initWithFont:STFont(16) text:MSG_MAIN_PROPERTY textAlignment:NSTextAlignmentCenter textColor:c23 backgroundColor:nil multiLine:NO];
    CGSize propertySize = [MSG_MAIN_PROPERTY sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    propertyLabel.frame = CGRectMake(STWidth(15),0, propertySize.width, STHeight(32));
    [propertyLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:STFont(16)]];
    [msgView addSubview:propertyLabel];
    
    
    NSMutableArray *test = [[NSMutableArray alloc]init];
    [test addObject:@"测试-第1组数据"];
    [test addObject:@"测试-第2组数据"];
    [test addObject:@"测试-第3组数据"];
    [test addObject:@"测试-第4组数据"];
    [test addObject:@"测试-第5组数据"];

    _circleLabelView =[[STCircleLabelView alloc]initWithTitles:test];
    [msgView addSubview:_circleLabelView];
    
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(326), STHeight(7), 1, STHeight(18))];
    lineView.backgroundColor = c09;
    [msgView addSubview:lineView];
    
    UIButton *moreBtn = [[UIButton alloc]initWithFont:STFont(12) text:MSG_MORE textColor:c29 backgroundColor:nil corner:0 borderWidth:0 borderColor:nil];
    moreBtn.frame = CGRectMake(STWidth(329), 0, ScreenWidth - STWidth(329), STHeight(32));
    [moreBtn addTarget:self action:@selector(onClickMoreBtn) forControlEvents:UIControlEventTouchUpInside];
    [msgView addSubview:moreBtn];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, STHeight(218), ScreenWidth, STHeight(336)) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = cwhite;
    [self addSubview:_collectionView];
    
    [_collectionView registerClass:[MainCell class] forCellWithReuseIdentifier:[MainCell identify]];

}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [titles count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MainCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[MainCell identify] forIndexPath:indexPath];
    [cell setData:titles[indexPath.row] imageStr:images[indexPath.row]];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (CGSize)collectionView:(UICollectionView *)collectionView  layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return CGSizeMake(ScreenWidth/3, STHeight(112));
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0 , 0, 0, 0);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ApplyModel *applyModel = [[AccountManager sharedAccountManager]getApplyModel];
    if(applyModel.statu == APPLY_REJECT && indexPath.row !=8 && indexPath.row !=7){
        [_mViewModel showAuthFailDialog];
        return;
    }
    if(applyModel.statu == APPLY_DEFAULT  && indexPath.row !=8 && indexPath.row !=7){
        [_mViewModel openCheckInfoAlert];
        return;
    }
    if(applyModel.statu == APPLYING && indexPath.row !=8 && indexPath.row !=7){
        [_mViewModel goAuthStatuPage];
        return;
    }
    if(_mViewModel){
        switch (indexPath.row) {
            case 0:
                [_mViewModel goOpendoorPage];
                break;
            case 1:
                [_mViewModel goCarPage];
                break;
            case 2:
                [_mViewModel goVisitorPage];
                break;
            case 3:
                [_mViewModel goVisitorHistoryPage];
                break;
            case 4:
                [_mViewModel goReportFixPage];
                break;
            case 5:
                [_mViewModel goDeviceSharePage];
                break;
            case 6:
                [_mViewModel doCallProperty];
                break;
            case 7:
                [_mViewModel goMessagePage];
                break;
            case 8:
                [_mViewModel goMinePage];
                break;
            default:
                break;
        }
    }

}


-(void)onClickMoreBtn{
    if(_mViewModel){
        [_mViewModel goMessagePage];
    }
}


-(void)updateView{
  
}


@end
