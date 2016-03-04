//
//  OderViewController.m
//  Shopping
//
//  Created by 聂自强 on 16/3/3.
//  Copyright © 2016年 nieziqiang. All rights reserved.
//

#import "OderViewController.h"

@implementation OderViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGB(244, 244, 244);
    self.navigationController.navigationBarHidden = YES;
    
    [self initNav];
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
    _title.text = @"收银台";
    _title.textAlignment = NSTextAlignmentCenter;
    _title.textColor = [UIColor blackColor];
    [_navView addSubview:_title];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 63, MainW, 0.5)];
    line.backgroundColor  = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    [_navView addSubview:line];
    
}



- (void)backToLast{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
