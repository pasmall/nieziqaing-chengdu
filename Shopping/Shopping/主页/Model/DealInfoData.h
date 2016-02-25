//
//  DealInfoData.h
//  Shopping
//
//  Created by 聂自强 on 16/1/13.
//  Copyright © 2016年 nieziqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DealInfoData : NSObject

@property (nonatomic ,copy)NSString *deal_id;
@property (nonatomic ,copy)NSString *title;
@property (nonatomic ,copy)NSString *description;
@property (nonatomic ,copy)NSString *long_title;
@property (nonatomic ,copy)NSString *market_price;
@property (nonatomic ,copy)NSString *current_price;

@property (nonatomic ,assign)int purchase_deadline;
@property (nonatomic ,assign)int coupon_start_time;
@property (nonatomic ,assign)int coupon_end_time;
@property (nonatomic ,assign)int sale_num;
@property (nonatomic ,assign)BOOL is_reservation_required;
@property (nonatomic ,copy)NSString *image;
@property (nonatomic ,copy)NSString *buy_contents;
@property (nonatomic ,copy)NSString *consumer_tips;
//@property (nonatomic ,copy)NSString *consumer_tips_json;
@property (nonatomic ,copy)NSString *buy_details;
@property (nonatomic ,copy)NSString *shop_description;


@end
