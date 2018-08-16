//
//  VerificateViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/31.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageModel.h"

@protocol VerificateViewDelegate<BaseRequestDelegate>


@end

@interface VerificateViewModel : NSObject

-(instancetype)initWithModel:(MessageModel *)model;

@property(weak, nonatomic)id<VerificateViewDelegate> delegate;
@property(strong, nonatomic)NSMutableArray *datas;
@property(strong, nonatomic)MessageModel *model;
@property(strong, nonatomic)NSMutableArray *vaildArray;

-(void)requestData;
-(void)doAgree:(bool)isAgree valid:(int)validType userTime:(NSString *)userTime;

@end
