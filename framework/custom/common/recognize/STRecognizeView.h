//
//  STRecognizeView.h
//  framework
//
//  Created by 黄成实 on 2018/5/29.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecognizeModel.h"

@protocol STRecognizeViewDelegate

-(void)onSelectRecognizeResult:(RecognizeModel *)result;
-(void)onCloseRecongnizeResult;

@end

@interface STRecognizeView : UIView

@property(weak, nonatomic)id<STRecognizeViewDelegate> delegate;
-(instancetype)initWithTitle:(NSString *)title datas:(NSMutableArray *)datas;
-(void)setData : (NSMutableArray *)datas;

@end
