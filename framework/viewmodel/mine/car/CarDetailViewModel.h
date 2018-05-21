//
//  CarDetailViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/21.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarModel.h"
#import "TitleContentModel.h"

@protocol CarDetailViewDelegate

-(void)onDeleteCarData;
-(void)onGoPaymentPage;

@end

@interface CarDetailViewModel : NSObject

@property(weak, nonatomic)id<CarDetailViewDelegate> delegate;
@property(strong, nonatomic)CarModel *data;
@property(strong, nonatomic)NSMutableArray *titleDatas;

-(instancetype)initWithModel:(CarModel *)data;

-(void)deleteCarData;
-(void)goPaymentPage;

@end
