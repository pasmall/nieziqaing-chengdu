//
//  AppDataSource.h
//  Shopping
//
//  Created by 聂自强 on 16/2/22.
//  Copyright © 2016年 nieziqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppDataSource : NSObject

@property (nonatomic , assign)BOOL isLogin;

@property (nonatomic,copy)NSString *userId;

@property (nonatomic,copy) NSString *userName;

@property (nonatomic,copy) NSString *userPsd;

@property (nonatomic , copy)NSNumber *cityId;

@property (nonatomic , copy)NSString *cityName;


+(AppDataSource *)sharedDataSource;
-(void)clearDatas;

@end
