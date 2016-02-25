//
//  FoodViewController.m
//  Shopping
//
//  Created by 聂自强 on 15/12/21.
//  Copyright © 2015年 nieziqiang. All rights reserved.
//

#import "FoodViewController.h"
#import "Common.h"
#import "BaiDuDealData.h"
#import "NSObject+MJKeyValue.h"
#import "FoodCell.h"
#import "MRefreshFooter.h"
#import "SelectedCondition.h"
#import "DealInfoViewController.h"
#import "AppDelegate.h"
#import "BoxDealViewController.h"
#import "LoginViewController.h"

@interface FoodViewController()<UITableViewDataSource , UITableViewDelegate , SelectedConditionDelegate>{
    UIButton *countBtn;
}

@property (nonatomic , strong)UITableView *tableView;
@property (nonatomic , strong)NSMutableArray *deals;

@property (nonatomic , strong)SelectedCondition *conditonView;

@end

@implementation FoodViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self getBaiduDealsWithCityId:_cityId];
    
    UITableView *tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 26, MainW, MainH-26)];
    tabelView.dataSource = self;
    tabelView.delegate =self;
    tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tabelView.showsVerticalScrollIndicator = NO;
    _tableView = tabelView;
    [self.view addSubview:tabelView];
    
    //tableView 添加下拉刷新
    tabelView.footer = [MRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDeals)];
    
    //导航栏
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
    backBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [backBtn setImage:[UIImage imageNamed:@"icon_nav_fanhui_normal"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"icon_nav_fanhui_normal"] forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(backToLast) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 20)];
    
    UIBarButtonItem *leftbarBtn = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem =leftbarBtn;
    self.title = @"食品";
    
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
    UIButton *carBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    carBtn.frame = CGRectMake(0, 0, 44, 44);
    [carBtn setImage:[UIImage imageNamed:@"icon_nav_cart_normal"] forState:UIControlStateNormal];
    [carBtn setImage:[UIImage imageNamed:@"icon_nav_cart_normal"] forState:UIControlStateHighlighted];
    [carBtn addTarget:self action:@selector(TapCar) forControlEvents:UIControlEventTouchUpInside];
    countBtn = [[UIButton alloc]initWithFrame:CGRectMake(25, 8, 12, 12)];
    countBtn.backgroundColor = mainColor;
    countBtn.titleLabel.font = [UIFont systemFontOfSize:8];
    [countBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    countBtn.layer.cornerRadius = 6;
    countBtn.layer.masksToBounds =YES;
    [carBtn addSubview:countBtn];
    
    [rightView addSubview:carBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightView];
    
    _conditonView = [[SelectedCondition alloc]initWithFrame:CGRectMake(0, 64, MainW, 25)];
    _conditonView.delegate =self;
    [self.view addSubview:_conditonView];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
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
    
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    app.rootTabbarVc.tabBar.hidden = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    self.navigationController.navigationBarHidden= NO;

}

#pragma mark  Action
- (void)backToLast{
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    app.rootTabbarVc.tabBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)TapCar{
    
    NSLog(@"购物车");
    if ([AppDataSource sharedDataSource].isLogin) {
        BoxDealViewController *vc = [[BoxDealViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        LoginViewController *vc = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
static int count = 1;
- (void)loadMoreDeals{

    count +=1;
    BaiDuAPI *api = [BaiDuAPI shareBaiDuApi];
    
    NSString *httpUrl = @"http://apis.baidu.com/baidunuomi/openapi/searchdeals";
    NSString *httpArg = [NSString stringWithFormat:@"city_id=%@&cat_ids=326&sort=%d&page=%d&page_size=10" , _cityId ,_conditonView.index,count ];
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, httpArg];
    
    [api sendGETRequestWithURLString:urlStr parameters:nil callBack:^(RequestResult result, id object) {
        
        NSArray *arry = object[@"data"][@"deals"];
        [self.deals addObjectsFromArray:[BaiDuDealData objectArrayWithKeyValuesArray:arry]];
        [_tableView  reloadData];
        [_tableView.footer endRefreshing];
    }];

}


#pragma mark init
- (void)getBaiduDealsWithCityId:(NSNumber *)cityId{
    BaiDuAPI *api = [BaiDuAPI shareBaiDuApi];
    
    NSString *httpUrl = @"http://apis.baidu.com/baidunuomi/openapi/searchdeals";
    NSString *httpArg = [NSString stringWithFormat:@"city_id=%@&cat_ids=326&page_size=10" , cityId];
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, httpArg];
    
    [api sendGETRequestWithURLString:urlStr parameters:nil callBack:^(RequestResult result, id object) {
        
        NSArray *arry = object[@"data"][@"deals"];
        self.deals = [NSMutableArray arrayWithArray:[BaiDuDealData objectArrayWithKeyValuesArray:arry]];
        [_tableView  reloadData];
    }];
    
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.deals.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"deal";
    FoodCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell ==nil) {
        cell = [[FoodCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.dealData = self.deals[indexPath.row];
    
    
    return cell;
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   BaiDuDealData *data = self.deals[indexPath.row];
    NSLog(@"%@" , data.deal_id);
    DealInfoViewController *infoVc = [[DealInfoViewController alloc]init];
    infoVc.dealId = data.deal_id;
    [self.navigationController pushViewController:infoVc animated:YES];
}

#pragma mark -SelectedConditionDelegate
- (void)seletedChangeWithIndex:(int)x{
    
    BaiDuAPI *api = [BaiDuAPI shareBaiDuApi];
    
    NSString *httpUrl = @"http://apis.baidu.com/baidunuomi/openapi/searchdeals";
    NSString *httpArg = [NSString stringWithFormat:@"city_id=%@&cat_ids=326&sort=%d&page_size=10" , _cityId ,x ];
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, httpArg];
    
    [api sendGETRequestWithURLString:urlStr parameters:nil callBack:^(RequestResult result, id object) {
        
        NSArray *arry = object[@"data"][@"deals"];
        self.deals = [NSMutableArray arrayWithArray:[BaiDuDealData objectArrayWithKeyValuesArray:arry]];
        [_tableView  reloadData];
    }];

}


@end
