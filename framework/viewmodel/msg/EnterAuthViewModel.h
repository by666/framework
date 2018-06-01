//
//  EnterAuthViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/30.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageModel.h"
@protocol EnterAuthViewDelegate

-(void)onDoAgree:(MessageModel *)model;
-(void)onDoReject:(MessageModel *)model;

@end

@interface EnterAuthViewModel : NSObject

-(instancetype)initWithData:(MessageModel *)model;

@property(strong, nonatomic)NSMutableArray *datas;
@property(strong, nonatomic)MessageModel *model;

@property(weak, nonatomic)id<EnterAuthViewDelegate> delegate;

-(void)doAgree;
-(void)doReject;

@end
