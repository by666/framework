//
//  STTableView.h
//  framework
//
//  Created by 黄成实 on 2018/5/14.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol STTableViewDelegate

@required -(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
@required -(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface STTableView : UIView

@property(weak, nonatomic)id stDelegate;

-(instancetype)initWithFrame:(CGRect)frame delegate:(id)delegate;
-(void)setDataAndCell:(NSMutableArray *)datas cell:(id)cell height:(CGFloat)height identify:(NSString *)identify;

@end
