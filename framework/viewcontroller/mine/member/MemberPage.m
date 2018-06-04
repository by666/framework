//
//  MemberPage.m
//  framework
//
//  Created by 黄成实 on 2018/5/15.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MemberPage.h"
#import "MemberView.h"
#import "AddMemberPage.h"
#import "STObserverManager.h"
@interface MemberPage ()<MemberViewDelegate,STObserverProtocol>

@property(strong, nonatomic)MemberView *memberView;
@property(strong, nonatomic)MemberViewModel *viewModel;
@end

@implementation MemberPage

+(void)show:(BaseViewController *)controller{
    MemberPage *page = [[MemberPage alloc]init];
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = c15;
    [self showSTNavigationBar:MSG_MEMBER_TITLE needback:YES];
    [self initView];
    [[STObserverManager sharedSTObserverManager] registerSTObsever:Notify_AddMember delegate:self];
    [[STObserverManager sharedSTObserverManager] registerSTObsever:Notify_DeleteMember delegate:self];
    [[STObserverManager sharedSTObserverManager] registerSTObsever:Notify_UpdateMember delegate:self];

}

-(void)viewWillAppear:(BOOL)animated{
    [self setStatuBarBackgroud:cwhite];
}

-(void)dealloc{
    [[STObserverManager sharedSTObserverManager]removeSTObsever:Notify_AddMember];
    [[STObserverManager sharedSTObserverManager]removeSTObsever:Notify_DeleteMember];
    [[STObserverManager sharedSTObserverManager]removeSTObsever:Notify_UpdateMember];
}


-(UIView *)memberView{
    if(_memberView == nil){
        _viewModel = [[MemberViewModel alloc]init];
        _viewModel.delegate = self;
        _memberView = [[MemberView alloc]initWithViewModel:_viewModel];
        _memberView.backgroundColor = cwhite;
        _memberView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight + STHeight(10), ScreenWidth, ContentHeight-STHeight(10));
    }
    return _memberView;
}

-(void)initView{
    [self.view addSubview:[self memberView]];
}


//回调
-(void)onGetMemberModels:(NSMutableArray *)datas{
    if(_memberView){
        [_memberView updateView];
    }
}

-(void)onGoAddMemberView{
    [AddMemberPage show:self];
}

-(void)onGoEditMemberView:(MemberModel *)model{
    [AddMemberPage show:self model:model];
}

-(void)onDeleteMember:(Boolean)success model:(MemberModel *)model row:(NSInteger)row{
    if(_memberView){
        [_memberView updateView];
    }
}

-(void)onReciveResult:(NSString *)key msg:(id)msg{
    if([key isEqualToString:Notify_AddMember]){
        MemberModel *model = msg;
        if(_viewModel){
            [_viewModel.datas addObject:model];
        }
    }
    else if([key isEqualToString:Notify_DeleteMember]){
        MemberModel *model = msg;
        if(_viewModel){
            [_viewModel.datas removeObject:model];
        }
    }else if([key isEqualToString:Notify_UpdateMember]){
        MemberModel *model = msg;
        if(_viewModel){
            for(int i = 0 ; i < [_viewModel.datas count] ; i ++ ){
                MemberModel *temp = [_viewModel.datas objectAtIndex:i];
                if([temp.uid isEqualToString:model.uid]){
                    [_viewModel.datas replaceObjectAtIndex:i withObject:model];
                }
            }
        }
    }
    [_memberView updateView];
}


-(void)onShowWarnPrompt:(MemberModel *)model{
    WS(weakSelf)
    [STAlertUtil showAlertController:MSG_WARN content:MSG_MEMBER_DELETE_TIPS controller:self confirm:^{
        [weakSelf.viewModel deleteMember:model];
    }];
}


@end
