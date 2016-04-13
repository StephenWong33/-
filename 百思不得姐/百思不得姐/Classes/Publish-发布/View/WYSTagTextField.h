//
//  WYSTagTextField.h
//  百思不得姐
//
//  Created by 王亚帅 on 15/8/5.
//  Copyright (c) 2015年 Wong Stethen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYSTagTextField : UITextField
/** 按了删除键后的回调 */
@property (nonatomic, copy) void (^deleteBlock)();
@end
