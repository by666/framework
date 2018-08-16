//
//  MainView2.m
//  framework
//
//  Created by 黄成实 on 2018/8/6.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MainView2.h"
#import "MainCardCell.h"
#import "MessageModel.h"
#import "MainCell2.h"
#import "AccountManager.h"
#import "STNetUtil.h"

@interface MainView2()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>

@property(strong, nonatomic) MainViewModel *mViewModel;
@property(strong, nonatomic) UIScrollView *scrollView;
@property(strong, nonatomic) UIImageView *topImageView;
@property(strong, nonatomic) UIView *cardView;
@property(strong, nonatomic) UIView *authView;
@property(strong, nonatomic) UICollectionView *memberCollectView;
@property(strong, nonatomic) UIView *messageView;
@property(strong, nonatomic) UIView *propertyView;
@property(strong, nonatomic) UICollectionView *propertyCollectView;


@end

@implementation MainView2

-(instancetype)initWithViewModel:(MainViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)requestNew{
    if(_mViewModel){
        [_mViewModel getLiveInfo];
    }
}

-(void)initView{
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ContentHeight)];
    _scrollView.delegate = self;

    MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestNew)];
    header.lastUpdatedTimeLabel.hidden = NO;
    _scrollView.mj_header = header;
    [self addSubview:_scrollView];
    
    UIImage *image = [UIImage imageNamed:@"首页_背景"];
    _topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, image.size.height * ScreenWidth / image.size.width)];
    _topImageView.image = image;
    [_scrollView addSubview:_topImageView];
    
    _cardView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(120), ScreenWidth - STWidth(30),STHeight(157))];
    _cardView.backgroundColor = cwhite;
    _cardView.layer.shadowColor = c33.CGColor;
    _cardView.layer.shadowOffset = CGSizeMake(0,5);
    _cardView.layer.shadowOpacity = 0.8;
    _cardView.layer.shadowRadius = 4;

    [_scrollView addSubview:_cardView];
    
    _authView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, STHeight(276))];
    _authView.backgroundColor = cwhite;
    _authView.hidden = YES;
    [_scrollView addSubview:_authView];
    
    UIImageView *authImageView = [[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth - STWidth(168))/2, STHeight(20), STWidth(168), STHeight(126))];
    authImageView.contentMode = UIViewContentModeScaleAspectFill;
    authImageView.image = [UIImage imageNamed:@"首页_首页_未认证信息"];
    [_authView addSubview:authImageView];
    
    UILabel *authLabel = [[UILabel alloc]initWithFont:STFont(17) text:MSG_MAIN_NO_AUTH textAlignment:NSTextAlignmentCenter textColor:c12 backgroundColor:nil multiLine:NO];
    authLabel.frame = CGRectMake(0, STHeight(156), ScreenWidth, STHeight(24));
    [_authView addSubview:authLabel];
    
    UIButton *authBtn = [[UIButton alloc]initWithFont:STFont(16) text:MSG_MAIN_AUTH_BTN textColor:cwhite backgroundColor:c08 corner:STHeight(25) borderWidth:0 borderColor:nil];
    authBtn.frame = CGRectMake((ScreenWidth - STWidth(150))/2, STHeight(200), STWidth(150), STHeight(50));
   [authBtn addTarget:self action:@selector(onClickAuthBtn) forControlEvents:UIControlEventTouchUpInside];
    [_authView addSubview:authBtn];

    UIView *tagView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(25), STWidth(5), STHeight(13))];
    tagView.backgroundColor = c08;
    [_cardView addSubview:tagView];
    
    UILabel *tagLabel = [[UILabel alloc]initWithFont:STFont(16) text:MSG_MAIN_MEMBER_TITLE textAlignment:NSTextAlignmentCenter textColor:c12 backgroundColor:nil multiLine:NO];
    CGSize tagLabelSize = [MSG_MAIN_MEMBER_TITLE sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    tagLabel.frame = CGRectMake(STWidth(25), STHeight(20), tagLabelSize.width, STHeight(22));
    [_cardView addSubview:tagLabel];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    _memberCollectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, STHeight(60), ScreenWidth - STWidth(30), STHeight(97)) collectionViewLayout:layout];
    _memberCollectView.delegate = self;
    _memberCollectView.dataSource = self;
    _memberCollectView.showsHorizontalScrollIndicator = NO;
    _memberCollectView.showsVerticalScrollIndicator = NO;
    _memberCollectView.backgroundColor = cwhite;
    
    [_cardView addSubview:_memberCollectView];
    
    [_memberCollectView registerClass:[MainCardCell class] forCellWithReuseIdentifier:[MainCardCell identify]];
    
    

}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(_memberCollectView == collectionView){
        return [_mViewModel.memberDatas count];
    }
    return [_mViewModel.propertyDatas count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(collectionView == _memberCollectView){
        MainCardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[MainCardCell identify] forIndexPath:indexPath];
        if(!IS_NS_COLLECTION_EMPTY(_mViewModel.memberDatas)){
            MemberModel *model = [_mViewModel.memberDatas objectAtIndex:indexPath.row];
            [cell setData:model position:indexPath.row];
        }
        return cell;
    }
    MainCell2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[MainCell2 identify] forIndexPath:indexPath];
    if(!IS_NS_COLLECTION_EMPTY(_mViewModel.memberDatas)){
        TitleContentModel *model = [_mViewModel.propertyDatas objectAtIndex:indexPath.row];
        [cell setData:model];
    }
    return cell;

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (CGSize)collectionView:(UICollectionView *)collectionView  layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if(collectionView == _memberCollectView){
        return CGSizeMake(STWidth(84), STHeight(97));
    }
    return CGSizeMake(ScreenWidth/3, ScreenWidth/3);
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
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(_mViewModel){
        ApplyModel *applyModel = [[AccountManager sharedAccountManager]getApplyModel];
        if(![STNetUtil isNetAvailable]){
            [STToastUtil showFailureAlertSheet:MSG_NET_ERROR];
            return;
        }
        if(applyModel.statu == APPLY_DEFAULT){
            [_mViewModel openCheckInfoAlert];
            return;
        }
        if(applyModel.statu == APPLYING){
            [_mViewModel goAuthStatuPage];
            return;
        }
        if(applyModel.statu == APPLY_REJECT){
            [_mViewModel showAuthFailDialog];
            return;
        }
        NSUInteger row = indexPath.row;
        if(collectionView == _memberCollectView){
            if(row == 0){
                [_mViewModel goAddMemberPage];
            }else{
                [_mViewModel goMemberPage];
            }
        }
        
        if(collectionView == _propertyCollectView){
                switch (row) {
                    case 0:
                        [_mViewModel goOpendoorPage];
                        break;
                    case 1:
                        [_mViewModel goVisitorPage];
                        break;
                    case 2:
                        [_mViewModel goVisitorHistoryPage];
                        break;
                    case 3:
                        [_mViewModel goDeviceSharePage];
                        break;
                    case 4:
                        [_mViewModel goReportFixPage];
                        break;
                    case 5:
                        [_mViewModel doCallProperty];
                        break;
                        
                    default:
                        break;
            }
        }
        
    }
}



