//
//  VisitorViewModel.m
//  framework
//
//  Created by by.huang on 2018/5/23.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "VisitorViewModel.h"

@implementation VisitorViewModel

-(instancetype)init{
    if(self == [super init]){
        _data = [[VisitorModel alloc]init];
    }
    return self;
}

-(void)generatePass:(NSString *)name date:(NSString *)date carNum:(NSString *)carNum on:(Boolean)on imagePath:(NSString *)imagePath type:(VisitorType)type{
    if(_delegate){
        if(IS_NS_STRING_EMPTY(name)){
            return [_delegate onGeneratePass:NO msg:MSG_VISITOR_ERROR_NONAME];
        }
        if(IS_NS_STRING_EMPTY(date)){
            return [_delegate onGeneratePass:NO msg:MSG_VISITOR_ERROR_NODATE];
        }
        if(IS_NS_STRING_EMPTY(carNum) && type == Car){
            return [_delegate onGeneratePass:NO msg:MSG_VISITOR_ERROR_NOCARNUM];
        }
        if(on){
            if(IS_NS_STRING_EMPTY(imagePath)){
                return [_delegate onGeneratePass:NO msg:MSG_VISITOR_ERROR_NOFACEDETECT];
            }
        }
        _data.name = name;
        _data.visitDate = date;
        _data.carNum = carNum;
        _data.imagePath = imagePath;
        [_delegate onGeneratePass:YES msg:nil];
    }
}

-(void)doTakePhoto{
    if(_delegate){
        [_delegate onDoTakePhoto];
    }
}
@end

