//
//  BaiDuDealData.h
//  Shopping
//
//  Created by 聂自强 on 15/12/17.
//  Copyright © 2015年 nieziqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaiDuDealData : NSObject

@property (nonatomic ,copy)NSString *deal_id;
@property (nonatomic ,copy)NSString *image;
@property (nonatomic ,copy)NSString *tiny_image;
@property (nonatomic ,copy)NSString *title;
@property (nonatomic ,copy)NSString *min_title;
@property (nonatomic ,copy)NSString *total;
@property (nonatomic ,copy)NSString *description;
@property (nonatomic ,copy)NSString *sale_num;
@property (nonatomic ,assign)float score;
@property (nonatomic ,copy)NSString *comment_num;
@property (nonatomic ,copy)NSString *market_price;
@property (nonatomic ,copy)NSString *current_price;
@property (nonatomic ,copy)NSString *promotion_price;
@property (nonatomic ,copy)NSString *publish_time;
@property (nonatomic ,copy)NSString *purchase_deadline;
@property (nonatomic ,copy)NSString *is_reservation_required;
@property (nonatomic ,copy)NSString *distance;
@property (nonatomic ,copy)NSString *shop_num;
@property (nonatomic ,copy)NSString *deal_url;
@property (nonatomic ,copy)NSString *deal_murl;
@property (nonatomic ,strong)NSArray *shops;



@end