-(void)updateMemberView{
    ApplyModel *applyModel = [[AccountManager sharedAccountManager] getApplyModel];
    if(applyModel.statu == APPLY_DEFAULT){
        _topImageView.hidden = YES;
        _cardView.hidden = YES;
        _authView.hidden = NO;
        [_mViewModel updateNavigationBarColor:0.0f];
    }else{
        _topImageView.hidden = NO;
        _cardView.hidden = NO;
        _authView.hidden = YES;
    }
    
    if(_memberCollectView){
        [_memberCollectView reloadData];
    }
}

-(void)updateMsgView{
    CGFloat height = 0;
    NSMutableArray *msgDatas = _mViewModel.msgDatas;
    if(!IS_NS_COLLECTION_EMPTY(msgDatas)){
        _messageView = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(287),ScreenWidth, STHeight(63) + STHeight(94.5) * [msgDatas count])];
        _messageView.backgroundColor = cwhite;
        [_scrollView addSubview:_messageView];
    
        UIView *msgTitleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, STHeight(63))];
        msgTitleView.backgroundColor = cwhite;
        [_messageView addSubview:msgTitleView];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFont:STFont(17) text:MSG_MAIN_MESSAGE_TITLE textAlignment:NSTextAlignmentCenter textColor:c12 backgroundColor:nil multiLine:NO];
        CGSize titleSize = [MSG_MAIN_MESSAGE_TITLE sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(17)]];
        titleLabel.frame = CGRectMake(STWidth(15), STHeight(20), titleSize.width, STHeight(24));
        [_messageView addSubview:titleLabel];
        
        UIButton *moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - STWidth(60), 0, STWidth(60), STHeight(63))];
