//
//  VideoView.h
//  framework
//
//  Created by by.huang on 2018/9/18.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoViewModel.h"
@interface VideoView : UIView


-(instancetype)initWithViewModel:(VideoViewModel *)viewModel callID:(UInt64)callID;
-(void)updateTime:(NSString *)timeStr;

@end
