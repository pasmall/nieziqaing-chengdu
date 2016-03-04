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
#import "AffirmViewController.h"
#import "AffirmModel.h"

static bool _selectType = NO;
@interface BoxDealViewController()<UITableViewDataSource , UITableViewDelegate , UIAlertViewDelegate>{
    UIView *_navView;
    UIButton *_backBtn;
    UILabel *_title;
    UIButton *_rightBtn;
    
    UIView *_downView;
    UIButton *_selectBtn;
    UILabel *_sumPrice;
    UIButton *_clearingBtn;
    __block int sum ;
    __block int sumCount ;
    
    UILabel *lab;
    
    
    BOOL _isA;
}

@property (nonatomic , strong)UITableView *tableView;

@property (nonatomic , strong)NSMutableArray *cartDeals;

@property (nonatomic , strong)NSArray *arr;

@property (nonatomic  , strong)NSMutableArray *arrIndexPaths;

@property (nonatomic , strong)NSMutableArray *deleteItems;

@property(nonatomic , strong)NSMutableArray *existItems;


@end


@implementation BoxDealViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    _isA = YES;
    sum = 0;
    sumCount = 0;
    self.view.backgroundColor = RGB(244, 244, 244);
    
    self.cartDeals = [NSMutableArray array];
    self.arr = [NSArray array];
    self.arrIndexPaths = [NSMutableArray array];
    self.deleteItems = [NSMutableArray array];
    self.existItems = [NSMutableArray array];
    
    
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isCartChange:) name:@"isCart" object:nil];
    
}

- (void)isCartChange:(id)sender{
    int x = [[sender object] intValue];
    [self getSelectedItemsWith:x];
    if (x==1) {
        _isA = YES;
        if (self.deleteItems.count < _arr.count) {
            _selectType = YES;
            [_selectBtn setImage:[UIImage imageNamed:@"icon_check_01@2x"] forState:UIControlStateNormal];
            _clearingBtn.backgroundColor =mainColor;
            _clearingBtn.enabled = YES;
        }else{
            _selectType = NO;
            [_selectBtn setImage:[UIImage imageNamed:@"icon_check_02@2x"] forState:UIControlStateNormal];
            _clearingBtn.backgroundColor = RGB(200, 200, 200);
            _clearingBtn.enabled = NO;
        }
    }else{
        _isA = NO;
        if (self.deleteItems.count  == _arr.count) {
            _selectType = YES;
            [_selectBtn setImage:[UIImage imageNamed:@"icon_check_01@2x"] forState:UIControlStateNormal];
        }else{
            _selectType = NO;
            [_selectBtn setImage:[UIImage imageNamed:@"icon_check_02@2x"] forState:UIControlStateNormal];
        }
        
        if (self.deleteItems.count > 0) {
            _clearingBtn.backgroundColor = mainColor;
            _clearingBtn.enabled = YES;
        }else{
            _clearingBtn.enabled = NO;
            _clearingBtn.backgroundColor = RGB(200, 200, 200);
        }
    }
}

