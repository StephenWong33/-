//
//  WYSUser.h
//  百思不得姐
//
//  Created by 王亚帅 on 15/8/2.
//  Copyright (c) 2015年 Wong Stethen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYSUser : NSObject
/** 用户名 */
@property (nonatomic, copy) NSString *username;
/** 性别 */
@property (nonatomic, copy) NSString *sex;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;
@end
