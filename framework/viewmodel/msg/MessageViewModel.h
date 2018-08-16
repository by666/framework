//
//  MessageViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/29.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageModel.h"

@protocol MessageViewDelegate<BaseRequestDelegate>

-(void)onGoPropertyPage;
-(void)onGoSystemPage;
-(void)onGoMessageDetailPage:(MessageModel *)model;
-(void)onDataChange;
-(void)onGoAuthUserPage;

@end

@interface MessageViewModel : NSObject

@property(weak, nonatomic)id<MessageViewDelegate> delegate;
@property(strong, nonatomic)NSMutableArray *datas;

-(void)requestMessageList:(Boolean)isRequestMore;
-(void)goPropertyPage;
-(void)goSystemPage;
-(void)goMessageDetailPage:(MessageModel *)model;
-(void)doReject:(MessageModel *)model;
-(void)doAgree:(MessageModel *)model;
-(void)goAuthUserPage;

@end
