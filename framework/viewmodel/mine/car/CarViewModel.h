//
//  CarViewModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/19.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CarModel.h"

@protocol CarViewDelegate

-(void)onGetCarDatas:(Boolean)success datas:(NSMutableArray *)datas;
-(void)onDeleteCarModel:(Boolean)succes model:(CarModel *)model;
-(void)onGoAddCarPage;
-(void)onGoPaymentPage:(CarModel *)model;
-(void)onGoPaymentRecordsPage;
-(void)onGoCarDetailPage:(CarModel *)model;

@end

@interface CarViewModel : NSObject

@property(strong, nonatomic)NSMutableArray *datas;
@property(weak, nonatomic)id <CarViewDelegate> delegate;

//获取所有车辆
-(void)getCarDatas;

//获取我名下所有车辆
-(NSMutableArray *)getMyCarDatas;

//获取家属名下所有车辆
-(NSMutableArray *)getFamilyCarDatas;

//删除车辆
-(void)deleteCarModel:(CarModel *)model;

//跳转到添加车辆页面
-(void)goAddCarPage;

//跳转到车辆缴费页面
-(void)goPaymentPage:(CarModel *)model;

//跳转到缴费记录页面
-(void)goPaymentRecordsPage;

//跳转到车辆详情页面
-(void)goCarDetailPage:(CarModel *)model;


@end
