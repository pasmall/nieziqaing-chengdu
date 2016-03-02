//
//  WebViewController.m
//  MAPP
//
//  Created by kawa on 2015/10/15.
//  Copyright © 2015年 Branko. All rights reserved.
//

#import "WebViewController.h"
#import "SVProgressHUD.h"
#import "Common.h"
#import "AppDelegate.h"

@interface WebViewController ()<UIWebViewDelegate>{
    UIButton *_backBtn;
    UILabel *_title;
}



@end

@implementation WebViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNav];
    
    commonweb = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
    
    commonweb.delegate = self;
    commonweb.scalesPageToFit = YES;
    [self.view addSubview:commonweb];
    
    NSURL *url = [NSURL URLWithString:_urlString];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [commonweb loadRequest:req];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    app.rootTabbarVc.tabBar.hidden = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

- (void)initNav{
    
    
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainW, 64)];
    navView.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:navView];
    
    
     _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 20, 44, 44)];
    _backBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_backBtn setImage:[UIImage imageNamed:@"icon_nav_fanhui_normal"] forState:UIControlStateNormal];
    [_backBtn setImage:[UIImage imageNamed:@"icon_nav_fanhui_normal"] forState:UIControlStateHighlighted];
    [_backBtn addTarget:self action:@selector(backToLast) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:_backBtn];
    
    _title = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, MainW- 130, 44)];
    _title.centerX = MainW /2;
    _title.text = _titleString;
    _title.textAlignment = NSTextAlignmentCenter;
    _title.textColor = [UIColor blackColor];
    [navView addSubview:_title];
    
    //    _rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(MainW- 5-44, 20, 44, 44)];
    //    _rightBtn.titleLabel.textAlignment  = NSTextAlignmentRight;
    //    [_rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
    //    _rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    //    [_rightBtn setTitleColor:mainColor forState:UIControlStateNormal];
    //    [_rightBtn addTarget:self action:@selector(tapEdit) forControlEvents:UIControlEventTouchUpInside];
    //    [_navView addSubview:_rightBtn];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 63, MainW, 0.5)];
    line.backgroundColor  = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    [navView addSubview:line];
    
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [SVProgressHUD showWithStatus:@"加载中..."];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    [SVProgressHUD showErrorWithStatus:@"加载超时,请检查网络"];
}

- (void)backToLast{
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    app.rootTabbarVc.tabBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}
@end
