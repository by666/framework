//
//  STCodeView.h
//  framework
//
//  Created by 黄成实 on 2018/5/17.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol STCodeViewDelegate

-(void)onCodeInputStatu:(NSString *)code;

@end

@interface STCodeView : UIView

@property(weak, nonatomic)id<STCodeViewDelegate> delegate;

@end
