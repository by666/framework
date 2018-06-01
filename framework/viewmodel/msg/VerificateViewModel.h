//
//  VerificateViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/31.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageModel.h"

@protocol VerificateViewDelegate

-(void)onDoAgree:(MessageModel *)model;
-(void)onDoReject:(MessageModel *)model;

@end

@interface VerificateViewModel : NSObject

-(instancetype)initWithModel:(MessageModel *)model;

@property(weak, nonatomic)id<VerificateViewDelegate> delegate;
@property(strong, nonatomic)NSMutableArray *datas;
@property(strong, nonatomic)MessageModel *model;
@property(strong, nonatomic)NSMutableArray *vaildArray;

-(void)doAgree;
-(void)doReject;

@end
