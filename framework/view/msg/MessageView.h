//
//  MessageView.h
//  framework
//
//  Created by 黄成实 on 2018/5/29.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageViewModel.h"
@interface MessageView : UIView


-(instancetype)initWithViewModel:(MessageViewModel *)viewModel;
-(void)updateView:(Boolean)hasMoreData;

@end
