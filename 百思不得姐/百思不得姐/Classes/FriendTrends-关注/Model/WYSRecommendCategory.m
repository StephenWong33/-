//
//  WYSRecommendCategory.m
//  百思不得姐
//
//  Created by 王亚帅 on 15/7/23.
//  Copyright (c) 2015年 Wong Stethen. All rights reserved.
//

#import "WYSRecommendCategory.h"
#import <MJExtension.h>

@implementation WYSRecommendCategory
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"};
}

//+ (NSString *)replacedKeyFromPropertyName121:(NSString *)propertyName
//{
//    // propertyName == myName == myHeight
//    if ([propertyName isEqualToString:@"ID"]) return @"id";
//    
//    return propertyName;
//}

- (NSMutableArray *)users
{
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}
@end
