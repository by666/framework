//
//  VisitorViewModel.h
//  framework
//
//  Created by by.huang on 2018/5/23.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VisitorModel.h"
@protocol VisitorViewDelegate

-(void)onGeneratePass:(Boolean)success msg:(NSString *)errorMsg;
-(void)onDoTakePhoto;

@end

@interface VisitorViewModel : NSObject
@property(weak, nonatomic)id<VisitorViewDelegate> delegate;
@property(strong, nonatomic)VisitorModel *data;
//生成通行证
-(void)generatePass:(NSString *)name date:(NSString *)date carNum:(NSString *)carNum on:(Boolean)on imagePath:(NSString *)imagePath type:(VisitorType)type;

-(void)doTakePhoto;

@end
