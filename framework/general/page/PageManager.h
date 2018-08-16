//
//  PageManager.h
//  framework
//
//  Created by 黄成实 on 2018/6/25.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewController.h"
@interface PageManager : NSObject
SINGLETON_DECLARATION(PageManager)

-(void)initManager;
-(void)pageAppear:(BaseViewController *)page;
-(void)pageDisappear:(BaseViewController *)page;
-(void)popToLoginPage:(BaseViewController *)page;
-(BaseViewController *)getCurrentPage;
@end
