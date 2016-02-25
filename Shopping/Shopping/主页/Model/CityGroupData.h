//
//  CityGroupData.h
//  Shopping
//
//  Created by 聂自强 on 15/12/10.
//  Copyright © 2015年 nieziqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityGroupData : NSObject
/** 这组的标题 */
@property (nonatomic, copy) NSString *title;
/** 这组的所有城市 */
@property (nonatomic, strong) NSArray *cities;

@end
