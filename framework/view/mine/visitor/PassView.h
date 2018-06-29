//
//  PassView.h
//  framework
//
//  Created by by.huang on 2018/5/23.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PassModel.h"
#import "PassViewModel.h"

@interface PassView : UIView

-(instancetype)initWithViewModel:(PassViewModel *)viewModel;

@end
