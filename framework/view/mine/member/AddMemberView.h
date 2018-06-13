//
//  AddMemberView.h
//  framework
//
//  Created by 黄成实 on 2018/5/17.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddMemberViewModel.h"

@interface AddMemberView : UILabel


-(instancetype)initWithViewModel:(AddMemberViewModel *)viewModel;

-(void)updateView:(NSString *)imagePath;
-(void)saveMember;
-(MemberModel *)getCurrentModel;

-(void)removeView;
@end
