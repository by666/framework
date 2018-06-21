//
//  STLocationManager.h
//  framework
//
//  Created by 黄成实 on 2018/6/15.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^MoLocationSuccess) (double lat, double lng);
typedef void(^MoLocationFailed) (NSError *error);

@interface STLocationManager : NSObject{
    MoLocationSuccess successCallBack;
    MoLocationFailed failedCallBack;
}

SINGLETON_DECLARATION(STLocationManager)

- (void)getMoLocationWithSuccess:(MoLocationSuccess)success Failure:(MoLocationFailed)failure;




@end
