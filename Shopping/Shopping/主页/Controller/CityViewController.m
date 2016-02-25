//
//  CityViewController.m
//  Shopping
//
//  Created by 聂自强 on 15/12/9.
//  Copyright © 2015年 nieziqiang. All rights reserved.
//

#import "CityViewController.h"
#import "Common.h"
#import "CityGroupData.h"
#import "NSObject+MJKeyValue.h"




@interface CityViewController ()<UITableViewDelegate , UITableViewDataSource ,UISearchBarDelegate,UISearchResultsUpdating>

@property (nonatomic ,strong)NSArray *CityArray;
@property (nonatomic ,strong)NSMutableArray *SearchCityArray;


@property (nonatomic, strong)UITableView *tabelView;
@property (nonatomic )UISearchController *searchController;

@end

@implementation CityViewController

- (NSMutableArray *)SearchCityArray{
    
    if (!_SearchCityArray) {
        _SearchCityArray = [[NSMutableArray alloc]init];
    }
    return _SearchCityArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    
    self.CityArray = [CityGroupData objectArrayWithFilename:@"cityGroups.plist"];
    
    [self initNav];
    [self initTabelViewAndSearchView];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- init

- (void)initNav{
    
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainW, 64)];
    navView.backgroundColor = navColor;
    [self.view addSubview:navView];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 25, 34, 34);
    [backBtn setImage:[UIImage imageNamed:@"icon_nav_quxiao_normal"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(TapBack) forControlEvents:UIControlEventTouchDown];
    [navView addSubview:backBtn];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    titleLabel.centerX = MainW/2;
    titleLabel.y = 20;
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = hightColor;
    titleLabel.text  = [NSString stringWithFormat:@"当前城市--%@",self.currentCity];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [navView addSubview:titleLabel];

}

- (void)initTabelViewAndSearchView{
    
    _tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, MainW, MainH - 64)];
    _tabelView.dataSource = self;
    _tabelView.delegate = self;
    _tabelView.sectionIndexColor = mainColor;
    [self.view addSubview:_tabelView];
    
    _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    _searchController.searchResultsUpdater = self;
    _searchController.dimsBackgroundDuringPresentation = NO;
    _searchController.hidesNavigationBarDuringPresentation = NO;
    _searchController.searchBar.frame = CGRectMake(0, 0, MainW, 44);
    _searchController.searchBar.placeholder = @"请输入城市名称";
    _searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
//    self.tabelView.tableHeaderView = _searchController.searchBar;
}



#pragma mark -- action

- (void)TapBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.searchController.active) {
        return 1;
    }else{
        return self.CityArray.count;
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.searchController.active) {
       
        return self.SearchCityArray.count;
    }else{

        CityGroupData *data = self.CityArray[section];
        return data.cities.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifer = @"cityCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    if (self.searchController.active) {

        [cell.textLabel setText:self.SearchCityArray[indexPath.row][@"name"]];
    }else{
    
        CityGroupData *data = self.CityArray[indexPath.section];
        [cell.textLabel setText:data.cities[indexPath.row]];
    }
    return cell;
}


#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *barView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainW, 24)];
    barView.backgroundColor  = RGB(255, 236, 238);
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 24)];
    CityGroupData *data = self.CityArray[section];
    label.text = data.title;
    label.font = [UIFont systemFontOfSize:12 weight:20];
    [barView addSubview:label];
    return barView;
    
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (self.searchController.active) {
        return nil;
        
    }else{
        CityGroupData *data = self.CityArray[section];
        return data.title;
    }
}


- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    if (self.searchController.active) {
        return nil;
    }else{
        return [self.CityArray valueForKeyPath:@"title"];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.searchController.active) {
        [[NSNotificationCenter  defaultCenter] postNotificationName:@"CityDidChangeNotification" object:nil userInfo:@{@"CityName":self.SearchCityArray[indexPath.row][@"name"]}];
        
    }else{
        CityGroupData *data = self.CityArray[indexPath.section];
        [[NSNotificationCenter  defaultCenter] postNotificationName:@"CityDidChangeNotification" object:nil userInfo:@{ @"CityName" :data.cities[indexPath.row]}];
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark -UISearchResultsUpdating

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSString *searchString = [self.searchController.searchBar text];
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"name CONTAINS %@ or pinYin CONTAINS %@ or pinYinHead CONTAINS %@",searchString,searchString,searchString];
    if (self.SearchCityArray!= nil) {
        [self.SearchCityArray removeAllObjects];
    }
    //过滤数据
    
    NSString *str = [[NSBundle  mainBundle] pathForResource:@"cities" ofType:@"plist"];
    NSMutableArray *arr = [NSMutableArray arrayWithContentsOfFile:str];
    
    self.SearchCityArray   = [NSMutableArray arrayWithArray:[arr filteredArrayUsingPredicate:preicate]];

    //刷新表格
    [self.tabelView reloadData];
}



- (void)dealloc{
    [_searchController.view removeFromSuperview];
    [_searchController removeFromParentViewController];
}


@end
