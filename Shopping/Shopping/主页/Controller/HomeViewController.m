//
//  HomeViewController.m
//  Shopping
//
//  Created by 聂自强 on 15/12/8.
//  Copyright © 2015年 nieziqiang. All rights reserved.
//

#import "HomeViewController.h"
#import "CityViewController.h"
#import "Common.h"
#import "MImageCell.h"
#import "MRefreshHeader.h"
#import "MenuCell.h"
#import "MHotCell.h"
#import "MRushCell.h"
#import "BaiDuCityData.h"
#import "BaiduDealsData.h"
#import "BaiDuDealData.h"
#import "BaiDuShopData.h"
#import "NSObject+MJKeyValue.h"
#import "FoodViewController.h"
#import "AppDelegate.h"
#import "NetworkSingleton.h"
#import "DiscountCell.h"
#import "DiscountModel.h"
#import "DiscountViewController.h"
#import "DiscountOCViewController.h"
#import "YouLikeCell.h"
#import "DealInfoViewController.h"
#import "BoxDealViewController.h"
#import "LoginViewController.h"
#import "ServiceViewController.h"
#import "HotelViewController.h"
#import "EntertainmentViewController.h"
#import "WebViewController.h"
#import "SearchViewController.h"


@interface HomeViewController ()<UITableViewDataSource , UITableViewDelegate , UIScrollViewDelegate,MenuCellDelegate , DiscountDelegate , RushDelegate>{
    UIButton *cityBtn;
    UITableView *_tableView;
    UIView *_navView;
    UILabel *_searchLab;
    UIImageView *_arrowImage;
    UIView *_searchView;
    UIStatusBarStyle _barStyle;
    NSNumber *_cityId;
    
    NSMutableArray *_discountArray;
    
    UIButton *countBtn;

}

@property (nonatomic , strong)NSArray *cities;
@property (nonatomic , strong)NSArray *deals;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _discountArray = [[NSMutableArray alloc] init];
    _cityId = [AppDataSource sharedDataSource].cityId;
    [self getBaiDuCityData];
    [self getBaiduDealsWithCityId:_cityId];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    _barStyle = UIStatusBarStyleLightContent;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CityDidChange:) name:@"CityDidChangeNotification" object:nil];
    
    
    
    UITableView *tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainW, MainH - 44)];
    tabelView.dataSource = self;
    tabelView.delegate =self;
    tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tabelView.showsVerticalScrollIndicator = NO;
    _tableView = tabelView;
    [self.view addSubview:tabelView];
    self.automaticallyAdjustsScrollViewInsets  = NO;
    
    
    [self setUpTableView];
    [self initNav];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if ([AppDataSource sharedDataSource].isLogin) {
        
        int count = (int)[DBHelper dealsCountWithUserName:[AppDataSource sharedDataSource].userName];
        
        if (count > 0 && count < 10) {
            NSString *str = [NSString stringWithFormat:@"%d" ,count];
            [countBtn setTitle:str forState:UIControlStateNormal];
            countBtn.hidden = NO;
        }else if (count == 0){
            countBtn.hidden = YES;
        }else{
            [countBtn setTitle:@"*" forState:UIControlStateNormal];
            countBtn.hidden = NO;
        }
    }else{
        countBtn.hidden = YES;
    }
    self.navigationController.navigationBarHidden= YES;
    [[UIApplication sharedApplication] setStatusBarStyle:_barStyle animated:YES];
  
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Notification

- (void)CityDidChange:(NSNotification *)sender{
    
    [cityBtn setTitle:sender.userInfo[@"CityName"] forState:UIControlStateNormal];
    [[AppDataSource sharedDataSource] setCityName:sender.userInfo[@"CityName"]];
    
    for (int i = 0 ; i < self.cities.count; i++) {
        BaiDuCityData *city = self.cities[i];
        if ([city.short_name isEqualToString:sender.userInfo[@"CityName"]]) {
            _cityId = city.city_id;
            [[AppDataSource sharedDataSource] setCityId:city.city_id];
            [self getBaiduDealsWithCityId:_cityId];
        }
    }
    
}


