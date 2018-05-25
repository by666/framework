//
//  FaceLoginView.h
//  framework
//
//  Created by 黄成实 on 2018/5/10.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaceLoginViewModel.h"

@interface FaceLoginView : UIView

@property(assign, nonatomic)Boolean test;

-(instancetype)initWithViewModel:(FaceLoginViewModel *)viewModel;
-(void)releaseCamera;
-(void)startDetect;

@end