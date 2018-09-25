//
//  STAudioUtil.h
//  framework
//
//  Created by by.huang on 2018/9/21.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STAudioUtil : NSObject

SINGLETON_DECLARATION(STAudioUtil)

-(void)startPlay:(NSString *)filename;
-(void)stopPlay;

@end
