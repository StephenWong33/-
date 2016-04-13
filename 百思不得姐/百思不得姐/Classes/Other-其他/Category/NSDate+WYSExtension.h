//
//  NSDate+WYSExtension.h
//  百思不得姐
//
//  Created by 王亚帅 on 15/7/27.
//  Copyright (c) 2015年 Wong Stethen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (WYSExtension)
/**
 * 比较from和self的时间差值
 */
- (NSDateComponents *)deltaFrom:(NSDate *)from;

/**
 * 是否为今年
 */
- (BOOL)isThisYear;

/**
 * 是否为今天
 */
- (BOOL)isToday;

/**
 * 是否为昨天
 */
- (BOOL)isYesterday;
@end
