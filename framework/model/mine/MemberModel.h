//
//  MemberModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/17.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MemberModel : NSObject<NSCopying>

@property(copy, nonatomic)NSString *identify;

//用户ID
@property(copy, nonatomic)NSString *userUid;
//称呼
@property(copy, nonatomic)NSString *nickname;
//房子id
@property(copy, nonatomic)NSString *homeLocator;
//证件类型,0为身份证
@property(assign, nonatomic)int cretype;
//证件号码
@property(copy, nonatomic)NSString *creid;
//人脸地址
@property(copy, nonatomic)NSString *faceUrl;
//小区ID
@property(copy, nonatomic)NSString *districtUid;

+(MemberModel *)buildModel:(NSString *)nickname homeLocator:(NSString *)homeLocator cretype:(int)cretype creid:(NSString *)creid faceUrl:(NSString *)faceUrl districtUid:(NSString *)districtUid userUid:(NSString *)userUid;

@end
