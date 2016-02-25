//
//  BoxDealViewController.m
//  Shopping
//
//  Created by 聂自强 on 16/2/18.
//  Copyright © 2016年 nieziqiang. All rights reserved.
//

#import "BoxDealViewController.h"
#import "Common.h"
#import "AppDelegate.h"
#import "cartDealCell.h"
#import "DealInfoData.h"
#import "NSObject+MJKeyValue.h"
#import "DBdealModel.h"

@interface BoxDealViewController()<UITableViewDataSource , UITableViewDelegate>{
    UIView *_navView;
    UIButton *_backBtn;
    UILabel *_title;
    UIButton *_rightBtn;
    
    UIView *_downView;
    UIButton *_selectBtn;
}

@property (nonatomic , strong)UITableView *tableView;

@property (nonatomic , strong)NSMutableArray *cartDeals;

@property (nonatomic , strong)NSArray *arr;
@end


@implementation BoxDealViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = RGB(244, 244, 244);
    
    self.cartDeals = [NSMutableArray array];
    self.arr = [NSArray array];
    [self initNav];
    [self initDownView];
    //读取数据

    [self getBaiduDeals];
    
    UITableView *tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, MainW, MainH-64 - 44)];
    tabelView.dataSource = self;
    tabelView.delegate =self;
    tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tabelView.showsVerticalScrollIndicator = NO;
    _tableView = tabelView;
    [self.view addSubview:tabelView];
    
}

- (void)getBaiduDeals{
    BaiDuAPI *api = [BaiDuAPI shareBaiDuApi];
    
    NSString *httpUrl = @"http://apis.baidu.com/baidunuomi/openapi/dealdetail";
    
    self.arr =[DBHelper getDealsWithUserName:[AppDataSource sharedDataSource].userName];
    for (int i =0 ; i < self.arr.count; i++) {
        
        DBdealModel *model = self.arr[i];
        NSString *httpArg = [NSString stringWithFormat:@"deal_id=%@" , model.dealId];
        NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, httpArg];
        
        [api sendGETRequestWithURLString:urlStr parameters:nil callBack:^(RequestResult result, id object) {
            
            [self.cartDeals addObject:[DealInfoData objectWithKeyValues:object[@"deal"]]];
            if (self.cartDeals.count == self.arr.count) {
                [_tableView reloadData];
            }
            
        }];
        
    }
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
    _title.text = @"购物车";
    _title.textAlignment = NSTextAlignmentCenter;
    _title.textColor = [UIColor blackColor];
    [_navView addSubview:_title];
    
    _rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(MainW- 5-44, 20, 44, 44)];
    _rightBtn.titleLabel.textAlignment  = NSTextAlignmentRight;
    [_rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
    _rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_rightBtn setTitleColor:mainColor forState:UIControlStateNormal];
    [_rightBtn addTarget:self action:@selector(tapEdit) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:_rightBtn];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 63, MainW, 0.5)];
    line.backgroundColor  = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    [_navView addSubview:line];
    
   
}

- (void)initDownView{
    _downView = [[UIView alloc]initWithFrame:CGRectMake(0, MainH - 43.5, MainW, 43.5)];
    _downView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_downView];
    
    _selectBtn = [[UIButton alloc]init];
    _selectBtn.contentMode = UIViewContentModeScaleAspectFit;
    [_selectBtn setImage:[UIImage imageNamed:@"icon_check_01@2x"] forState:UIControlStateNormal];
    [_selectBtn addTarget:self action:@selector(TapSelectBtn) forControlEvents:UIControlEventTouchUpInside];
    _selectBtn.frame = CGRectMake(10, 0, 20, 20);
    
    _selectBtn.centerY = _downView.height*0.5;
    
    [_downView addSubview:_selectBtn];


}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    app.rootTabbarVc.tabBar.hidden = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    self.navigationController.navigationBarHidden= YES;
    
}


#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cartDeals.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"cartDealCell";
    cartDealCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[cartDealCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    cell.dealData = self.cartDeals[indexPath.row];
    cell.DBmodel = self.arr[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

#pragma mark  Action
- (void)backToLast{
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    app.rootTabbarVc.tabBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tapEdit{
    
}

- (void)TapSelectBtn{


}

@end
