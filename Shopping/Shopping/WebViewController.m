//
//  WebViewController.m
//  MAPP
//
//  Created by kawa on 2015/10/15.
//  Copyright © 2015年 Branko. All rights reserved.
//

#import "WebViewController.h"
#import "SVProgressHUD.h"



@interface WebViewController ()<UIWebViewDelegate>
{
    UIButton *_btn_preview;
    UIButton *_btn_previous;
    UIButton *_btn_refresh;
}


@end

@implementation WebViewController
-(void)startwith:(NSString *)strurl
{

    NSURL *url = [NSURL URLWithString:strurl];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [commonweb loadRequest:req];
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    _btn_refresh.selected=YES;
    [SVProgressHUD showWithStatus:@"加载中..."];
    
}
//
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{

    return  YES;
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [SVProgressHUD dismiss];
    [SVProgressHUD dismiss];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if ([commonweb canGoForward]) {
        _btn_preview.selected=NO;
    }else{
        _btn_preview.selected=YES;
    }
    if ([commonweb canGoBack]) {
        _btn_previous.selected=NO;
    }else{
        _btn_previous.selected=YES;
    }
    _btn_refresh.selected=NO;
    [SVProgressHUD dismiss];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    [SVProgressHUD showErrorWithStatus:@"加载失败，请重试。"];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:NO];
    [super viewWillAppear:animated];
    if (self.isNeedHidingRightItem) {
        self.navigationItem.rightBarButtonItem=nil;
    }
    
}

@end
