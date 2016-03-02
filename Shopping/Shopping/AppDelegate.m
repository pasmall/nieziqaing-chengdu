//
//  AppDelegate.m
//  Shopping
//
//  Created by 聂自强 on 15/12/8.
//  Copyright © 2015年 nieziqiang. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "NearByViewController.h"
#import "CartViewController.h"
#import "MineViewController.h"
#import "Common.h"


//获得RGB颜色
#define RGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r, g, b)                        RGBA(r, g, b, 1.0f)


@interface AppDelegate ()

@end

@implementation AppDelegate



//设置定位
-(void)setupLocationManager{
    _latitude = 0;
    _longitude = 0;
    _locationManager = [[CLLocationManager alloc] init];
    
    if ([CLLocationManager locationServicesEnabled]) {
        NSLog(@"开始定位");
        _locationManager.delegate = self;
        // distanceFilter是距离过滤器，为了减少对定位装置的轮询次数，位置的改变不会每次都去通知委托，而是在移动了足够的距离时才通知委托程序
        // 它的单位是米，这里设置为至少移动1000再通知委托处理更新;
        _locationManager.distanceFilter = 10.0;
        // kCLLocationAccuracyBest:设备使用电池供电时候最高的精度
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        //开始定位
        [_locationManager startUpdatingLocation];
    }else{
        NSLog(@"定位失败，请确定是否开启定位功能");
    }
}

- (void)initMainVc{
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    
    /**
     分别创建导航控制器和控制器
     */
    HomeViewController *Vc1 = [[HomeViewController  alloc]init];
    UINavigationController *Na1 = [[UINavigationController alloc]initWithRootViewController:Vc1];
    
    NearByViewController *Vc2 = [[NearByViewController  alloc]init];
    UINavigationController *Na2 = [[UINavigationController alloc]initWithRootViewController:Vc2];
    
    CartViewController *Vc3 = [[CartViewController  alloc]init];
    UINavigationController *Na3 = [[UINavigationController alloc]initWithRootViewController:Vc3];
    
    MineViewController *Vc4 = [[MineViewController  alloc]init];
    UINavigationController *Na4 = [[UINavigationController alloc]initWithRootViewController:Vc4];
    
    Vc1.title = @"首页";
    Vc2.title = @"附近";
    Vc3.title = @"消息";
    Vc4.title = @"我的";
    
    NSArray *VcArray = @[Na1,Na2 ,Na3,Na4];
    
    self.rootTabbarVc = [[UITabBarController alloc]init];
    
    [self.rootTabbarVc setViewControllers:VcArray animated:YES];
    
    self.window.rootViewController = self.rootTabbarVc;
    
    UITabBar *tabbar = self.rootTabbarVc.tabBar;
    UITabBarItem *item1 = [tabbar.items objectAtIndex:0];
    UITabBarItem *item2 = [tabbar.items objectAtIndex:1];
    UITabBarItem *item3 = [tabbar.items objectAtIndex:2];
    UITabBarItem *item4 = [tabbar.items objectAtIndex:3];
    
    item1.selectedImage = [[UIImage imageNamed:@"icon_tab_shouye_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item1.image = [[UIImage imageNamed:@"icon_tab_shouye_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    item2.selectedImage = [[UIImage imageNamed:@"icon_tab_fujin_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.image = [[UIImage imageNamed:@"icon_tab_fujin_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    item3.selectedImage = [[UIImage imageNamed:@"tab_icon_selection_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item3.image = [[UIImage imageNamed:@"tab_icon_selection_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    item4.selectedImage = [[UIImage imageNamed:@"icon_tab_wode_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item4.image = [[UIImage imageNamed:@"icon_tab_wode_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    //改变UITabBarItem字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:mainColor,NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    [self.window makeKeyAndVisible];
    
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [AppDataSource sharedDataSource];
    [self initMainVc];
    [self setupLocationManager];
 
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    NSLog(@"didUpdateToLocation----");
    _checkLocation = newLocation;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    NSLog(@"didUpdateToLocation+++");
    //此处locations存储了持续更新的位置坐标值，取最后一个值为最新位置，如果不想让其持续更新位置，则在此方法中获取到一个值之后让locationManager stopUpdatingLocation

    CLLocation *cl = [locations lastObject];
    _latitude = cl.coordinate.latitude;
    _longitude = cl.coordinate.longitude;
    _nowlocation = cl;
    NSLog(@"纬度--%f",_latitude);
    NSLog(@"经度--%f",_longitude);
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"定位失败");
}


@end
