//
//  WYSTopicPictureView.h
//  百思不得姐
//
//  Created by 王亚帅 on 15/7/29.
//  Copyright (c) 2015年 Wong Stethen. All rights reserved.
//  图片帖子中间的内容

#import <UIKit/UIKit.h>
@class WYSTopic;

@interface WYSTopicPictureView : UIView
/** 帖子数据 */
@property (nonatomic, strong) WYSTopic *topic;
@end
