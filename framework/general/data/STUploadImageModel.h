//
//  STUploadImageModel.h
//  framework
//
//  Created by 黄成实 on 2018/6/29.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STUploadImageModel : NSObject

@property(copy, nonatomic)NSString *realUrl;
@property(copy, nonatomic)NSString *objectKey;
@property(copy, nonatomic)NSString *Expires;
@property(copy, nonatomic)NSString *imageTimeStamp;

@end
