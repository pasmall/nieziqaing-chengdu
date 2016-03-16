//
//  SearchViewController.m
//  Shopping
//
//  Created by 聂自强 on 16/3/7.
//  Copyright © 2016年 nieziqiang. All rights reserved.
//

#import "SearchViewController.h"
#import "AppDelegate.h"
#import "Common.h"
#import "NSObject+MJKeyValue.h"
#import "YouLikeCell.h"
#import "BaiDuDealData.h"
#import "DealInfoViewController.h"

@implementation SearchViewController



- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = RGB(224, 224, 224);
    self.navigationController.navigationBarHidden = YES;
    self.deals = [[NSArray alloc]init];
    
    
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    app.rootTabbarVc.tabBar.hidden = YES;
    
    
    [self initNav];
    
    
    UITableView *tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, MainW, MainH-64)];
    tabelView.dataSource = self;
    tabelView.delegate =self;
    tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tabelView.showsVerticalScrollIndicator = NO;
    tabelView.backgroundColor =RGB(224, 224, 224);
    _tableView = tabelView;
    [self.view addSubview:tabelView];
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

- (void)initNav{
    
    
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainW, 64)];
    navView.backgroundColor = [UIColor whiteColor];
    _navView = navView;
    [self.view addSubview:navView];
    
    
    _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 20, 44, 44)];
    _backBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_backBtn setImage:[UIImage imageNamed:@"icon_nav_fanhui_normal"] forState:UIControlStateNormal];
    [_backBtn setImage:[UIImage imageNamed:@"icon_nav_fanhui_normal"] forState:UIControlStateHighlighted];
    [_backBtn addTarget:self action:@selector(backToLast) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:_backBtn];
    
    _title = [[UITextField alloc]initWithFrame:CGRectMake(0, 27, MainW- 100,30)];
    _title.centerX = MainW /2;
    _title.placeholder = @"请输入关键字";
    _title.textAlignment = NSTextAlignmentCenter;
    _title.textColor = [UIColor blackColor];
    _title.font = [UIFont systemFontOfSize:9 weight:4];
    _title.borderStyle = UITextBorderStyleRoundedRect;
    
    
    [_navView addSubview:_title];
    
    
    
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(MainW-42, 26, 42, 30);
    [searchBtn setImage:[UIImage imageNamed:@"icon_nav_sousuo_normal"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(TapSearch) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:searchBtn];
    
    //    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 63, MainW, 0.5)];
    //    line.backgroundColor  = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    //    [_navView addSubview:line];
    
}




#pragma mark tabView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.deals.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"likeCell";
    YouLikeCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[YouLikeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    cell.dealData = self.deals[indexPath.row];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BaiDuDealData *data = self.deals[indexPath.row];
    DealInfoViewController *vc = [[DealInfoViewController alloc]init];
    vc.dealId = data.deal_id;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)backToLast{
    
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    app.rootTabbarVc.tabBar.hidden = NO;
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (void)TapSearch{

    //关闭键盘
    [_title resignFirstResponder];
    
    BaiDuAPI *api = [BaiDuAPI shareBaiDuApi];
    [SVProgressHUD showWithStatus:@"正在搜索..." maskType:SVProgressHUDMaskTypeClear];
    NSNumber *cityId = [AppDataSource sharedDataSource].cityId;
     
    
    NSString * encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)_title.text, NULL, NULL,  kCFStringEncodingUTF8 ));
    
    NSString *httpUrl = @"http://apis.baidu.com/baidunuomi/openapi/searchdeals";
    NSString *httpArg = [NSString stringWithFormat:@"city_id=%@&keyword=%@" ,cityId,encodedString];
    NSString *urlStr = [[NSString alloc]initWithFormat:@"%@?%@", httpUrl, httpArg];
    
    [api sendGETRequestWithURLString:urlStr parameters:nil callBack:^(RequestResult result, id object) {
        
        NSString *str =object[@"msg"];
        
        if (![str isEqualToString:@"no searched deals"]) {
            NSArray *arry = object[@"data"][@"deals"];
            self.deals = [BaiDuDealData objectArrayWithKeyValuesArray:arry];
            [_tableView  reloadData];
            [SVProgressHUD dismiss];
        }else{
            
            [SVProgressHUD dismiss];
            [MBProgressHUD_Custom showError:@"没有搜索到相关商品"];
        }
        
    }];
}


@end
