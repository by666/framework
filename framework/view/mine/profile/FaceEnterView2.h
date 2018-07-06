//
//  FaceEnterView2.h
//  framework
//
//  Created by 黄成实 on 2018/6/20.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaceEnterViewModel2.h"

@interface FaceEnterView2 : UIView

-(instancetype)initWithViewModel:(FaceEnterViewModel2 *)viewModel;
-(void)updatePreviewImage:(UIImage *)image;
-(void)onDetectFaceResult:(Boolean)success image:(UIImage *)image tips:(NSString *)tips;

@end
