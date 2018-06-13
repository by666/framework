//
//  MemberModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/17.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MemberModel.h"

@implementation MemberModel



+(MemberModel *)buildModel:(NSString *)nickname homeLocator:(NSString *)homeLocator cretype:(int)cretype creid:(NSString *)creid faceUrl:(NSString *)faceUrl districtUid:(NSString *)districtUid userUid:(NSString *)userUid{
    MemberModel *model = [[MemberModel alloc]init];
    model.nickname = nickname;
    model.homeLocator = homeLocator;
    model.cretype = cretype;
    model.creid = creid;
    model.faceUrl = faceUrl;
    model.districtUid = districtUid;
    model.userUid = userUid;
    return model;
}

@end
