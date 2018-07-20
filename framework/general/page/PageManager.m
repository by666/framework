//
//  PageManager.m
//  framework
//
//  Created by 黄成实 on 2018/6/25.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "PageManager.h"
#import "LoginPage.h"
#import "AccountManager.h"

@interface PageManager()

@property(strong, nonatomic)NSMutableArray *pages;
@end

@implementation PageManager{
    int totalNum;
}
SINGLETON_IMPLEMENTION(PageManager)


-(void)initManager{
    _pages = [[NSMutableArray alloc]init];
}

-(void)pageAppear:(BaseViewController *)page{
    [_pages addObject:page];
    totalNum ++;
    [STLog print:[NSString stringWithFormat:@"打开页面：%@",NSStringFromClass([page class])]];
}

-(void)pageDisappear:(BaseViewController *)page{
    [_pages removeObject:page];
    totalNum --;
    [STLog print:[NSString stringWithFormat:@"离开页面：%@",NSStringFromClass([page class])]];
}


-(void)popToLoginPage:(BaseViewController *)page{
    
    Boolean hasLoginPage = NO;
    for(id controller in page.navigationController.viewControllers){
        if([controller isKindOfClass:[LoginPage class]]){
            hasLoginPage = YES;
            [page.navigationController popToViewController:controller animated:YES];
            break;
        }
        [STLog print:@"队列中的page" content:NSStringFromClass([controller class])];
    }
    
    if(!hasLoginPage){
        [[AccountManager sharedAccountManager] clearUserModel];
        [[AccountManager sharedAccountManager] clearLiveModel];
        [[AccountManager sharedAccountManager] clearMainModel];
        [[AccountManager sharedAccountManager] clearApplyModel];
        [LoginPage show:page needBack:NO];
    }
}
@end
