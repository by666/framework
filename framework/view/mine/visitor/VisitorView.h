//
//  VisitorView.h
//  framework
//
//  Created by 黄成实 on 2018/5/22.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VisitorViewModel.h"
#import "VisitorModel.h"
#import "PassModel.h"

@interface VisitorView : UIView

-(instancetype)initWithViewModel:(VisitorViewModel *)model type:(VisitorType)type;
-(void)updateView:(NSString *)imagePath;
-(void)updateTipLabel:(NSString *)errorMsg;
-(void)showGeneratePass:(PassModel *)passModel;

@end
