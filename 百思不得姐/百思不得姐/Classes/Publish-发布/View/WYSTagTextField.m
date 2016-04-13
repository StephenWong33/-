//
//  WYSTagTextField.m
//  百思不得姐
//
//  Created by 王亚帅 on 15/8/5.
//  Copyright (c) 2015年 Wong Stethen. All rights reserved.
//

#import "WYSTagTextField.h"

@implementation WYSTagTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.placeholder = @"多个标签用逗号或者换行隔开";
        // 设置了占位文字内容以后, 才能设置占位文字的颜色
        [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        self.height = WYSTagH;
    }
    return self;
}


- (void)deleteBackward
{
    !self.deleteBlock ? : self.deleteBlock();
    
    [super deleteBackward];
}

@end