static int i = 0;
- (void)getBaiduDeals{
    BaiDuAPI *api = [BaiDuAPI shareBaiDuApi];
    
    [self.arrIndexPaths  removeAllObjects];
    
    [SVProgressHUD showWithStatus:@"努力加载..." maskType:SVProgressHUDMaskTypeClear];
    NSString *httpUrl = @"http://apis.baidu.com/baidunuomi/openapi/dealdetail";
//    sum = 0;
//    sumCount = 0;
    
    
    self.arr =[DBHelper getDealsWithUserName:[AppDataSource sharedDataSource].userName];
//    for (int i =0 ; i < self.arr.count; i++) {
        DBdealModel *model = self.arr[i];
        NSString *httpArg = [NSString stringWithFormat:@"deal_id=%@" , model.dealId];
        NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, httpArg];
        
        [api sendGETRequestWithURLString:urlStr parameters:nil callBack:^(RequestResult result, id object) {
            DealInfoData *data = [DealInfoData objectWithKeyValues:object[@"deal"]];
            [self.cartDeals addObject:data];
            
            sum = sum + model.count * [data.current_price intValue]/100;
            sumCount = sumCount + model.count;
            
            //初始化需要购买的订单
            AffirmModel *affirm = [[AffirmModel alloc]init];
            affirm.dealName = data.min_title;
            affirm.coount = model.count;
            int now =[data.current_price intValue]/100;
            NSString *oneStr = [NSString stringWithFormat:@"￥%d",now];
            affirm.onePrice = oneStr;
            affirm.dealId = model.dealId;
            affirm.userName = model.userName;
            
            [self.existItems addObject:affirm];
            
            
            
            if (self.cartDeals.count == self.arr.count) {
                [_tableView reloadData];
                _sumPrice.text = [NSString stringWithFormat:@"￥%d" , sum];
                NSString *str = [NSString stringWithFormat:@"结算(%d)" , sumCount];
                [_clearingBtn setTitle:str forState:UIControlStateNormal];
                i = 0;
                
                
                
                [SVProgressHUD dismiss];
            }else{
                i = i +1;
                [self getBaiduDeals];
            }
            
        }];
        
//    }
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
    _rightBtn.tag = 66;
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
    
    
    lab = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, 30, 20)];
    lab.text = @"应付:";
    lab.centerY =_downView.height*0.5;
    lab.font = [UIFont systemFontOfSize:12];
    lab.textColor = [UIColor blackColor];
    [_downView addSubview:lab];
    
    _sumPrice = [[UILabel alloc]initWithFrame:CGRectMake(75, 0, 100, 20)];
    _sumPrice.font =[UIFont systemFontOfSize:12];
    _sumPrice.textColor = mainColor;
    _sumPrice.centerY =_downView.height*0.5;
    _sumPrice.text = @"￥0";
    [_downView addSubview:_sumPrice];
    
    _clearingBtn = [[UIButton alloc]initWithFrame:CGRectMake(MainW*2/3, 0, MainW/3, 43.5)];
//    _clearingBtn.backgroundColor = RGB(255, 214, 224);
    _clearingBtn.backgroundColor = mainColor;
    _clearingBtn.titleLabel.font = [UIFont systemFontOfSize:13 weight:5];
    [_clearingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_clearingBtn setTitle:@"结算(0)" forState:UIControlStateNormal];
    [_clearingBtn addTarget:self action:@selector(TapClearingBtn) forControlEvents:UIControlEventTouchUpInside];
    [_downView addSubview:_clearingBtn];


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
    cell.isSelect = ECOn;
    [self.arrIndexPaths addObject:indexPath];
//    if (self.arrIndexPaths.count == self.arr.count) {
//        for (int i = 0; i< _arrIndexPaths.count; i++) {
//            NSIndexPath *indexPath = _arrIndexPaths[i];
//            cartDealCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
//            
//            if (cell.isSelect == ECOff) {
//                [self.deleteItems addObject:cell.DBmodel];
//            }else{
//                
//                AffirmModel *model = [[AffirmModel alloc]init];
//                model.dealName = cell.dealName;
//                model.coount = cell.count;
//                model.onePrice = cell.onePrice;
//                
//                [self.existItems addObject:model];
//            }
//            
//        }
//    }
    
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
    
    if (_rightBtn.tag == 66) {
        [_rightBtn setTitle:@"完成" forState:UIControlStateNormal];
        _title.text = @"编辑购物车";
        [[NSNotificationCenter defaultCenter] postNotificationName:@"cartEdit" object:@"1"];
        _clearingBtn.backgroundColor = RGB(200, 200, 200);
        [_clearingBtn setTitle:@"删除" forState:UIControlStateNormal];
        _backBtn.hidden = YES;
        [_selectBtn setImage:[UIImage imageNamed:@"icon_check_02@2x"] forState:UIControlStateNormal];
        _sumPrice.hidden = YES;
        lab.text = @"全选";
        _selectType = NO;
        [self getSelectedItemsWith:2];
        _rightBtn.tag = 67;
    }else{
        [_rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
        _title.text = @"购物车";
        [[NSNotificationCenter defaultCenter] postNotificationName:@"cartEdit" object:@"2"];
        _clearingBtn.backgroundColor = mainColor;
        [_clearingBtn setTitle:@"结算" forState:UIControlStateNormal];
        _backBtn.hidden = NO;
        [_selectBtn setImage:[UIImage imageNamed:@"icon_check_01@2x"] forState:UIControlStateNormal];
        _sumPrice.hidden = NO;
        lab.text = @"应付:";
        _selectType = YES;
        [self getSelectedItemsWith:1];
        _rightBtn.tag = 66;
    }
    
    
}


