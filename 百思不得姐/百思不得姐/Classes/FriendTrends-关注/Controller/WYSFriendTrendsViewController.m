//
//  WYSFriendTrendsViewController.m
//  百思不得姐
//
//  Created by 王亚帅 on 15/7/22.
//  Copyright (c) 2015年 Wong Stethen. All rights reserved.
//

#import "WYSFriendTrendsViewController.h"
#import "WYSRecommendViewController.h"
#import "WYSLoginRegisterViewController.h"

@interface WYSFriendTrendsViewController()

@end

@implementation WYSFriendTrendsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置导航栏标题
    self.navigationItem.title = @"我的关注";
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsClick)];
    
    // 设置背景色
    self.view.backgroundColor = WYSGlobalBg;
}

- (void)friendsClick
{
    WYSRecommendViewController *vc = [[WYSRecommendViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)loginRegister {
    WYSLoginRegisterViewController *login = [[WYSLoginRegisterViewController alloc] init];
    [self presentViewController:login animated:YES completion:nil];
}
@end
