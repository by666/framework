//
//  VisitorViewModel.m
//  framework
//
//  Created by by.huang on 2018/5/23.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "VisitorViewModel.h"
#import "STNetUtil.h"
#import "AccountManager.h"
#import "PassModel.h"
#import "STUploadImageUtil.h"

@implementation VisitorViewModel

-(instancetype)init{
    if(self == [super init]){
        _data = [[VisitorModel alloc]init];
    }
    return self;
}

-(void)generatePass:(NSString *)name date:(NSString *)date carNum:(NSString *)carNum on:(Boolean)on imagePath:(NSString *)imagePath type:(VisitorType)type imageUrl:(NSString *)imageUrl{
    if(_delegate){
        if(IS_NS_STRING_EMPTY(name)){
            return [_delegate onGeneratePassFail:MSG_VISITOR_ERROR_NONAME];
        }
        _data.name = name;
        if(IS_NS_STRING_EMPTY(date)){
            return [_delegate onGeneratePassFail:MSG_VISITOR_ERROR_NODATE];
        }
        _data.visitDate = date;
        if(IS_NS_STRING_EMPTY(carNum) && type == Car){
            return [_delegate onGeneratePassFail:MSG_VISITOR_ERROR_NOCARNUM];
        }
        _data.carNum = carNum;
        if(on){
            if(IS_NS_STRING_EMPTY(imageUrl)){
                if(IS_NS_STRING_EMPTY(imagePath)){
                    return [_delegate onGeneratePassFail:MSG_VISITOR_ERROR_NOFACEDETECT];
                }else{
                    [self upload:imagePath];
                }
            }else{
                [self checkIn:imageUrl];
            }
        
        }else{
            [self upload:imagePath];
        }
    }
}

-(void)doTakePhoto{
    if(_delegate){
        [_delegate onDoTakePhoto];
    }
}

-(void)upload:(NSString *)imagePath{
    if(_delegate){
        [_delegate onRequestBegin];
        if(IS_NS_STRING_EMPTY(imagePath)){
            [self checkIn:@""];
        }else{
            WS(weakSelf)
            [[STUploadImageUtil sharedSTUploadImageUtil]uploadImageForOSS:imagePath success:^(NSString *imageUrl) {
                weakSelf.data.faceUrl =imageUrl;
                [self checkIn:weakSelf.data.faceUrl];
            } failure:^(NSString *errorStr) {
                [weakSelf.delegate onRequestFail:errorStr];
            }];
        }
    }
}


-(void)checkIn:(NSString *)faceUrl{
    if(_delegate){
        LiveModel *liveModel = [[AccountManager sharedAccountManager]getLiveModel];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        dic[@"districtUid"] = liveModel.districtUid;
        if(IS_NS_STRING_EMPTY(faceUrl)){
            faceUrl = @"";
        }
        dic[@"faceUrl"] = faceUrl;
        if(IS_NS_STRING_EMPTY(_data.carNum)){
            _data.carNum = @"";
        }
        dic[@"licenseNum"] = _data.carNum;
        dic[@"startTime"]  = [_data.visitDate stringByReplacingOccurrencesOfString:@"." withString:@"-"];
        dic[@"userName"]  = _data.name;
        
        
        NSString *jsonStr = [dic mj_JSONString];
        WS(weakSelf)
        [STNetUtil post:URL_PRECHECKIN content:jsonStr success:^(RespondModel *respondModel) {
            if([respondModel.status isEqualToString:STATU_SUCCESS]){
                PassModel *model = [PassModel mj_objectWithKeyValues:respondModel.data];
                [weakSelf.delegate onRequestSuccess:respondModel data:model];
            }else{
                [weakSelf.delegate onRequestFail:respondModel.msg];
            }
        } failure:^(int errorCode) {
            [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
        }];
    }
}

-(void)goPassPage:(VisitorModel *)visitorModel passModel:(PassModel *)passModel{
    if(_delegate){
        [_delegate onGoPassPage:visitorModel passModel:passModel];
    }
}
@end

