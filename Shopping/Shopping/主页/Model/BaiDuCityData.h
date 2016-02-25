//
//  BaiDuCityData.h
//  Shopping
//
//  Created by 聂自强 on 15/12/17.
//  Copyright © 2015年 nieziqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaiDuCityData : NSObject

@property (nonatomic ,assign)NSNumber *city_id;//城市id
@property (nonatomic ,copy)NSString *city_name;//城市名称
@property (nonatomic ,copy)NSString *short_name;//城市名称简写
@property (nonatomic ,copy)NSString *city_pinyin;//城市名称拼音
@property (nonatomic ,copy)NSString *short_pinyin;//城市名称拼音简写


@end
