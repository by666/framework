//
//  AddCarViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/19.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CarModel.h"


@protocol AddCarViewDelegate

-(void)onAddCarDatas:(Boolean)success data:(CarModel *)data;

@end


@interface AddCarViewModel : NSObject

@property(strong, nonatomic)CarModel *data;
@property(weak, nonatomic)id <AddCarViewDelegate> delegate;

-(void)addCarData;
-(NSArray *)getCarShortHead;
-(NSArray *)getCarAlphabet;

@end
