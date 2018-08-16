//
//  HabitantCell.m
//  framework
//
//  Created by 黄成实 on 2018/5/18.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "HabitantCell.h"
#import "STEdgeLabel.h"

@interface HabitantCell()

@property(strong, nonatomic)UIImageView *headImageView;
@property(strong, nonatomic)UILabel *titleLabel;
@property(strong, nonatomic)STEdgeLabel *idetifyLabel;
@property(strong, nonatomic)UIImageView *arrowImageView;
@property(strong, nonatomic)UILabel *validDateTitleLabel;
@property(strong, nonatomic)UILabel *validDateLabel;

@end

@implementation HabitantCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}

-(void)initView{
    _headImageView = [[UIImageView alloc]init];
    _headImageView.frame = CGRectMake(STWidth(15), STHeight(20), STHeight(44), STHeight(44));
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = STHeight(22);
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    _headImageView.image = [UIImage imageNamed:@"ic_head"];
    [self.contentView addSubview:_headImageView];
    
    _titleLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentLeft textColor:c16 backgroundColor:nil multiLine:NO];
    _titleLabel.frame = CGRectMake(STWidth(75), STHeight(20), STWidth(100), STHeight(16));
    [self.contentView addSubview:_titleLabel];
    
    _idetifyLabel = [[STEdgeLabel alloc]initWithFont:STFont(10) text:@"" textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    _idetifyLabel.layer.masksToBounds = YES;
    _idetifyLabel.layer.cornerRadius = STWidth(10);
    [self.contentView addSubview:_idetifyLabel];
    
    _validDateTitleLabel = [[UILabel alloc]initWithFont:STFont(14) text:MSG_HABITANT_VALID textAlignment:NSTextAlignmentRight textColor:c12 backgroundColor:nil multiLine:NO];
    CGSize vdSize = [MSG_HABITANT_VALID sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(14)]];
    _validDateTitleLabel.frame = CGRectMake(ScreenWidth - STWidth(43) - vdSize.width, STHeight(26.5), vdSize.width, STHeight(14));
    [self.contentView addSubview:_validDateTitleLabel];
    
    
    _validDateLabel  = [[UILabel alloc]initWithFont:STFont(14) text:@"" textAlignment:NSTextAlignmentLeft textColor:c12 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_validDateLabel];
    
    _arrowImageView = [[UIImageView alloc]init];
    [_arrowImageView setImage:[UIImage imageNamed:@"ic_arrow_right"]];
    _arrowImageView.frame = CGRectMake(ScreenWidth - STWidth(33), (STHeight(84.5) - STWidth(13))/2, STWidth(13), STWidth(13));
    [self.contentView addSubview:_arrowImageView];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.frame = CGRectMake(0, STHeight(84.5)- LineHeight, ScreenWidth,LineHeight);
    lineView.backgroundColor = cline;
    [self.contentView addSubview:lineView];
}


-(void)updateData:(HabitantModel *)model{
    
    if(!IS_NS_STRING_EMPTY(model.headUrl)){
        NSURL *url = [[STUploadImageUtil sharedSTUploadImageUtil]getRealUrl:model.headUrl];
        [_headImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"ic_default"]];
    }

    _titleLabel.text = model.userName;
    
    _idetifyLabel.text = [STPUtil getLiveAttr:model.liveAttr];
    _idetifyLabel.frame = CGRectMake(STWidth(75), STHeight(46),STWidth(54), STWidth(20));
    if([_idetifyLabel.text isEqualToString:MSG_AUTHUSER_PART2_IDENTIFY_MEMBER]){
        _idetifyLabel.backgroundColor = c08;
    }else{
        _idetifyLabel.backgroundColor = c19;
    }
    
    if(model.liveAttr == Live_Owner){
        _arrowImageView.hidden = YES;
        _validDateLabel.text  = MSG_HABITANT_FOREVER;
    }else{
        _arrowImageView.hidden = NO;
        NSString *overdue = [model.overdue stringByReplacingOccurrencesOfString:@"年" withString:@"."];
        overdue = [overdue stringByReplacingOccurrencesOfString:@"月" withString:@"."];
        overdue = [overdue stringByReplacingOccurrencesOfString:@"日" withString:@""];
        _validDateLabel.text = overdue;
    }
    CGSize size = [STPUtil textSize:_validDateLabel.text maxWidth:ScreenWidth font:STFont(14)];
    _validDateLabel.frame = CGRectMake(ScreenWidth - STWidth(43) - size.width, STHeight(43.5), size.width, STHeight(14));
    
}



+(NSString *)identify{
    return NSStringFromClass([HabitantCell class]);
}
@end
