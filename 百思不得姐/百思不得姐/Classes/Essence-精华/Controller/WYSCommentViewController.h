//
//  WYSCommentViewController.h
//  百思不得姐
//
//  Created by xiaomage on 15/8/2.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WYSTopic;

@interface WYSCommentViewController : UIViewController
/** 帖子模型 */
@property (nonatomic, strong) WYSTopic *topic;
@end