- (void)TapSelectBtn{
    _selectType = !_selectType;
    if (_selectType) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"cartEdit" object:@"3"];
        [_selectBtn setImage:[UIImage imageNamed:@"icon_check_01@2x"] forState:UIControlStateNormal];
    }else{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"cartEdit" object:@"4"];
        
        [_selectBtn setImage:[UIImage imageNamed:@"icon_check_02@2x"] forState:UIControlStateNormal];
    }
}

- (void)TapClearingBtn{
    if (_isA) {
        AffirmViewController *VC =  [[AffirmViewController alloc]init];
        VC.dealsArray = self.existItems;
        VC.allPrice =_sumPrice.text;
        [self.navigationController pushViewController:VC animated:YES];
        
    }else{
        UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"提示" message:@"/(ㄒoㄒ)/~~确定要删除被选中的订单吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        alter.tag = 66;
        [alter show];
    
    }
}


- (void)getSelectedItemsWith:(int)type{
    [self.deleteItems removeAllObjects];
    [self.existItems removeAllObjects];
    self.deleteItems = [NSMutableArray array];
    self.existItems = [NSMutableArray array];
    sum = 0;
    sumCount = 0;
    for (int i = 0; i< _arrIndexPaths.count; i++) {
        NSIndexPath *indexPath = _arrIndexPaths[i];
        cartDealCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
        
        if (type == 1) {
            if (cell.isSelect == ECOff) {
                [self.deleteItems addObject:cell.DBmodel];
            }else{
                
                AffirmModel *model = [[AffirmModel alloc]init];
                model.dealName = cell.dealName;
                model.coount = cell.count;
                model.onePrice = cell.onePrice;
                DBdealModel *m = cell.DBmodel;
                model.dealId = m.dealId;
                model.userName = m.userName;
                [self.existItems addObject:model];
                sum = sum + cell.sumPirce;
                sumCount = sumCount + cell.count;
            }
        }else{
            if (cell.isSelect == ECOn) {
                [self.deleteItems addObject:cell.DBmodel];
                sumCount = sumCount + cell.count;
            }else{
                AffirmModel *model = [[AffirmModel alloc]init];
                model.dealName = cell.dealName;
                model.coount = cell.count;
                model.onePrice = cell.onePrice;
                
                [self.existItems addObject:model];
            }
        }
        
        
    }
    if (type == 1) {
        _sumPrice.text = [NSString stringWithFormat:@"￥%d" , sum];
        NSString *str = [NSString stringWithFormat:@"结算(%d)" , sumCount];
        [_clearingBtn setTitle:str forState:UIControlStateNormal];
    }else{
        NSString *str = [NSString stringWithFormat:@"删除(%d)" , sumCount];
        [_clearingBtn setTitle:str forState:UIControlStateNormal];
    }
    
    

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (alertView.tag == 66) {
        
        if (buttonIndex == 0) {
            for (int i = 0; i < _deleteItems.count; i ++) {
                DBdealModel *model = _deleteItems[i];
                [DBHelper removeDeal:model.dealId withUserName:model.userName];
            }
            
            [self tapEdit];
            [self.cartDeals removeAllObjects];
            [self.existItems removeAllObjects];
            sum = 0 ;
            sumCount = 0;
            [self getBaiduDeals];
            
        }else{
        
        
        }
        
    }

}


@end