//        moreBtn.backgroundColor = c01;
        [moreBtn addTarget:self action:@selector(onClickMoreBtn) forControlEvents:UIControlEventTouchUpInside];
        [_messageView addSubview:moreBtn];
        
        UILabel *moreLabel = [[UILabel alloc]initWithFont:STFont(17) text:MSG_MORE textAlignment:NSTextAlignmentCenter textColor:c12 backgroundColor:nil multiLine:NO];
        CGSize moreSize = [MSG_MORE sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(17)]];
        moreLabel.frame = CGRectMake(0, 0, moreSize.width, STHeight(63));
        [moreBtn addSubview:moreLabel];
        
        UIImageView *moreImageView = [[UIImageView alloc]initWithFrame:CGRectMake(moreSize.width + STWidth(2), STHeight(28), STWidth(9), STWidth(9))];
        moreImageView.image = [UIImage imageNamed:@"列表页通用_icon_进入"];
        [moreBtn addSubview:moreImageView];
        
        NSInteger maxCount = 0 ;
        if([msgDatas count] >= 3){
            maxCount = 3;
        }else{
            maxCount = [msgDatas count];
        }
        
        height = (maxCount *  STHeight(94.5))  + STHeight(63);
        
        for(int i =0 ; i < maxCount ; i++){
            MessageModel *model = [msgDatas objectAtIndex:i];
            UILabel *mainLabel = [[UILabel alloc]initWithFont:STFont(17) text:@"" textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
            UILabel *subLabel = [[UILabel alloc]initWithFont:STFont(14) text:@"" textAlignment:NSTextAlignmentLeft textColor:c12 backgroundColor:nil multiLine:NO];
            MessageType type = [MessageModel translateType:model.applyType];
            if(type == UserAuth){
                mainLabel.text = @"认证请求";
                subLabel.text = [NSString stringWithFormat:MSG_MESSAGE_USERAUTH_CONTENT,model.userName,[STPUtil getLiveAttr:model.applyType]];
            }else if(type == CarEnter || type == VisitorEnter){
                mainLabel.text = @"访客门禁申请";
                subLabel.text = [NSString stringWithFormat:MSG_MESSAGE_VISITOR_CONTENT,model.userName];
            }
            CGSize mainSize = [mainLabel.text sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(17)]];
            mainLabel.frame = CGRectMake(STWidth(15), STHeight(84) + STHeight(94.5) * i, mainSize.width, STHeight(24));
            [_messageView addSubview:mainLabel];
            
            CGSize subSize = [subLabel.text sizeWithMaxWidth:STWidth(252) font:[UIFont systemFontOfSize:STFont(14)]];
            subLabel.frame = CGRectMake(STWidth(15), STHeight(118) + STHeight(94.5) * i, subSize.width, STHeight(20));
            [_messageView addSubview:subLabel];
            
            UIButton *applyBtn = [[UIButton alloc]initWithFont:STFont(14) text:MSG_SEE textColor:c08 backgroundColor:nil corner:STHeight(13) borderWidth:1 borderColor:c08];
            applyBtn.frame = CGRectMake(STWidth(294), STHeight(97) + STHeight(94.5) * i, STWidth(66), STHeight(26));
            applyBtn.tag = i;
            [applyBtn addTarget:self action:@selector(onClickApplyBtn:) forControlEvents:UIControlEventTouchUpInside];
            [_messageView addSubview:applyBtn];

            
            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(63) + STHeight(94.5) * i, ScreenWidth, LineHeight)];
            lineView.backgroundColor = cline;
            [_messageView addSubview:lineView];
        
        }
    }
    
    [self updatePropertyView:height];
    
    [_scrollView.mj_header endRefreshing];

}

