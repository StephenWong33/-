//
//  WYSPushGuideView.m
//  百思不得姐
//
//  Created by 王亚帅 on 15/7/26.
//  Copyright (c) 2015年 Wong Stethen. All rights reserved.
//

#import "WYSPushGuideView.h"

@implementation WYSPushGuideView

+ (void)show
{
    NSString *key = @"CFBundleShortVersionString";
    
    // 获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    // 获得沙盒中存储的版本号
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    if (![currentVersion isEqualToString:sanboxVersion]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        WYSPushGuideView *guideView = [WYSPushGuideView viewFromXib];
        guideView.frame = window.bounds;
        [window addSubview:guideView];
        
        // 存储版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (IBAction)close {
    [self removeFromSuperview];
}
@end
