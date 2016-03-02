//
//  NearByViewController.m
//  Shopping
//
//  Created by 聂自强 on 15/12/8.
//  Copyright © 2015年 nieziqiang. All rights reserved.
//

#import "NearByViewController.h"
#import <MapKit/MapKit.h>
#import "Common.h"
#import "BaiDuDealData.h"
#import "NSObject+MJKeyValue.h"
#import "AppDelegate.h"
#import "MapAnnotation.h"

@interface NearByViewController ()< MKMapViewDelegate>{
    
    UILabel *_title;
    
    MKMapView *_mapView;
    

}
@property (nonatomic , strong)NSArray *deals1;

@property (nonatomic , strong)NSArray *deals2;

@property (nonatomic , strong)NSArray *deals3;

@end

@implementation NearByViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNav];
    [self initMapView];
//    [self getBaiduDealsWithCityId:326];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getBaiduDealsWithCityId:(int)catId{
//    BaiDuAPI *api = [BaiDuAPI shareBaiDuApi];
//    
//
//    AppDelegate *dt =  (AppDelegate*)[UIApplication sharedApplication].delegate;
//    
//    
//    NSString *httpUrl = @"http://apis.baidu.com/baidunuomi/openapi/searchdeals";
//    NSString *httpArg = [NSString stringWithFormat:@"city_id=%f&cat_ids=%d&location=%f%2C%f&page_size=22",[AppDataSource sharedDataSource].cityId,catId ,dt.latitude ,dt.longitude ];
//    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, httpArg];
//    
//    [api sendGETRequestWithURLString:urlStr parameters:nil callBack:^(RequestResult result, id object) {
//        
//        NSArray *arry = object[@"data"][@"deals"];
//        self.deals1 = [BaiDuDealData objectArrayWithKeyValuesArray:arry];
//        //添加大头针
//        [self addAnnotation];
//
//    }];
    
}


-(void)setNav{
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainW, 44)];
    navView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navView];
    
    _title = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, MainW- 100, 24)];
    _title.centerX = MainW /2;
    _title.text = @"看看附近的商家吧";
    _title.textAlignment = NSTextAlignmentCenter;
    _title.textColor = [UIColor blackColor];
    _title.font = [UIFont systemFontOfSize:12];
    [navView addSubview:_title];
    
    navView.backgroundColor = RGB(232, 201, 87);
    
}




-(void)initMapView{
    _mapView=[[MKMapView alloc]initWithFrame:CGRectMake(0, 44, MainW, MainH-88)];
    [self.view addSubview:_mapView];
    //设置代理
    _mapView.delegate=self;
    
    
    //用户位置追踪(用户位置追踪用于标记用户当前位置，此时会调用定位服务)
    _mapView.userTrackingMode=MKUserTrackingModeFollow;
    
    //设置地图类型
    _mapView.mapType=MKMapTypeStandard;
    
    
}

#pragma mark 添加大头针
-(void)addAnnotation{
    for (int i =0 ; i < self.deals1.count; i ++) {
        BaiDuDealData *data = self.deals1[i];
        
        NSArray *dicArr  = data.shops;
        NSDictionary *dic = dicArr[0];
        NSLog(@"%@" , dic);
        
        CLLocationCoordinate2D location=CLLocationCoordinate2DMake(39.95, 116.35);
        MapAnnotation *annotation1=[[MapAnnotation alloc]init];
        annotation1.title=data.title;
        annotation1.subtitle=data.description;
        annotation1.coordinate=location;
        [_mapView addAnnotation:annotation1];

    }
    
    
    
    
//    CLLocationCoordinate2D location1=CLLocationCoordinate2DMake(39.95, 116.35);
//    KCAnnotation *annotation1=[[KCAnnotation alloc]init];
//    annotation1.title=@"CMJ Studio";
//    annotation1.subtitle=@"Kenshin Cui's Studios";
//    annotation1.coordinate=location1;
//    [_mapView addAnnotation:annotation1];
//
//    CLLocationCoordinate2D location2=CLLocationCoordinate2DMake(39.87, 116.35);
//    KCAnnotation *annotation2=[[KCAnnotation alloc]init];
//    annotation2.title=@"Kenshin&Kaoru";
//    annotation2.subtitle=@"Kenshin Cui's Home";
//    annotation2.coordinate=location2;
//    [_mapView addAnnotation:annotation2];
}
#pragma mark 更新用户位置，只要用户改变则调用此方法（包括第一次定位到用户位置）
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    NSLog(@"%@",userLocation);
    //设置地图显示范围(如果不进行区域设置会自动显示区域范围并指定当前用户位置为地图中心点)
    //    MKCoordinateSpan span=MKCoordinateSpanMake(0.01, 0.01);
    //    MKCoordinateRegion region=MKCoordinateRegionMake(userLocation.location.coordinate, span);
    //    [_mapView setRegion:region animated:true];
}

@end
