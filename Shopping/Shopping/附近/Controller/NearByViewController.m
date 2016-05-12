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
#import "DealInfoViewController.h"

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
    [self getBaiduDealsWithCityId:326];
    [self getBaiduDealsWithCityId:316];
    [self getBaiduDealsWithCityId:377];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getBaiduDealsWithCityId:(int)catId{
    BaiDuAPI *api = [BaiDuAPI shareBaiDuApi];
    

    AppDelegate *dt =  (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    NSString *cl = [NSString stringWithFormat:@"%f,%f" , dt.longitude, dt.latitude];
    
    NSString *httpUrl = @"http://apis.baidu.com/baidunuomi/openapi/searchdeals";
    NSString *httpArg = [NSString stringWithFormat:@"city_id=%@&cat_ids=%d&radius=30000&location=%@&sort=5&page_size=22",[AppDataSource sharedDataSource].cityId,catId ,cl];
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, httpArg];
    
    [api sendGETRequestWithURLString:urlStr parameters:nil callBack:^(RequestResult result, id object) {
        
        if (catId == 326) {
            NSArray *arry = object[@"data"][@"deals"];
            self.deals1 = [BaiDuDealData objectArrayWithKeyValuesArray:arry];
            //添加大头针
            [self addAnnotation];
        }else if(catId == 316){
            NSArray *arry = object[@"data"][@"deals"];
            self.deals2 = [BaiDuDealData objectArrayWithKeyValuesArray:arry];
            [self addAnnotation1];
        }else{
            NSArray *arry = object[@"data"][@"deals"];
            self.deals3 = [BaiDuDealData objectArrayWithKeyValuesArray:arry];
            [self addAnnotation2];
        }
        
       

    }];
    
}


-(void)setNav{
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainW, 44)];
    navView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navView];
    
    _title = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, MainW- 100, 24)];
    _title.centerX = MainW /2;
    _title.text = @"附近商家";
    _title.textAlignment = NSTextAlignmentCenter;
    _title.textColor = [UIColor whiteColor];
    _title.font = [UIFont systemFontOfSize:12 weight:2];
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
        
        
        NSString *str = [NSString stringWithFormat:@"%@  ￥%d" , data.min_title,[data.current_price intValue]/100];
        
        double d1 = [dic[@"latitude"] doubleValue];
        double d2 = [dic[@"longitude"] doubleValue];
        CLLocationCoordinate2D location=CLLocationCoordinate2DMake(d1, d2);
        MapAnnotation *annotation1=[[MapAnnotation alloc]init];
        annotation1.title=data.title;
        annotation1.subtitle=str;
        annotation1.coordinate=location;
        annotation1.image = [UIImage imageNamed:@"icon_map_cateid_1@2x"];
        annotation1.imgUrlStr = data.tiny_image;
        annotation1.dealId = data.deal_id;
        [_mapView addAnnotation:annotation1];

    }
}
-(void)addAnnotation1{
    for (int i =0 ; i < self.deals2.count; i ++) {
        BaiDuDealData *data = self.deals2[i];
        
        NSArray *dicArr  = data.shops;
        NSDictionary *dic = dicArr[0];
        NSLog(@"%@" , dic);
        
        
        NSString *str = [NSString stringWithFormat:@"%@  ￥%d" , data.min_title,[data.current_price intValue]/100];
        
        double d1 = [dic[@"latitude"] doubleValue];
        double d2 = [dic[@"longitude"] doubleValue];
        CLLocationCoordinate2D location=CLLocationCoordinate2DMake(d1, d2);
        MapAnnotation *annotation1=[[MapAnnotation alloc]init];
        annotation1.title=data.title;
        annotation1.subtitle=str;
        annotation1.coordinate=location;
        annotation1.image = [UIImage imageNamed:@"icon_map_cateid_@2x"];
        annotation1.imgUrlStr = data.tiny_image;
        annotation1.dealId = data.deal_id;
        [_mapView addAnnotation:annotation1];
        
    }
}
-(void)addAnnotation2{
    for (int i =0 ; i < self.deals3.count; i ++) {
        BaiDuDealData *data = self.deals3[i];
        
        NSArray *dicArr  = data.shops;
        NSDictionary *dic = dicArr[0];
        NSLog(@"%@" , dic);
        
        
        NSString *str = [NSString stringWithFormat:@"%@  ￥%d" , data.min_title,[data.current_price intValue]/100];
        
        double d1 = [dic[@"latitude"] doubleValue];
        double d2 = [dic[@"longitude"] doubleValue];
        CLLocationCoordinate2D location=CLLocationCoordinate2DMake(d1, d2);
        MapAnnotation *annotation1=[[MapAnnotation alloc]init];
        annotation1.title=data.title;
        annotation1.subtitle=str;
        annotation1.coordinate=location;
        annotation1.image = [UIImage imageNamed:@"icon_map_cateidz@2x"];
        annotation1.imgUrlStr = data.tiny_image;
        annotation1.dealId = data.deal_id;
        [_mapView addAnnotation:annotation1];
        
    }
}


-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if([annotation isKindOfClass:[MapAnnotation class]]){
    
        static NSString *identfier = @"key1";
        
        MKAnnotationView *annot = [_mapView dequeueReusableAnnotationViewWithIdentifier:identfier];
        
        if (annot == nil) {
            annot = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:identfier];
            annot.canShowCallout = YES;
            annot.calloutOffset = CGPointMake(0, 1);
            
            
            
            NSURL *shopImg = [NSURL URLWithString:((MapAnnotation *)annotation).imgUrlStr];
            UIImageView *imgv = [[UIImageView alloc]init];
            imgv.frame = CGRectMake(0, 0, 40, 50);
            [imgv sd_setImageWithURL:shopImg placeholderImage:[UIImage imageNamed:@"ugc_photo"]];
            annot.leftCalloutAccessoryView = imgv;
            
            
            UIButton *rbtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 20)];
            [rbtn setTitle:@"看一看(⊙o⊙)" forState:UIControlStateNormal];
            rbtn.tag =[((MapAnnotation *)annotation).dealId intValue];
            [rbtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            rbtn.titleLabel.font = [UIFont systemFontOfSize:10 weight:8];
            [rbtn addTarget:self action:@selector(TaprBtn:) forControlEvents:UIControlEventTouchUpInside];
            annot.rightCalloutAccessoryView =rbtn;
        }
    
        annot.annotation = annotation;
        annot.image = ((MapAnnotation *)annotation).image;
        
        return annot;
    }else{
        return nil;
    }

}

#pragma mark 更新用户位置，只要用户改变则调用此方法（包括第一次定位到用户位置）
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    NSLog(@"%@",userLocation);
    //设置地图显示范围(如果不进行区域设置会自动显示区域范围并指定当前用户位置为地图中心点)
    //    MKCoordinateSpan span=MKCoordinateSpanMake(0.01, 0.01);
    //    MKCoordinateRegion region=MKCoordinateRegionMake(userLocation.location.coordinate, span);
    //    [_mapView setRegion:region animated:true];
}


#pragma mark -Action

- (void)TaprBtn:(UIButton *)btn{
    NSLog(@"%ld" , (long)btn.tag);
    
    DealInfoViewController *info = [[DealInfoViewController alloc]init];
    NSString *str = [NSString stringWithFormat:@"%ld" ,(long)btn.tag];
    info.dealId =str;
    [self.navigationController pushViewController:info animated:YES];
}

@end
