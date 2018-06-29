//
//  PassHistoryModel.h
//  framework
//
//  Created by 黄成实 on 2018/6/27.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PassHistoryModel : NSObject

@property(copy, nonatomic)NSString *checkId;
@property(copy, nonatomic)NSString *userUid;
@property(copy, nonatomic)NSString *userName;
@property(copy, nonatomic)NSString *faceUrl;
@property(copy, nonatomic)NSString *startTime;
@property(copy, nonatomic)NSString *licenseNum;
@property(copy, nonatomic)NSString *districtUid;
@property(copy, nonatomic)NSString *createTime;
@property(copy, nonatomic)NSString *pwd;

@end
