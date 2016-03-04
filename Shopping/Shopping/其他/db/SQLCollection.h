//
//  SQLCollection.h
//  Shopping
//
//  Created by 聂自强 on 16/2/17.
//  Copyright © 2016年 nieziqiang. All rights reserved.
//

#ifndef SQLCollection_h
#define SQLCollection_h

/**
 *  table create
 */

#define cartCreate  @"create table if not exists t_cart (id  integer primary key autoincrement ,user_name text not null , dealId text not null , count int not null default 1); "

#define oderCreate  @"create table if not exists t_oder(id  integer primary key autoincrement ,user_name text not null , dealId text not null , count int not null , start text not null , end text not null ,  status text not null); "

#define userCreate @"create table if not exists t_user (id integer primary key autoincrement , user_name text not null unique , user_psd varchar(40));"

/**
 *  table insert
 */

#define insertDeal 
#endif /* SQLCollection_h */
