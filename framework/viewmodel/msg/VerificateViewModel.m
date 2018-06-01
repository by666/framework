//
//  VerificateViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/31.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "VerificateViewModel.h"
#import "TitleContentModel.h"
@implementation VerificateViewModel


-(instancetype)initWithModel:(MessageModel *)model{
    if(self == [super init]){
        _model = model;
        _datas = [[NSMutableArray alloc]init];
        _vaildArray = [[NSMutableArray alloc]init];
        [self setupDatas];
        [self setupValidArray];
    }
    return self;
}

-(void)setupDatas{
    [_datas addObject:[TitleContentModel buildModel:MSG_VERIFICATE_HEAD content:@""]];
    [_datas addObject:[TitleContentModel buildModel:MSG_VERIFICATE_NAME content:_model.content]];
    [_datas addObject:[TitleContentModel buildModel:MSG_VERIFICATE_IDENTIFY content:@"租客"]];
    [_datas addObject:[TitleContentModel buildModel:MSG_VERIFICATE_IDNUM content:@"362402199109290519"]];
    [_datas addObject:[TitleContentModel buildModel:MSG_VERIFICATE_PHONENUM content:@"18680686420"]];
//    [_datas addObject:[TitleContentModel buildModel:MSG_VERIFICATE_VALIDDATE content:@"一年"]];
}

-(void)setupValidArray{
    [_vaildArray addObject:MSG_VERIFICATE_DATE_QUATERYEAD];
    [_vaildArray addObject:MSG_VERIFICATE_DATE_HALF];
    [_vaildArray addObject:MSG_VERIFICATE_DATE_YEAR];
    [_vaildArray addObject:MSG_VERIFICATE_DATE_FOREVER];

}


-(void)doAgree{
    if(_delegate){
        [_delegate onDoAgree:_model];
    }
}

-(void)doReject{
    if(_delegate){
        [_delegate onDoReject:_model];
    }
}

@end
