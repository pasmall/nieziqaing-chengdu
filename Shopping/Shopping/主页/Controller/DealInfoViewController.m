//
//  DealInfoViewController.m
//  Shopping
//
//  Created by 聂自强 on 16/1/13.
//  Copyright © 2016年 nieziqiang. All rights reserved.
//

#import "DealInfoViewController.h"
#import "BaiDuAPI.h"
#import "DealInfoData.h"
#import "NSObject+MJKeyValue.h"
#import "Common.h"
#import "DealInfoHeadCell.h"
#import "DealInfoTitleCell.h"
#import "DealInfoContentCell.h"
#import "DealInfoTipCell.h"
#import "AppDelegate.h"
#import "BoxDealViewController.h"
#import "LoginViewController.h"

@interface DealInfoViewController ()<UITableViewDataSource , UITableViewDelegate>{
    UIButton *btn1;
    UIButton *btn2;
    UIButton *btn3;
    DealInfoHeadCell *imgCell;
    
    UIButton *countBtn;
}

@property (nonatomic ,strong)DealInfoData *deal;

@property (nonatomic,weak)UITableView *tableView;


@property (nonatomic , strong)UIButton *cartBtn;

@property (nonatomic , strong)UIButton *addCartBtn;

@property (nonatomic , strong)UIButton *payBtn;

@end

@implementation DealInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加载数据
    [self getBaiduDeal];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    
    UITableView *tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainW, MainH - 44)];
    tabelView.dataSource = self;
    tabelView.delegate =self;
    tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tabelView.showsVerticalScrollIndicator = NO;
//    tabelView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
    _tableView = tabelView;
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tabelView];
    self.automaticallyAdjustsScrollViewInsets  = NO;
    
    //top
    [self addTopView];
    
    //down
    [self addDownView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self updateCart];
    
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    app.rootTabbarVc.tabBar.hidden = YES;
}

#pragma mark init
- (void)getBaiduDeal{
    BaiDuAPI *api = [BaiDuAPI shareBaiDuApi];
    
    NSString *httpUrl = @"http://apis.baidu.com/baidunuomi/openapi/dealdetail";
    NSString *httpArg = [NSString stringWithFormat:@"deal_id=%@" , _dealId];
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, httpArg];
    
    [api sendGETRequestWithURLString:urlStr parameters:nil callBack:^(RequestResult result, id object) {
        
        self.deal  =  [DealInfoData objectWithKeyValues:object[@"deal"]];
        
        [_tableView reloadData];
    }];
    
}

