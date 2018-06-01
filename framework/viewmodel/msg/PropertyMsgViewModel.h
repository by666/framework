//
//  PropertyMsgViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/6/1.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PropertyMsgModel.h"

@protocol PropertyMsgViewDelegate

-(void)onRequestCallback:(Boolean)success datas:(NSMutableArray *)datas;

@end

@interface PropertyMsgViewModel : NSObject

@property(weak, nonatomic)id<PropertyMsgViewDelegate> delegate;
@property(strong, nonatomic)NSMutableArray *datas;

-(void)requestMoreDatas;
-(void)requestNewDatas;

@end
