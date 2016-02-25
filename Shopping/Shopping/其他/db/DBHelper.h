//
//  DBHelper.h
//  Shopping
//
//  Created by 聂自强 on 16/2/17.
//  Copyright © 2016年 nieziqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"


@interface DBHelper : NSObject

+(BOOL)addDeal:(NSString *)deal_id withUserName:(NSString *)userName;

+(BOOL)removeDeal:(NSString *)deal_id withUserName:(NSString *)userName;

+ (NSArray *)getDealsWithUserName:(NSString *)userName;


+(BOOL)adduserInfo:(UserModel *)userInfo;

/**
 *  查询该用户是否存在
 *
 *  @param userInfo 用户信息
 *
 *  @return 是否
 */
+(BOOL)isExistUser:(UserModel *)userInfo;

//+(BOOL)selectDealId:(NSString *)deal_id;

/**
 *  查询订单个数
 *
 *  @param userName 用户名
 *
 *  @return deals个数
 */
+ (int)dealsCountWithUserName:(NSString *)userName;

@end
