//
//  DBHelper.m
//  Shopping
//
//  Created by 聂自强 on 16/2/17.
//  Copyright © 2016年 nieziqiang. All rights reserved.
//

#import "DBHelper.h"
#import "FMDB.h"
#import "SQLCollection.h"
#import "DBdealModel.h"

#define sqlPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"cart.sql"]

@interface DBHelper ()

@property (nonatomic, strong) FMDatabase *db;

@end

@implementation DBHelper


+ (void)initialize{
    
    FMDatabaseQueue *db = [FMDatabaseQueue databaseQueueWithPath:sqlPath];
    NSLog(@"%@" , sqlPath);
    [db inDatabase:^(FMDatabase *db) {
        BOOL result  = [db executeUpdate:cartCreate];
        BOOL result1 = [db executeUpdate:userCreate];
        BOOL result2 = [db executeUpdate:oderCreate];
        
        if (result&&result1&&result2) {
            NSLog(@"创表成功");
        }else{
            NSLog(@"创表失败");
        }
        
    }];

}

+ (BOOL)addDeal:(NSString *)deal_id withUserName:(NSString *)userName{
    FMDatabaseQueue *db = [FMDatabaseQueue databaseQueueWithPath:sqlPath];

    __block BOOL result = NO ;
//    __block int nowCount;
    [db inDatabase:^(FMDatabase *db) {
//        NSString *sqlStr = [NSString stringWithFormat:@"select * from t_cart where user_name =? and dealId = ? ;" ,userName , deal_id ];
        FMResultSet *rs = [db executeQuery:@"select * from t_cart;" ];
        while ([rs next]) {
            if ([[rs  stringForColumn:@"user_name"] isEqualToString:userName] &&[[rs stringForColumn:@"dealId"] isEqualToString:deal_id]) {
                int count = 0;
                count = [rs intForColumn:@"count"] + 1;
                NSString *sqlStr = [NSString stringWithFormat:@"update t_cart set count ='%d'  where dealId ='%@' and user_name ='%@' ;" ,count,deal_id , userName];
                
                result = [db executeUpdate:sqlStr];
            }
        }
            if(!result ) {
                NSString *sqlStr = [NSString stringWithFormat:@"insert into t_cart (dealId , user_name) values ('%@' , '%@');" , deal_id , userName];
                result = [db executeUpdate:sqlStr];
            }
        
    }];
    
    
    return result;
    
}

+(BOOL)modfiyDeal:(NSString *)deal_id withUserName:(NSString *)userName andAdd:(BOOL)isAdd{

    FMDatabaseQueue *db = [FMDatabaseQueue databaseQueueWithPath:sqlPath];
    
    __block BOOL result = NO ;
    
    [db inDatabase:^(FMDatabase *db) {
        
        FMResultSet *rs = [db executeQuery:@"select * from t_cart;" ];
        while ([rs next]) {
            if ([[rs  stringForColumn:@"user_name"] isEqualToString:userName] &&[[rs stringForColumn:@"dealId"] isEqualToString:deal_id]) {
                int count = 0;
                
                if (isAdd) {
                    count = [rs intForColumn:@"count"] + 1;
                    NSString *sqlStr = [NSString stringWithFormat:@"update t_cart set count ='%d'  where dealId ='%@' and user_name ='%@' ;" ,count,deal_id , userName];
                    
                    result = [db executeUpdate:sqlStr];
                }else{
                    count = [rs intForColumn:@"count"] - 1;
                    NSString *sqlStr = [NSString stringWithFormat:@"update t_cart set count ='%d'  where dealId ='%@' and user_name ='%@' ;" ,count,deal_id , userName];
                    
                    result = [db executeUpdate:sqlStr];
                }
                
            }
        }
    
    }];
    return result;
}

+ (BOOL)removeDeal:(NSString *)deal_id withUserName:(NSString *)userName{
    FMDatabaseQueue *db = [FMDatabaseQueue databaseQueueWithPath:sqlPath];
    
    __block BOOL result ;
    [db inDatabase:^(FMDatabase *db) {
        NSString *sqlStr = [NSString stringWithFormat:@"delete from t_cart where dealId ='%@' and  user_name ='%@';" , deal_id , userName];
        result = [db executeUpdate:sqlStr];
    }];
    
    return result;
    
}

+ (NSArray *)getDealsWithUserName:(NSString *)userName{
    
    NSMutableArray *mary = [NSMutableArray array];
    FMDatabaseQueue *db = [FMDatabaseQueue databaseQueueWithPath:sqlPath];
    //查询数据
    [db inDatabase:^(FMDatabase *db) {
        
        NSString *sql = [NSString stringWithFormat:@"select * from t_cart where user_name ='%@';" , userName];
        FMResultSet *rs = [db executeQuery:sql];
        
        while (rs.next) {
            DBdealModel *deal = [[DBdealModel alloc]init];
            
            //1.获取第一列id 的数据
            deal.userName = [rs stringForColumn:@"user_name"];
            //2.获取第二列name的数据
            deal.dealId =[rs stringForColumn:@"dealId"];
            //3.获取第三列age的数据
            deal.count =  [rs intForColumn:@"count"];
            
            [mary addObject:deal];
        }
    }];
    
    return mary;

}

