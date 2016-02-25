//
//  AppDataSource.m
//  Shopping
//
//  Created by 聂自强 on 16/2/22.
//  Copyright © 2016年 nieziqiang. All rights reserved.
//

#import "AppDataSource.h"


static AppDataSource *datas;

@implementation AppDataSource

+(AppDataSource *)sharedDataSource{
    
    static dispatch_once_t fistOnce;
    dispatch_once(&fistOnce, ^{
        datas = [[AppDataSource alloc]init];
    });
    
    return datas;
}


- (instancetype)init{
    self = [super init];
    if (self) {
        _isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"is_login"];
        _userId = @"";
        _userName = [[NSUserDefaults standardUserDefaults] stringForKey:@"user_name"];;
        _userPsd = @"";
        
    }
    
    return self;
}

- (void)clearDatas{
    _isLogin = NO;
    _userId = @"";
    _userName = @"";
    _userPsd = @"";

}

- (void)setIsLogin:(BOOL)isLogin{
    _isLogin = isLogin;
    [[NSUserDefaults standardUserDefaults] setBool:isLogin forKey:@"is_login"];

}

- (void)setUserName:(NSString *)userName{
    _userName = userName;
    [[NSUserDefaults standardUserDefaults] setObject:userName forKey:@"user_name"];
    
}

@end
