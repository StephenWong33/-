//
//  WYSCommentHeaderView.m
//  百思不得姐
//
//  Created by 王亚帅 on 15/8/2.
//  Copyright (c) 2015年 Wong Stethen. All rights reserved.
//

#import "WYSCommentHeaderView.h"

@interface WYSCommentHeaderView()
/** 文字标签 */
@property (nonatomic, weak) UILabel *label;
@end

@implementation WYSCommentHeaderView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"header";
    WYSCommentHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil) { // 缓存池中没有, 自己创建
        header = [[WYSCommentHeaderView alloc] initWithReuseIdentifier:ID];
    }
    return header;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = WYSGlobalBg;

        // 创建label
        UILabel *label = [[UILabel alloc] init];
        label.textColor = WYSRGBColor(67, 67, 67);
        label.width = 200;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:label];
        self.label = label;
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];

    self.label.text = title;
}

@end
