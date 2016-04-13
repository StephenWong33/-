//
//  WYSHttpTools.m
//  百思不得姐
//
//  Created by 王亚帅 on 16/4/13.
//  Copyright © 2016年 Wong Stethen. All rights reserved.
//

#import "WYSHttpTools.h"
#import <AFNetworking.h>
@interface WYSHttpTools ()


@end

@implementation WYSHttpTools
singleton_implementation(WYSHttpTools)

- (void)GET:(NSString *)URLString parameter:(NSMutableDictionary *)params success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
     [manger GET:URLString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    if (success) {
        success(task,responseObject);
    }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    if (failure) {
        failure(task,error);
    }
    }];

}



@end
