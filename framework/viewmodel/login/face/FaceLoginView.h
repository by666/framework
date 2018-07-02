//
//  FaceEnterView2.h
//  framework
//
//  Created by 黄成实 on 2018/6/20.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaceLoginViewModel.h"

@interface FaceLoginView : UIView

-(instancetype)initWithViewModel:(FaceLoginViewModel *)viewModel;
-(void)updatePreviewImage:(UIImage *)image;
-(void)onDetectFaceResult:(Boolean)success image:(UIImage *)image tips:(NSString *)tips;
-(void)onProgress:(double)progress;

@end
