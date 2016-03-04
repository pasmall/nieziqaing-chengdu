//
//  OderViewController.m
//  Shopping
//
//  Created by 聂自强 on 16/3/3.
//  Copyright © 2016年 nieziqiang. All rights reserved.
//

#import "OderViewController.h"
#import "OderViewCell.h"
#import "DBOderMdoel.h"
#import "Common.h"
#import "DealInfoData.h"
#import "NSObject+MJKeyValue.h"
#import "AppDelegate.h"


@interface OderViewController()<UITableViewDataSource , UITableViewDelegate>{
        UIImageView *imgv;
}

@property (nonatomic , strong)NSMutableArray *cartDeals;

@property (nonatomic , strong)NSArray *arr;
@property (nonatomic , strong)UITableView *tableView;

@end


@implementation OderViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGB(224, 224, 224);
    self.navigationController.navigationBarHidden = YES;
    
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    app.rootTabbarVc.tabBar.hidden = YES;
    
    self.cartDeals = [NSMutableArray array];
    self.arr = [NSArray array];
    
    [self initNav];
    
    
    imgv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, MainW, 587*MainW / 373)];
    imgv.contentMode = UIViewContentModeScaleAspectFit;
    [imgv setImage:[UIImage imageNamed:@"oder.jpeg"]];
    [self.view addSubview:imgv];;
    imgv.hidden = YES;
    
    UITableView *tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, MainW, MainH-64)];
    tabelView.dataSource = self;
    tabelView.delegate =self;
    tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tabelView.showsVerticalScrollIndicator = NO;
    tabelView.backgroundColor =RGB(224, 224, 224);
    _tableView = tabelView;
    [self.view addSubview:tabelView];
    
    [self getBaiduDeals];
    
    
   
    
    
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
    
    _title = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, MainW- 130, 44)];
    _title.centerX = MainW /2;
    _title.text = @"所有订单";
    _title.textAlignment = NSTextAlignmentCenter;
    _title.textColor = [UIColor blackColor];
    [_navView addSubview:_title];
    
//    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 63, MainW, 0.5)];
//    line.backgroundColor  = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
//    [_navView addSubview:line];
    
}


static int i = 0;
- (void)getBaiduDeals{
    BaiDuAPI *api = [BaiDuAPI shareBaiDuApi];
    
    
    [SVProgressHUD showWithStatus:@"努力加载..." maskType:SVProgressHUDMaskTypeClear];
    NSString *httpUrl = @"http://apis.baidu.com/baidunuomi/openapi/dealdetail";
    //    sum = 0;
    //    sumCount = 0;
    
    
    self.arr =[DBHelper getOderWithUserName:[AppDataSource sharedDataSource].userName];
    
    
    if (self.arr.count > 0) {
        //    for (int i =0 ; i < self.arr.count; i++) {
        DBOderMdoel *model = self.arr[i];
        NSString *httpArg = [NSString stringWithFormat:@"deal_id=%@" , model.dealId];
        NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, httpArg];
        
        [api sendGETRequestWithURLString:urlStr parameters:nil callBack:^(RequestResult result, id object) {
            DealInfoData *data = [DealInfoData objectWithKeyValues:object[@"deal"]];
            [self.cartDeals addObject:data];
            if (self.cartDeals.count == self.arr.count) {
                [_tableView reloadData];
                
                i = 0;
                
                
                [SVProgressHUD dismiss];
            }else{
                i = i +1;
                [self getBaiduDeals];
            }
            
        }];
    }else{
        [SVProgressHUD dismiss];
        
        imgv.hidden = NO;
    }
   
    
    //    }
}

#pragma mark tabView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cartDeals.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"oderCell";
    OderViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[OderViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    cell.oder = self.arr[indexPath.row];
    cell.deal = self.cartDeals[indexPath.row];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 180;
}


- (void)backToLast{
    
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    app.rootTabbarVc.tabBar.hidden = NO;
    [self.navigationController popToRootViewControllerAnimated:YES];

}
@end
