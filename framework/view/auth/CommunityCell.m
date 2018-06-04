//
//  CommunityCell.m
//  framework
//
//  Created by 黄成实 on 2018/5/29.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "CommunityCell.h"

@interface CommunityCell()

@property(strong, nonatomic)UILabel *nameLabel;
@property(strong, nonatomic)UILabel *addressLabel;

@end

@implementation CommunityCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}

-(void)initView{

    _nameLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentLeft textColor:c29 backgroundColor:nil multiLine:NO];
    _nameLabel.frame = CGRectMake(STWidth(36), STHeight(12), ScreenWidth - STWidth(72), STHeight(16));
    [self.contentView addSubview:_nameLabel];

    _addressLabel = [[UILabel alloc]initWithFont:STFont(12) text:@"" textAlignment:NSTextAlignmentLeft textColor:c09 backgroundColor:nil multiLine:NO];
    _addressLabel.frame = CGRectMake(STWidth(36), STHeight(34), ScreenWidth - STWidth(72), STHeight(12));
    [self.contentView addSubview:_addressLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(15), 0, ScreenWidth - STWidth(30), LineHeight)];
    lineView.backgroundColor = c17;
    [self.contentView addSubview:lineView];
}


-(void)updateData:(CommunityModel *)model key:(NSString *)keyStr{
    _nameLabel.text = model.name;
    _addressLabel.text = model.address;
    if(!IS_NS_STRING_EMPTY(keyStr)){
        NSMutableAttributedString *nameStr=[[NSMutableAttributedString alloc]initWithString:model.name];
        @synchronized(self) {
            for(int i = 0 ; i < keyStr.length ; i++){
                NSString *temp = [keyStr substringWithRange:NSMakeRange(i, 1)];
                if([model.name containsString:temp]){
                    NSRange range=[[nameStr string]rangeOfString:temp];
                    [nameStr addAttribute:NSForegroundColorAttributeName value:c18 range:range];
                }
            }
        }
        _nameLabel.attributedText = nameStr;
    }

}



+(NSString*)identify{
    return NSStringFromClass([CommunityCell class]);
}

@end
