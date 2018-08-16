//
//  VisitorHistoryModel.h
//  framework
//
//  Created by by.huang on 2018/5/23.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VisitorHistoryModel : NSObject

@property(copy, nonatomic)NSString *faceUrl;
@property(copy, nonatomic)NSString *userName;
@property(copy, nonatomic)NSString *occurTime;
@property(copy, nonatomic)NSString *lastOccurTime;
@property(copy, nonatomic)NSString *userUid;
@property(assign, nonatomic)long checkId;
@property(copy, nonatomic)NSString *pwd;
@property(copy, nonatomic)NSString *districtUid;
@property(copy, nonatomic)NSString *licenseNum;


@end
