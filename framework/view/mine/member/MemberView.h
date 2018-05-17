//
//  MemberView.h
//  framework
//
//  Created by 黄成实 on 2018/5/17.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MemberViewModel.h"

@interface MemberView : UIView

-(instancetype)initWithViewModel:(MemberViewModel *)viewModel;

-(void)updateView;

@end
