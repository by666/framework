//
//  LocalFaceDetectModel.h
//  framework
//
//  Created by 黄成实 on 2018/8/17.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocalFaceDetectModel.h"
#import "LocalFacePositionModel.h"
#import "LocalFaceAngleModel.h"
#import "LocalFaceItemModel.h"

@interface LocalFaceDetectModel : NSObject

@property(copy, nonatomic)NSString *face_token;
@property(assign, nonatomic)double face_probability;
@property(strong, nonatomic)LocalFacePositionModel *location;
@property(strong, nonatomic)LocalFaceAngleModel *angle;


@property(assign, nonatomic)int  age;
@property(assign, nonatomic)double beauty;

@property(strong, nonatomic)LocalFaceItemModel *expression;
@property(strong, nonatomic)LocalFaceItemModel *gender;
@property(strong, nonatomic)LocalFaceItemModel *glasses;
@property(strong, nonatomic)LocalFaceItemModel *race;
@property(strong, nonatomic)LocalFaceItemModel *face_shape;

@end
