//
//  FaceEnterView.h
//  framework
//
//  Created by 黄成实 on 2018/5/16.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaceEnterViewModel.h"

@interface FaceEnterView : UIView

-(instancetype)initWithViewModel:(FaceEnterViewModel *)viewModel;
-(void)updateFaceDetectResult:(UIImage *)image;

@end
