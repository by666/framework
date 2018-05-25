//
//  STBuildingLayerView.m
//  framework
//
//  Created by 黄成实 on 2018/5/25.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "STBuildingLayerView.h"

@interface STBuildingLayerView()

@property(strong, nonatomic)NSMutableDictionary *mDatas;
@property(strong, nonatomic)UIButton *cancelBtn;
@property(strong, nonatomic)UIButton *confirmBtn;

@end


@implementation STBuildingLayerView

-(instancetype)initWithFrame:(CGRect)frame datas:(NSMutableDictionary *)datas{
    if(self == [super init]){
        self.frame = frame;
        _mDatas = datas;
        [self initView];
    }
    return self;
}

-(UIButton *)cancelBtn{
    if(_cancelBtn == nil){
        _cancelBtn = [[UIButton alloc]initWithFont:STFont(16) text:MSG_CANCEL textColor:c12 backgroundColor:c15 corner:0 borderWidth:0 borderColor:nil];
        _cancelBtn.frame = CGRectMake(0, ContentHeight - STHeight(179), ScreenWidth/2, STHeight(50));
        [_cancelBtn addTarget:self action:@selector(OnClickCancelBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}


-(UIButton *)confirmBtn{
    if(_confirmBtn == nil){
        _confirmBtn = [[UIButton alloc]initWithFont:STFont(16) text:MSG_CONFIRM textColor:c20 backgroundColor:c15 corner:0 borderWidth:0 borderColor:nil];
        _confirmBtn.frame = CGRectMake(ScreenWidth/2, ContentHeight - STHeight(179), ScreenWidth/2, STHeight(50));
        [_confirmBtn addTarget:self action:@selector(OnClickConfirmBtn) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _confirmBtn;
}


-(void)initView{
    self.backgroundColor = [cblack colorWithAlphaComponent:0.8];
    self.hidden = NO;
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(OnClickLayerView)];
    [self addGestureRecognizer:recognizer];
    
    if(IS_NS_COLLECTION_EMPTY(_mDatas)){
        return;
    }

}


-(void)OnClickLayerView{
    self.hidden = YES;
}

-(void)OnClickCancelBtn{
    self.hidden = YES;
    
}

-(void)OnClickConfirmBtn{
    self.hidden = YES;
    if(_delegate){
        [_delegate OnSelectResult:nil];
    }
}



@end