#pragma mark init
- (void)initNav{
    
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainW, 64)];
    navView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    _navView = navView;
    [self.view addSubview:navView];
    
    //城市
    cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cityBtn.frame = CGRectMake(10, 30, 40, 24);
    cityBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [cityBtn setTitle:[AppDataSource sharedDataSource].cityName forState:UIControlStateNormal];
    [cityBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    [cityBtn addTarget:self action:@selector(TapCtiy) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:cityBtn];
    UIImageView *arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(cityBtn.frame), 36, 13, 10)];
    [arrowImage setImage:[UIImage imageNamed:@"citySelectArrow"]];
    arrowImage.contentMode = UIViewContentModeScaleAspectFit;
    _arrowImage = arrowImage;
    [navView addSubview:arrowImage];
    
    //购物车
    UIButton *mapBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    mapBtn.frame = CGRectMake(MainW-42, 26, 42, 30);
    [mapBtn setImage:[UIImage imageNamed:@"icon_nav_cart_normal"] forState:UIControlStateNormal];
    [mapBtn addTarget:self action:@selector(TapMap:) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:mapBtn];
    
    countBtn = [[UIButton alloc]initWithFrame:CGRectMake(22, 0, 12, 12)];
    countBtn.backgroundColor = mainColor;
    countBtn.titleLabel.font = [UIFont systemFontOfSize:8];
    [countBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    countBtn.layer.cornerRadius = 6;
    countBtn.layer.masksToBounds =YES;
    [mapBtn addSubview:countBtn];
    
    //搜索框
    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(arrowImage.frame)+10, 30, 200, 25)];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapSearch)];
    [searchView addGestureRecognizer:gesture ];
    
    searchView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
    searchView.layer.masksToBounds = YES;
    searchView.layer.cornerRadius = 12;
    _searchView = searchView;
    [navView addSubview:searchView];
    UIImageView *searchImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 3, 15, 15)];
    [searchImage setImage:[UIImage imageNamed:@"icon_nav_sousuo_normal"]];
    [searchView addSubview:searchImage];
    
    UILabel *placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, 150, 25)];
    placeHolderLabel.font = [UIFont boldSystemFontOfSize:13];
    placeHolderLabel.text = @"请输入商家、品类、商圈";
    placeHolderLabel.textColor = [UIColor whiteColor] ;
    _searchLab = placeHolderLabel;
    [searchView addSubview:placeHolderLabel];
    
}

- (void)getBaiDuCityData{
    BaiDuAPI *api = [BaiDuAPI shareBaiDuApi];
    [api sendGETRequestWithURLString:@"http://apis.baidu.com/baidunuomi/openapi/cities" parameters:nil callBack:^(RequestResult result, id object) {
        self.cities = [BaiDuCityData objectArrayWithKeyValuesArray:object[@"cities"]];
    }];
}

- (void)getBaiduDealsWithCityId:(NSNumber *)cityId{
    BaiDuAPI *api = [BaiDuAPI shareBaiDuApi];
    
    NSString *httpUrl = @"http://apis.baidu.com/baidunuomi/openapi/searchdeals";
    NSString *httpArg = [NSString stringWithFormat:@"city_id=%@&page_size=18" , cityId];
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, httpArg];
    
    [api sendGETRequestWithURLString:urlStr parameters:nil callBack:^(RequestResult result, id object) {
 
        NSArray *arry = object[@"data"][@"deals"];
        self.deals = [BaiDuDealData objectArrayWithKeyValuesArray:arry];
        [_tableView  reloadData];
    }];
    
}


#pragma mark  Action



