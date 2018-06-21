//
//  STLocationManager.m
//  framework
//
//  Created by 黄成实 on 2018/6/15.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "STLocationManager.h"


@interface STLocationManager()<CLLocationManagerDelegate>

@property(strong, nonatomic)CLLocationManager *manager;

@end

@implementation STLocationManager
SINGLETON_IMPLEMENTION(STLocationManager)

-(void)setupLocation {
        _manager = [[CLLocationManager alloc] init];
        _manager.delegate = self;
        _manager.desiredAccuracy = kCLLocationAccuracyBest;

        if ([_manager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [_manager requestWhenInUseAuthorization];
            [_manager requestAlwaysAuthorization];
        }
        float osVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
        if (osVersion >= 8) {
            [_manager requestWhenInUseAuthorization];
            [_manager requestAlwaysAuthorization];
        }
}

- (void) getMoLocationWithSuccess:(MoLocationSuccess)success Failure:(MoLocationFailed)failure {
    [self setupLocation];
    successCallBack = [success copy];
    failedCallBack = [failure copy];
    [_manager stopUpdatingLocation];
    [_manager startUpdatingLocation];
}


+ (void) getMoLocationWithSuccess:(MoLocationSuccess)success Failure:(MoLocationFailed)failure {
    [[STLocationManager sharedSTLocationManager] getMoLocationWithSuccess:success Failure:failure];
}




- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    for (CLLocation *loc in locations) {
        CLLocationCoordinate2D l = loc.coordinate;
        double lat = l.latitude;
        double lnt = l.longitude;
        
        successCallBack ? successCallBack(lat, lnt) : nil;
        
        [_manager stopUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    failedCallBack ? failedCallBack(error) : nil;
    if ([error code] == kCLErrorDenied) {
        NSLog(@"访问被拒绝");
    }
    if ([error code] == kCLErrorLocationUnknown) {
        NSLog(@"无法获取位置信息");
    }
}


@end