-(void)updatePropertyView:(CGFloat)height{
    if(_propertyView != nil){
        [_propertyView removeFromSuperview];
    }
    
    if(height == 0){
        _propertyView = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(287) + height, ScreenWidth, STHeight(316))];
    }else{
        _propertyView = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(297) + height, ScreenWidth, STHeight(316))];
    }
    [_scrollView addSubview:_propertyView];
    
    UIView *propertyTitleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, STHeight(64))];
    propertyTitleView.backgroundColor = cwhite;
    [_propertyView addSubview:propertyTitleView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFont:STFont(17) text:MSG_MAIN_PROPERTY_TITLE textAlignment:NSTextAlignmentCenter textColor:c12 backgroundColor:nil multiLine:NO];
    CGSize titleSize = [MSG_MAIN_PROPERTY_TITLE sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(17)]];
    titleLabel.frame = CGRectMake(STWidth(15), STHeight(20), titleSize.width, STHeight(24));
    [_propertyView addSubview:titleLabel];
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    _propertyCollectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, STHeight(64), ScreenWidth, ScreenWidth * 2/3) collectionViewLayout:layout];
    _propertyCollectView.delegate = self;
    _propertyCollectView.dataSource = self;
    _propertyCollectView.showsHorizontalScrollIndicator = NO;
    _propertyCollectView.showsVerticalScrollIndicator = NO;
    _propertyCollectView.backgroundColor = cwhite;
    _propertyCollectView.scrollEnabled = NO;
    [_propertyView addSubview:_propertyCollectView];
    
    [_propertyCollectView registerClass:[MainCell2 class] forCellWithReuseIdentifier:[MainCell2 identify]];
    
    
    for(int i = 1 ; i <= 2 ; i ++ ){
        UIView *hLine = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth * i / 3 - LineHeight, STHeight(64), LineHeight, ScreenWidth * 2/3)];
        hLine.backgroundColor = cline;
        [_propertyView addSubview:hLine];
        
        UIView *vLine = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(64) - LineHeight + ScreenWidth/3 * (i - 1), ScreenWidth, LineHeight)];
        vLine.backgroundColor = cline;
        [_propertyView addSubview:vLine];
    }
 

    _scrollView.contentSize = CGSizeMake(ScreenWidth, STHeight(297) + height + STHeight(63) + ScreenWidth * 2/3);

}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    ApplyModel *applyModel = [[AccountManager sharedAccountManager]getApplyModel];
    if(applyModel.statu == APPLY_DEFAULT){
        return;
    }
    CGFloat y = scrollView.contentOffset.y;
    [STLog print:[NSString stringWithFormat:@"%.f",y]];
    if(y > 100 && y < 300){
        CGFloat alpha = 1  - (y - 100)/200;
        [_mViewModel updateNavigationBarColor:alpha];
    }else if(y >= 300){
        [_mViewModel updateNavigationBarColor:0.0f];
    }else{
        [_mViewModel updateNavigationBarColor:1.0f];
    }
}



//handle
-(void)onClickMoreBtn{
    if(_mViewModel){
        [_mViewModel goMessagePage];
    }
}


-(void)onClickApplyBtn:(id)sender{
    UIButton *button = sender;
    NSInteger tag = button.tag;
    if(_mViewModel){
        MessageModel *model = [_mViewModel.msgDatas objectAtIndex:tag];
        [_mViewModel goMessageDetailPage:model];
    }
}

-(void)onClickAuthBtn{
    if(_mViewModel){
        [_mViewModel goAuthUserPage];
    }
}


@end
