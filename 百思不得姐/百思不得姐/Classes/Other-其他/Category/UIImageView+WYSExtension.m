//
//  UIImageView+WYSExtension.m
//  百思不得姐
//
//  Created by 王亚帅 on 15/8/3.
//  Copyright (c) 2015年 Wong Stethen. All rights reserved.
//

#import "UIImageView+WYSExtension.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (WYSExtension)
- (void)setHeader:(NSString *)url
{
    UIImage *placeholder = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image ? [image circleImage] : placeholder;
    }];
}
@end
