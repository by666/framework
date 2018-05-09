//
//  ByView.h
//  framework
//
//  Created by 黄成实 on 2018/4/18.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ByViewDelegate

-(void)goSystemFacePage;
-(void)goIFlyOnlineFaceDetectPage;
-(void)goIFlyOfflineFaceDetectPage;
-(void)goIFlyOfflineVedioDetectPage;
-(void)goMasonryPage;
-(void)goQRPage;

@end

@interface ByView : UIView

@property (weak, nonatomic) id<ByViewDelegate> byViewDelegate;


@end