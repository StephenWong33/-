//
//  WYSHttpTools.h
//  百思不得姐
//
//  Created by 王亚帅 on 16/4/13.
//  Copyright © 2016年 Wong Stethen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>
@interface WYSHttpTools : NSObject
singleton_interface(WYSHttpTools)

- (void)GET:(NSString*)URLString parameter:(NSMutableDictionary *)params success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
   failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