//创建头部控件
- (void)addTopView{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainW, 64)];
    
    //返回按钮
    btn1 = [[UIButton alloc]init];
    btn1.frame = CGRectMake(10, 20, 44, 44);
    btn1.layer.cornerRadius = 22;
    btn1.layer.masksToBounds = YES;
    [btn1 setImage:[UIImage imageNamed:@"icon_nav_fanhui_normal"] forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    [btn1 addTarget:self action:@selector(tapBtn1) forControlEvents:UIControlEventTouchUpInside];
    
    [topView addSubview:btn1];
    //分享
    btn2 = [[UIButton alloc]init];
    btn2.frame = CGRectMake(MainW - 108, 20, 44, 44);
    btn2.layer.cornerRadius = 22;
    btn2.layer.masksToBounds = YES;
    [btn2 setImage:[UIImage imageNamed:@"icon_nav_fenxiang_normal"] forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    [btn2 addTarget:self action:@selector(tapBtn2) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:btn2];
    //收藏
    btn3 = [[UIButton alloc]init];
    btn3.frame = CGRectMake(MainW - 54, 20, 44, 44);
    btn3.layer.cornerRadius = 22;
    btn3.layer.masksToBounds = YES;
    [btn3 setImage:[UIImage imageNamed:@"detailViewNotFavRed"] forState:UIControlStateNormal];
    btn3.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [topView addSubview:btn3];
    
    [btn3 addTarget:self action:@selector(tapBtn3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];

}

- (void)addDownView{
    
    _cartBtn  = [[UIButton alloc]init];
    _cartBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.05];
    _cartBtn.frame = CGRectMake(0, MainH - 44, MainW / 3, 44);
    
    [_cartBtn setImage:[UIImage imageNamed:@"icon_nav_cart_normal"] forState:UIControlStateNormal];
    [_cartBtn addTarget:self action:@selector(TapCart) forControlEvents:UIControlEventTouchUpInside];
    
    
    countBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 12, 12)];
    countBtn.x = _cartBtn.width / 2 + 12;
    countBtn.y = _cartBtn.height/2 - 15;
    countBtn.backgroundColor = mainColor;
    countBtn.titleLabel.font = [UIFont systemFontOfSize:8];
    [countBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    countBtn.layer.cornerRadius = 6;
    countBtn.layer.masksToBounds =YES;
    
    [_cartBtn addSubview:countBtn];
    [self.view addSubview:_cartBtn];
    
    _addCartBtn  = [[UIButton alloc]init];
    _addCartBtn.backgroundColor = [UIColor colorWithRed:252/255.0 green:209/255.0 blue:9/255.0 alpha:1];
    [_addCartBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [_addCartBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _addCartBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _addCartBtn.frame = CGRectMake(MainW / 3, MainH - 44, MainW / 3 , 44);
    [_addCartBtn addTarget:self action:@selector(TapAddCart) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addCartBtn];
    
    _payBtn  = [[UIButton alloc]init];
    _payBtn.backgroundColor = mainColor;
    _payBtn.frame = CGRectMake(MainW / 3 *2, MainH - 44, MainW / 3 , 44);
    
    [_payBtn setTitle:@"立即抢购" forState:UIControlStateNormal];
    [_payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _payBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_payBtn addTarget:self action:@selector(TapPay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_payBtn];

}


#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        DealInfoHeadCell *head = [[DealInfoHeadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"deal_1"];
        imgCell = head;
        head.data = _deal;
        
        return head;
    }else if (indexPath.row == 1) {
        DealInfoTitleCell *title = [[DealInfoTitleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"deal_2"];
        title.data = _deal;
        return title;
        
    }else if(indexPath.row == 2){
        DealInfoContentCell *content = [[DealInfoContentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"deal_3"];
        content.data = _deal.buy_contents;
        return content;
    
    }else if(indexPath.row == 3){
        DealInfoTipCell *content = [[DealInfoTipCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"deal_4"];
        content.data = _deal.consumer_tips;
        return content;
        
    }else{
        return [[UITableViewCell alloc]init];
    }
    
    
}



#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 200;
    }else if (indexPath.row == 1){
        return 90;
    }else if (indexPath.row == 2){
        NSString *subString = @"&nbsp";
        NSArray *array = [_deal.buy_contents componentsSeparatedByString:subString];
        return array.count *35 + 40;
    }else{
        NSString *subString = @"&nbsp";
        NSArray *array = [_deal.consumer_tips componentsSeparatedByString:subString];
        return  (array.count +4)*35 + 40;
    }
    
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
//    CGFloat y =scrollView.contentOffset.y;
    
//    if (y <0) {
//        
//        imgCell.imageView.frame =CGRectMake(-10, -20, 300, 300);
//
//    }else{
//        
//    }
    
    
}


#pragma mark -- BtnAction

- (void)tapBtn1{
    
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    app.rootTabbarVc.tabBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)tapBtn2{
    
    
}
- (void)tapBtn3{
    
    
}

- (void)TapCart{

    NSLog(@"购物车");
    if ([AppDataSource sharedDataSource].isLogin) {
        BoxDealViewController *vc = [[BoxDealViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        LoginViewController *vc = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)TapAddCart{
    if ([AppDataSource sharedDataSource].isLogin) {
        BOOL result = [DBHelper addDeal:self.dealId withUserName:[AppDataSource sharedDataSource].userName];
        if (result) {
            [self updateCart];
            [MBProgressHUD_Custom showSuccess:@"( ˃᷄˶˶̫˶˂᷅ )  已经加入购物车"];
        }else{
            [MBProgressHUD_Custom showError:@"添加失败了"];
        }
    }else{
        LoginViewController *vc = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
- (void)TapPay{
    
}

- (void)updateCart{
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
}


@end
