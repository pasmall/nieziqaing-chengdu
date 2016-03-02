//
//  MapAnnotation.h
//  Shopping
//
//  Created by 聂自强 on 16/3/1.
//  Copyright © 2016年 nieziqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;

@interface MapAnnotation : NSObject<MKAnnotation>

/** 坐标位置 */
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 子标题 */
@property (nonatomic, copy) NSString *subtitle;

@property (nonatomic,strong) UIImage *image;

@end
