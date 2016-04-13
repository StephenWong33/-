//
//  WYSNewViewController.m
//  百思不得姐
//
//  Created by 王亚帅 on 15/7/22.
//  Copyright (c) 2015年 Wong Stethen. All rights reserved.
//

#import "WYSNewViewController.h"

@implementation WYSNewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    // 设置背景色
    self.view.backgroundColor = WYSGlobalBg;
}

- (void)tagClick
{
    WYSLogFunc;
}
@end
