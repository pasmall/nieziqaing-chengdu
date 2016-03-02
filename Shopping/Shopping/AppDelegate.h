//
//  AppDelegate.h
//  Shopping
//
//  Created by 聂自强 on 15/12/8.
//  Copyright © 2015年 nieziqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreLocation;


@interface AppDelegate : UIResponder <UIApplicationDelegate , CLLocationManagerDelegate>{

    //定位
    CLLocationManager *_locationManager;//用于获取位置
    CLLocation *_checkLocation;//用于保存位置信息

}

@property (strong, nonatomic) UIWindow *window;

/**
 *  主控制器
 */
@property(nonatomic, strong) UITabBarController *rootTabbarVc;

//经度纬度
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;

@property (nonatomic , assign)CLLocation *nowlocation;

@end

