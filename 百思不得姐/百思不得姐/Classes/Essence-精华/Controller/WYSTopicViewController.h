//
//  WYSTopicViewController.h
//  百思不得姐
//
//  Created by 王亚帅 on 15/7/27.
//  Copyright (c) 2015年 Wong Stethen. All rights reserved.
//  最基本的帖子控制器

#import <UIKit/UIKit.h>

@interface WYSTopicViewController : UITableViewController
/** 帖子类型(交给子类去实现) */
@property (nonatomic, assign) WYSTopicType type;
@end
