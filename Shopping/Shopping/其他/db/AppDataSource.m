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
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"cityId"] == nil) {
            _cityId = @800010000;
        }else{
            _cityId =[[NSUserDefaults standardUserDefaults] objectForKey:@"cityId"];
        }
        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"cityName"] == nil) {
            _cityName = @"成都";
        }else{
            _cityName =[[NSUserDefaults standardUserDefaults] objectForKey:@"cityName"];
        }
        
        
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
    [[NSUserDefaults standardUserDefaults]synchronize];

}

- (void)setUserName:(NSString *)userName{
    _userName = userName;
    [[NSUserDefaults standardUserDefaults] setObject:userName forKey:@"user_name"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}

- (void)setCityId:(NSNumber *)cityId{
    _cityId = cityId;
    [[NSUserDefaults standardUserDefaults] setObject:cityId forKey:@"cityId"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (void)setCityName:(NSString *)cityName{
    _cityName = cityName;
    [[NSUserDefaults standardUserDefaults] setObject:cityName forKey:@"cityName"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

@end
