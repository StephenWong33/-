//
//  WYSCommentCell.h
//  百思不得姐
//
//  Created by 王亚帅 on 15/8/2.
//  Copyright (c) 2015年 Wong Stethen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WYSComment;

@interface WYSCommentCell : UITableViewCell
/** 评论 */
@property (nonatomic, strong) WYSComment *comment;
@end
