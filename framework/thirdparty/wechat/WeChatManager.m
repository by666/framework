//
//  WeChatManager.m
//  framework
//
//  Created by 黄成实 on 2018/7/24.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "WeChatManager.h"
#import "STConvertUtil.h"
#import <WXApi.h>

@implementation WeChatManager
SINGLETON_IMPLEMENTION(WeChatManager)

-(void)doShare:(NSString *)title content:(NSString *)content image:(UIImage *)image url:(NSString *)url controller:(UIViewController *)controller{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = content;
    [message setThumbImage:image];
    
    WXWebpageObject *webpageObj = [WXWebpageObject object];
    webpageObj.webpageUrl = url;
    message.mediaObject = webpageObj;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;
    [WXApi sendReq:req];
}
@end
