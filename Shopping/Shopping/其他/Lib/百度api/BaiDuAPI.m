//
//  BaiDuAPI.m
//  Shopping
//
//  Created by 聂自强 on 15/12/11.
//  Copyright © 2015年 nieziqiang. All rights reserved.
//
#import "AFNetworking.h"
#import "BaiDuAPI.h"

#define  APPKEY  16e785b8b481c57eab000616ce46ea91

@implementation BaiDuAPI

+ (BaiDuAPI *)shareBaiDuApi{
    
    static BaiDuAPI *api = nil;
    static dispatch_once_t once;
    
   dispatch_once(&once, ^{
       api = [[BaiDuAPI alloc]init];
   });
    return api;
}

- (void)getAllCity:(RequestCallback)callBack{
    NSString *httpUrl = @"http://apis.baidu.com/baidunuomi/openapi/cities";
    NSString *httpArg = @"";
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, httpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: @"16e785b8b481c57eab000616ce46ea91" forHTTPHeaderField: @"apikey"];
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                               if (error) {
                                   NSLog(@"Httperror: %@%ld", error.localizedDescription, (long)error.code);
                               } else {
                                   callBack(RequestResultSuccess, response);
                               }
                           }];

}



- (void)sendPOSTRequestWithURLString:(NSString *)urlString parameters:(NSDictionary *)parameters callBack:(RequestCallback)callBack {
    
    // 初始化请求
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
                                                         @"text/plain",
                                                         @"application/json",
                                                         @"text/html", nil];
    manager.requestSerializer.timeoutInterval = 15;
    [manager.requestSerializer setValue:@"16e785b8b481c57eab000616ce46ea91" forHTTPHeaderField:@"apikey"];
    // 发送请求
    [manager POST:urlString
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              // 请求成功
              if (callBack) {
                  // 返回正常数据格式
                  if ([responseObject isKindOfClass:[NSDictionary class]]) {
                      callBack(RequestResultSuccess, responseObject);
                  }
                  // 异常数据格式
                  else {
                      callBack(RequestResultException, responseObject);
                      NSLog(@"数据异常：%@", responseObject);
                  }
              } else {
                  NSLog(@"Request success with responseObject - \n '%@'", responseObject);
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              // 请求失败，返回错误信息
              if (callBack) {
                  callBack(RequestResultFailed, error);
              } else {
                  NSLog(@"Request failed with reason '%@'", [error localizedDescription]);
              }
          }];
}

- (void)sendGETRequestWithURLString:(NSString *)urlString parameters:(NSDictionary *)parameters callBack:(RequestCallback)callBack {
    
    // 初始化请求
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
                                                         @"text/plain",
                                                         @"application/json",
                                                         @"text/html", nil];
    manager.requestSerializer.timeoutInterval = 10;
    
    [manager.requestSerializer setValue:@"16e785b8b481c57eab000616ce46ea91" forHTTPHeaderField:@"apikey"];
    // 发送请求
    [manager GET:urlString
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             // 请求成功
             if (callBack) {
                 // 返回正常数据格式
                 if ([responseObject isKindOfClass:[NSDictionary class]]) {
                     callBack(RequestResultSuccess, responseObject);
                 }
                 // 异常数据格式
                 else {
                     callBack(RequestResultException, responseObject);
                     NSLog(@"数据异常：%@", responseObject);
                 }
             } else {
                 NSLog(@"Request success with responseObject - \n '%@'", responseObject);
             }
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             // 请求失败，返回错误信息
             if (callBack) {
                 callBack(RequestResultFailed, error);
             } else {
                 NSLog(@"Request failed with reason '%@'", [error localizedDescription]);
             }
         }];
}

@end
