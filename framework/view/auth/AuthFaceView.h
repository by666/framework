//
//  AuthFaceView.h
//  framework
//
//  Created by 黄成实 on 2018/5/28.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AuthFaceViewModel.h"

@interface AuthFaceView : UIView

-(instancetype)initWithViewModel:(AuthFaceViewModel *)viewModel;
-(void)updateView:(NSString *)imagePath;
-(void)onCommitFinish;

@end