-(void)setUpTableView{
    
    _tableView.header = [MRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

-(void) loadNewData{
    [_tableView  reloadData];
    [_tableView.header endRefreshing];
}

/**
 *  进入选择城市界面
 */
- (void)TapCtiy{
    CityViewController *Vc = [[CityViewController alloc]init];
    Vc.currentCity = cityBtn.titleLabel.text;
    [self presentViewController:Vc animated:YES completion:nil];
    
}

/**
 *  进入地图界面
 */
- (void)TapMap:(UIButton *)btn{
    
     NSLog(@"购物车");
    if ([AppDataSource sharedDataSource].isLogin) {
        BoxDealViewController *vc = [[BoxDealViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        LoginViewController *vc = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    
}
/**
 *  进图搜索界面
 */
- (void)TapSearch{
    
    [self.navigationController pushViewController:[[SearchViewController alloc]init] animated:YES];
}


#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  21;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        MImageCell *cell = [[MImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1" menuArray:[NSMutableArray arrayWithArray:@[@"1.jpg" , @"2.jpg" , @"3.jpg"]]];
        cell.homeVc = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 1){
        MenuCell *cell = [[MenuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        return cell;
    }else if (indexPath.row == 2){
        MHotCell *cell = [[MHotCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell3"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 3){
        MRushCell *cell = [[MRushCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell4"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.rushData = self.deals;
        cell.delegate = self;
        return cell;
    }else if (indexPath.row == 4){
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell5"];
        
        UIView *headView  = [[UIView alloc]init];
        headView.backgroundColor =  [UIColor colorWithRed:74.0/255 green:56.0/255 blue:58.0/255 alpha:0.1];
        headView.frame = CGRectMake(0, 0, MainW, 10);
        [cell addSubview:headView];
        
        UIImageView *imgv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, MainW, 160)];
        [imgv setImage:[UIImage imageNamed:@"hot.jpeg"]];
        imgv.contentMode = UIViewContentModeScaleAspectFill;
        [cell  addSubview:imgv];
        
        for (int i = 0; i < 4; i ++) {
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MainW/2, 80)];
            if (i%2 == 0) {
                btn.x  = 0;
            }else{
                btn.x = MainW/2;
            }
            
            if (i< 2) {
                btn.y = 10;
            }else{
                btn.y = 90;
            }
            
            btn.tag = 10+i;
            
            [btn addTarget:self action:@selector(Tapdiscount:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btn];
        }
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 5){
        
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell6"];
        
        UIView *headView  = [[UIView alloc]init];
        headView.backgroundColor =  [UIColor colorWithRed:74.0/255 green:56.0/255 blue:58.0/255 alpha:0.1];
        headView.frame = CGRectMake(0, 0, MainW, 10);
        [cell addSubview:headView];
        
        UIView *fview = [[UIView alloc]initWithFrame:CGRectMake(0, (cell.height - 34)/2 + 10, 8, 24)];
        fview.backgroundColor = RGBA(255, 36, 111,0.4);
        [cell addSubview:fview];
        
        UILabel *youLike = [[UILabel alloc]initWithFrame:CGRectMake(20, 15, 100, 24)];
        youLike.textColor = [UIColor blackColor];
        youLike.text = @"猜你喜欢";
        youLike.font = [UIFont systemFontOfSize:14 weight:10];
        [cell addSubview:youLike];
        
        UIView *linev = [[UIView  alloc]initWithFrame:CGRectMake(20, 43, MainW - 20 - 5, 0.4)];
        linev.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        [cell addSubview:linev];
        
        cell.userInteractionEnabled= NO;
        
        return cell;
    }else{
        static NSString *str = @"cell7";
        
        YouLikeCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        
        if (!cell) {
            cell = [[YouLikeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell7"];
        }
        
        cell.dealData = self.deals[indexPath.row - 4];
    
        return cell;
    }


}



#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 100;
    }else if (indexPath.row == 1){
        return 90;
    }else if (indexPath.row == 2){
        return 54;
    }else if (indexPath.row == 3){
        return 170;
    }else if (indexPath.row == 4){
        return 170;
    }else if (indexPath.row == 5){
        return 44;
    }else{
        return 90;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row > 5) {
        
        BaiDuDealData *data = self.deals[indexPath.row - 4];
        DealInfoViewController *vc = [[DealInfoViewController alloc]init];
        vc.dealId = data.deal_id;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat y =scrollView.contentOffset.y;
    
    if (y <0) {
        _navView.alpha = 0;
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
        _barStyle = UIStatusBarStyleDefault;
    }else if (y < 34){
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
        _barStyle = UIStatusBarStyleLightContent;
        _navView.alpha = 1;
        _navView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:y/44];
        [cityBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_arrowImage setImage:[UIImage imageNamed:@"citySelectArrow"]];
        _searchView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
        _searchLab.textColor = [UIColor whiteColor];
        
    }else{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
        _barStyle = UIStatusBarStyleDefault;
        _navView.alpha = 1;
        _navView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.98];
        [cityBtn setTitleColor:mainColor forState:UIControlStateNormal];
        [_arrowImage setImage:[UIImage imageNamed:@"icon_arrows_red_down"]];
        _searchView.backgroundColor = [UIColor whiteColor];
        _searchLab.textColor = [UIColor lightGrayColor];
        
        
    }
    

}


#pragma mark - MenuCellDelegate
- (void)selectMenuWithIndex:(int)index{
    /**
     *  隐藏tabbar
     */
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    app.rootTabbarVc.tabBar.hidden = YES;
    
    if (index == 10) {
        FoodViewController *Vc = [[FoodViewController alloc]init];
        Vc.cityId = _cityId;
        [self.navigationController pushViewController:Vc animated:YES];
    }else if (index == 11){
        ServiceViewController *Vc = [[ServiceViewController alloc]init];
        Vc.cityId = _cityId;
        [self.navigationController pushViewController:Vc animated:YES];
    }else if (index == 12){
        HotelViewController *Vc = [[HotelViewController alloc]init];
        Vc.cityId = _cityId;
        [self.navigationController pushViewController:Vc animated:YES];
    
    }else if (index == 13){
        
        EntertainmentViewController *Vc = [[EntertainmentViewController alloc]init];
        Vc.cityId = _cityId;
        [self.navigationController pushViewController:Vc animated:YES];
    }

}

#pragma mark -- RushDelegate
- (void)didSelectRushIndex:(NSInteger)index{
    BaiDuDealData *data = self.deals[index - 100];
    DealInfoViewController *vc = [[DealInfoViewController alloc]init];
    vc.dealId = data.deal_id;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - DiscountDelegate
-(void)didSelectUrl:(NSString *)urlStr withType:(NSNumber *)type withId:(NSNumber *)ID withTitle:(NSString *)title{
    NSNumber *num = [[NSNumber alloc] initWithLong:1];
    if ([type isEqualToValue: num]) {
        DiscountViewController *discountVC = [[DiscountViewController alloc] init];
        discountVC.urlStr = urlStr;
        
        [self.navigationController pushViewController:discountVC animated:YES];
    }else{
        NSLog(@"ID: %@",[ID stringValue]);
        NSString *IDStr = [ID stringValue];
        DiscountOCViewController *disOCVC = [[DiscountOCViewController alloc] init];
        
        disOCVC.ID = IDStr;
        disOCVC.title = title;
        [self.navigationController pushViewController:disOCVC animated:YES];
    }
    
    
    
}
#pragma  discoutbtn

- (void)Tapdiscount:(UIButton *)btn{
    //TODO
    if (btn.tag == 10) {
        WebViewController *web = [[WebViewController alloc]init];
        [web setUrlString:@"http://m.nuomi.com/326/0-0/0-0-0-0-0"];
        web.titleString = @"火锅盛宴";
        [self.navigationController pushViewController:web animated:YES];
    }else if (btn.tag == 11) {
        WebViewController *web = [[WebViewController alloc]init];
        [web setUrlString:@"http://m.nuomi.com/326/0-0/0-0-0-0-0"];
        web.titleString = @"爱宠专享";
        [self.navigationController pushViewController:web animated:YES];
    }
    else if (btn.tag == 12) {
        WebViewController *web = [[WebViewController alloc]init];
        [web setUrlString:@"http://m.nuomi.com/326/0-0/0-0-0-0-0"];
        web.titleString = @"丽人特惠";
        [self.navigationController pushViewController:web animated:YES];
    }
    else if (btn.tag == 13) {
        WebViewController *web = [[WebViewController alloc]init];
        [web setUrlString:@"http://m.nuomi.com/326/0-0/0-0-0-0-0"];
        web.titleString = @"充值特惠";
        [self.navigationController pushViewController:web animated:YES];
    }
    
    

}

@end
