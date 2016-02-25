//
//  BaiDuAPI.h
//  Shopping
//
//  Created by 聂自强 on 15/12/11.
//  Copyright © 2015年 nieziqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    RequestResultSuccess, // 成功
    RequestResultFailed, // 失败
    RequestResultException, // 异常
} RequestResult;

// 回调方法
typedef void(^RequestCallback)(RequestResult result, id object);

@interface BaiDuAPI : NSObject

+ (BaiDuAPI *)shareBaiDuApi;

/**
 *  POST请求
 *
 *  @param urlString  请求的地址
 *  @param parameters 参数
 *  @param callBack   回调函数
 */
- (void)sendPOSTRequestWithURLString:(NSString *)urlString
                          parameters:(NSDictionary *)parameters
                            callBack:(RequestCallback)callBack;

/**
 *  GET请求
 *
 *  @param urlString  请求的地址
 *  @param parameters 参数
 *  @param callBack   回调函数
 */
- (void)sendGETRequestWithURLString:(NSString *)urlString
                         parameters:(NSDictionary *)parameters
                           callBack:(RequestCallback)callBack;


@end
