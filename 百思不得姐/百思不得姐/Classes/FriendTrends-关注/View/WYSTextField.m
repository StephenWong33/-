//
//  WYSTextField.m
//  百思不得姐
//
//  Created by 王亚帅 on 15/7/26.
//  Copyright (c) 2015年 Wong Stethen. All rights reserved.
//

#import "WYSTextField.h"

static NSString * const WYSPlacerholderColorKeyPath = @"_placeholderLabel.textColor";

@implementation WYSTextField

- (void)awakeFromNib
{
    // 设置光标颜色和文字颜色一致
    self.tintColor = self.textColor;
    
    // 不成为第一响应者
    [self resignFirstResponder];
}

/**
 * 当前文本框聚焦时就会调用
 */
- (BOOL)becomeFirstResponder
{
    // 修改占位文字颜色
    [self setValue:self.textColor forKeyPath:WYSPlacerholderColorKeyPath];
    return [super becomeFirstResponder];
}

/**
 * 当前文本框失去焦点时就会调用
 */
- (BOOL)resignFirstResponder
{
    // 修改占位文字颜色
    [self setValue:[UIColor grayColor] forKeyPath:WYSPlacerholderColorKeyPath];
    return [super resignFirstResponder];
}

@end
