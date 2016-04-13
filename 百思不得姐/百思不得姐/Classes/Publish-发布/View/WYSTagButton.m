//
//  WYSTagButton.m
//  百思不得姐
//
//  Created by 王亚帅 on 15/8/5.
//  Copyright (c) 2015年 Wong Stethen. All rights reserved.
//

#import "WYSTagButton.h"

@implementation WYSTagButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
        self.backgroundColor = WYSTagBg;
        self.titleLabel.font = WYSTagFont;
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    [self sizeToFit];
    
    self.width += 3 * WYSTagMargin;
    self.height = WYSTagH;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.x = WYSTagMargin;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + WYSTagMargin;
}

@end
