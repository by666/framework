
//
//  STCodeView.m
//  framework
//
//  Created by 黄成实 on 2018/5/17.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "STCodeView.h"
@interface STCodeView()<UITextFieldDelegate>

@property(strong, nonatomic)NSMutableArray *views;

@end

@implementation STCodeView

-(instancetype)init{
    if(self == [super init]){
        _views = [[NSMutableArray alloc]init];
        [self initView];
    }
    return self;
}

-(void)initView{
    self.frame = CGRectMake(0, 0, ScreenWidth, STHeight(50));
    for(int i = 0 ; i < 6 ; i ++){
        UITextField *textField = [[UITextField alloc]init];
        textField.frame = CGRectMake(STWidth(43) + STWidth(50) * i, 0, STWidth(38), STHeight(50));
        textField.layer.borderWidth = 1;
        textField.layer.borderColor = [c09 CGColor];
        textField.layer.masksToBounds = YES;
        textField.layer.cornerRadius = STHeight(2);
        textField.textAlignment = NSTextAlignmentCenter;
        textField.font = [UIFont systemFontOfSize:STFont(20)];
        textField.tag = i;
        textField.delegate = self;
        textField.hasValue = @"false";
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.returnKeyType = UIReturnKeyNext;
        [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:textField];
        [_views addObject:textField];
        if(i == 0){
            [textField becomeFirstResponder];
        }
    }
}


- (void)textFieldDidChange:(UITextField *)textField{
    UITextRange * selectedRange = textField.markedTextRange;
    if(selectedRange == nil || selectedRange.empty){
        NSString *text = textField.text;
        if(text.length >= 1){
            textField.hasValue = @"true";
            textField.text = [text substringWithRange: NSMakeRange(0, 1)];
            NSInteger tag = textField.tag;
            if(_delegate){
                [_delegate onCodeInputStatu:[self getCodeStr]];
            }
            if(tag >= [_views count] -1 ){
                return;
            }
            UITextField *nextTextField = [_views objectAtIndex:tag+1];
            [nextTextField becomeFirstResponder];
        }
    }
    

}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@""]){
        textField.text = @"";
        textField.hasValue = @"false";
        NSInteger tag = textField.tag;
        if(tag <= 0){
            return YES;
        }
        UITextField *nextTextField = [_views objectAtIndex:tag-1];
        [nextTextField becomeFirstResponder];
        return NO;
    }
    
    return YES;
}

-(NSString *)getCodeStr{
    NSString *code = @"";
    @synchronized (_views){
        if(!IS_NS_COLLECTION_EMPTY(_views)){
            for(UITextField *textField in _views){
                code = [code stringByAppendingString:textField.text];
                if([textField.hasValue isEqualToString:@"false"]){
                    code = @"";
                    break;
                }
            }
        }
    }
    return code;
}


@end
