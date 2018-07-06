//
//  LiveModel.h
//  framework
//
//  Created by 黄成实 on 2018/6/19.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LiveModel : NSObject<NSCoding>

@property(copy, nonatomic)NSString *districtUid;
@property(copy, nonatomic)NSString *homeLocator;
@property(copy, nonatomic)NSString *userUid;
@property(assign, nonatomic)int liveAttr;
@property(copy, nonatomic)NSString *mainUid;
@property(copy, nonatomic)NSString *nickname;
@property(copy, nonatomic)NSString *overdue;
@property(assign, nonatomic)int allowbyownerFlag;
@property(assign, nonatomic)int defaultHomeFlag;
@property(assign, nonatomic)int delState;
@property(copy, nonatomic)NSString *createTime;
@property(copy, nonatomic)NSString *modifyTime;
@property(copy, nonatomic)NSString *homeFullName;

//状态
@property(assign, nonatomic)int statu;


@end
