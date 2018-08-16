//
//  PassViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/6/27.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VisitorModel.h"
#import "PassModel.h"

@protocol PassViewDelegate<BaseRequestDelegate>

-(void)onGoVisitorPage:(VisitorModel *)visitorModel;
-(void)onDoShare:(VisitorModel *)visitorModel passModel:(PassModel *)passModel;

@end

@interface PassViewModel : NSObject

@property(weak, nonatomic)id<PassViewDelegate> delegate;
@property(strong, nonatomic)VisitorModel *mVisitorModel;
@property(strong, nonatomic)PassModel *mPassModel;

-(void)deletePass:(NSString *)userUid checkId:(NSString *)checkId;
-(void)goVisitorPage;
-(void)doShare;

@end
