//
//  WYSLoginTool.m
//  百思不得姐
//
//  Created by 王亚帅 on 15/8/6.
//  Copyright (c) 2015年 Wong Stethen. All rights reserved.
//

#import "WYSLoginTool.h"
#import "WYSLoginRegisterViewController.h"

@implementation WYSLoginTool

+ (void)setUid:(NSString *)uid
{
    [[NSUserDefaults standardUserDefaults] setObject:uid forKey:@"uid"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getUid
{
    return [self getUid:NO];
}

+ (NSString *)getUid:(BOOL)showLoginController
{
    NSString *uid = [[NSUserDefaults standardUserDefaults] stringForKey:@"uid"];

    NSLog(@"%@",uid);
    if (showLoginController) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            WYSLoginRegisterViewController *login = [[WYSLoginRegisterViewController alloc] init];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:login animated:YES completion:nil];
        });
    }
    
    return uid;
}

@end
