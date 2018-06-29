//
//  PageManager.m
//  framework
//
//  Created by 黄成实 on 2018/6/25.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "PageManager.h"
#import "LoginPage.h"

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

}
@end