//- (BOOL)selectDealId:(NSString *)deal_id{
//    FMDatabaseQueue *db = [FMDatabaseQueue databaseQueueWithPath:sqlPath];
//    __block BOOL result ;
//    [db inDatabase:^(FMDatabase *db) {
//        FMResultSet *rs = [db executeQuery:@"select * from t_cart;"];
//        while (rs.next) {
//            if ([deal_id isEqualToString:[rs stringForColumn:@"dealId"]]) {
//                result = YES;
//                NSLog(@"存在===");
//                break;
//                
//            }else{
//                result = NO;
//                NSLog(@"不存在===");
//            }
//        }
//    }];
//    
//    
//    return result;
//}

+(BOOL)adduserInfo:(UserModel *)userInfo{
    
    FMDatabaseQueue *db = [FMDatabaseQueue databaseQueueWithPath:sqlPath];
    
    __block BOOL re ;
    [db inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:@"select * from t_user;"];
        while (rs.next) {
            if ([userInfo.userName isEqualToString:[rs stringForColumn:@"user_name"]]) {
                re = YES;
                NSLog(@"存在===");
                break;
                
            }else{
                re = NO;
                NSLog(@"不存在===");
            }
        }
        
    }];
    
    
    __block BOOL result ;
    if (!re){
        [db inDatabase:^(FMDatabase *db) {
            NSString *sqlStr = [NSString stringWithFormat:@"insert into t_user (user_name , user_psd) values ('%@','%@');" , userInfo.userName, userInfo.userPsd];
            result = [db executeUpdate:sqlStr];
            
        }];
        
    }
    
    if (result) {
        NSLog(@"注册成功");
    }
    
    return result;

}

+ (int)dealsCountWithUserName:(NSString *)userName{
    
    FMDatabaseQueue *db = [FMDatabaseQueue databaseQueueWithPath:sqlPath];
    
    __block int nowCount = 0;
//    __block BOOL result;
    
    [db inDatabase:^(FMDatabase *db) {
        NSString *sqlStr = [NSString stringWithFormat:@"select * from t_cart where user_name ='%@';",userName];
        FMResultSet *rs = [db executeQuery:sqlStr];
        
        while (rs.next) {
            nowCount += (int)[rs intForColumn:@"count"];
            NSLog(@"%d" , nowCount);
        }
        
    }];
    return nowCount;
}

+ (BOOL)isExistUser:(UserModel *)userInfo{
    
    FMDatabaseQueue *db = [FMDatabaseQueue databaseQueueWithPath:sqlPath];
    
    __block BOOL re ;
    [db inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:@"select * from t_user;"];
        while (rs.next) {
            if ([userInfo.userName isEqualToString:[rs stringForColumn:@"user_name"]] && [userInfo.userPsd isEqualToString:[rs stringForColumn:@"user_psd"]]) {
                re = YES;
                NSLog(@"存在===");
                break;
                
            }else{
                re = NO;
                NSLog(@"不存在===");
            }
        }
        
    }];
    
    return re;
}

#pragma mark oder

+(BOOL)addOderWithDeal:(DBOderMdoel *)oder{
    
    FMDatabaseQueue *db = [FMDatabaseQueue databaseQueueWithPath:sqlPath];
    
   __block BOOL result = NO ;
    
    
    [db inDatabase:^(FMDatabase *db) {
        NSString *sqlStr = [NSString stringWithFormat:@"insert into t_oder (dealId , user_name , count , start , end , status) values ('%@' , '%@' ,'%d' ,'%@' , '%@','%@' );" , oder.dealId , oder.userName , oder.count, oder.st , oder.et , oder.status];
        result = [db executeUpdate:sqlStr];
    }];
    return result;
}


+ (NSArray *)getOderWithUserName:(NSString *)userName{
    NSMutableArray *mary = [NSMutableArray array];
    FMDatabaseQueue *db = [FMDatabaseQueue databaseQueueWithPath:sqlPath];
    //查询数据
    [db inDatabase:^(FMDatabase *db) {
        
        NSString *sql = [NSString stringWithFormat:@"select * from t_oder where user_name ='%@';" , userName];
        FMResultSet *rs = [db executeQuery:sql];
        
        while (rs.next) {
            DBOderMdoel *oder = [[DBOderMdoel alloc]init];
            
            //1.获取第一列id 的数据
            oder.userName = [rs stringForColumn:@"user_name"];
            //2.获取第二列name的数据
            oder.dealId =[rs stringForColumn:@"dealId"];
            //3.获取第三列age的数据
            oder.count =  [rs intForColumn:@"count"];
            
            oder.st = [rs stringForColumn:@"start"];
            oder.et = [rs stringForColumn:@"end"];
            oder.status = [rs stringForColumn:@"status"];
            
            [mary addObject:oder];
        }
    }];
    
    return mary;


}


@end
